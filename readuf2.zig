const builtin = @import("builtin");
const std = @import("std");

const MappedFile = @import("MappedFile.zig");

pub fn fatal(comptime fmt: []const u8, args: anytype) noreturn {
    std.log.err(fmt, args);
    std.os.exit(0xff);
}

pub fn oom(e: error{OutOfMemory}) noreturn {
    fatal("{s}", .{@errorName(e)});
}


var windows_args_arena = if (builtin.os.tag == .windows)
    std.heap.ArenaAllocator.init(std.heap.page_allocator) else struct{}{};

pub fn cmdlineArgs() [][*:0]u8 {
    if (builtin.os.tag == .windows) {
        const slices = std.process.argsAlloc(windows_args_arena.allocator()) catch |err| switch (err) {
            error.OutOfMemory => oom(error.OutOfMemory),
            error.InvalidCmdLine => @panic("InvalidCmdLine"),
            error.Overflow => @panic("Overflow while parsing command line"),
        };
        const args = windows_args_arena.allocator().alloc([*:0]u8, slices.len - 1) catch |e| oom(e);
        for (slices[1..], 0..) |slice, i| {
            args[i] = slice.ptr;
        }
        return args;
    }
    return std.os.argv.ptr[1 .. std.os.argv.len];
}

pub fn main() !u8 {

    const args = blk: {
        const all_args = cmdlineArgs();
        var non_option_len: usize = 0;
        for (all_args) |arg_ptr| {
            const arg = std.mem.span(arg_ptr);
            if (!std.mem.startsWith(u8, arg, "-")) {
                all_args[non_option_len] = arg;
                non_option_len += 1;
            } else {
                fatal("unknown cmdline option '{s}'", .{arg});
            }
        }
        break :blk all_args[0 .. non_option_len];
    };

    if (args.len == 0) {
        try std.io.getStdErr().writer().writeAll("Usage: readuf2 FILE\n");
        return 0xff;
    }
    if (args.len != 1)
        fatal("expected 1 cmdline arg but got {}", .{args.len});

    const filename = std.mem.span(args[0]);
    const mapped = MappedFile.init(filename, .{}) catch |e|
        fatal("failed to map file '{s}': {s}", .{filename, @errorName(e)});
    defer mapped.unmap();

    return readuf2(mapped.mem);
}

const uf2_flag_family_id_present: u32 = 0x00002000;

fn readuf2(mem: []const u8) !u8 {
    const stdout = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout);
    const writer = bw.writer();

    var block_index: usize = 0;

    while (true) : (block_index += 1) {
        const offset = block_index * 512;
        if (offset == mem.len)
            break;
        if (offset + 512 > mem.len) {
            const len = mem.len - offset;
            fatal("last block (offset {}) is only {} bytes (need 512)", .{offset, len});
        }
        
        //std.log.info("block {}", .{block_index});
        const block = mem[offset..][0..512];
        {
            const first_magic = std.mem.readIntLittle(u32, block[0..][0..4]);
            const second_magic = std.mem.readIntLittle(u32, block[4..][0..4]);
            if (first_magic != 0x0a324655 or second_magic != 0x9e5d5157) {
                try writer.print(
                    "{}: bad start magic 0x{x:0>8}{x:0>8}\n",
                    .{block_index, first_magic, second_magic},
                );
                continue;
            }
        }
        {
            const last_magic = std.mem.readIntLittle(u32, block[508..][0..4]);
            if (last_magic != 0x0ab16f30) {
                try writer.print(
                    "{}: bad final magic 0x{x:0>8}\n",
                    .{block_index, last_magic},
                );
                continue;
            }

        }

        const flags = std.mem.readIntLittle(u32, block[8..][0..4]);
        const target_addr = std.mem.readIntLittle(u32, block[12..][0..4]);
        const data_len = std.mem.readIntLittle(u32, block[16..][0..4]);
        const blockno = std.mem.readIntLittle(u32, block[20..][0..4]);
        const block_count = std.mem.readIntLittle(u32, block[24..][0..4]);
        const fileSizeOrFamily = std.mem.readIntLittle(u32, block[28..][0..4]);
        try writer.print(
            "{}: flags=0x{x} addr=0x{x} data_len={} blockno={} block_count={}",
            .{ block_index, flags, target_addr, data_len, blockno, block_count },
        );
        if (0 != (flags & uf2_flag_family_id_present)) {
            try writer.print(" family=0x{x}", .{fileSizeOrFamily});
        } else if (fileSizeOrFamily == 0) {
        } else {
            try writer.print(" fileSize={}", .{fileSizeOrFamily});
        }
        try writer.writeAll("\n");
    }

    try bw.flush();
    return 0;
}
