// Tested with zig version 0.11.0
const std = @import("std");
const GitRepoStep = @import("GitRepoStep.zig");

pub const atsamd51j19 = .{
    .name = "ATSAMD51J19A",
    .url = "https://www.microchip.com/en-us/product/ATSAMD51J19A",
    .cpu = .cortex_m4,
    .register_definition = .{
        .atdf = .{ .path = "./board/ATSAMD51J19A.atdf" },
    },
    .memory_regions = &.{
        .{ .kind = .flash, .offset = 0x00000000, .length = 512 * 1024 }, // Embedded Flash
        .{ .kind = .ram, .offset = 0x20000000, .length = 192 * 1024 }, // Embedded SRAM
        .{ .kind = .ram, .offset = 0x47000000, .length = 8 * 1024 }, // Backup SRAM
        .{ .kind = .flash, .offset = 0x00804000, .length = 512 }, // NVM User Row
    },
};

pub const py_badge = .{
    // TODO: switch to uf2
    .preferred_format = .bin,
    .chip = atsamd51j19,
    .hal = null,
    .linker_script = .{ .source_file = .{ .path = "samd51j19a/link.ld" } },
    // .board = .{
    //     .name = "RaspberryPi Pico",
    //     .source_file = .{ .cwd_relative = build_root ++ "/src/boards/raspberry_pi_pico.zig" },
    //     .url = "https://learn.adafruit.com/adafruit-pybadge/downloads",
    // },
    // .configure = rp2040_configure(.w25q080),
};

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const uf2_repo = GitRepoStep.create(b, .{
        .url = "https://github.com/Microsoft/uf2",
        .sha = "adbb8c7260f938e810eb37f2287f8e1a055ff402",
        .fetch_enabled = true,
    });
    b.default_step.dependOn(&uf2_repo.step);

    const uf2_samdx1_repo = GitRepoStep.create(b, .{
        .url = "https://github.com/adafruit/uf2-samdx1",
        .sha = "979cad018af66c38c98b382a79f4f359b3843ea1",
        .branch = "v3.15.0",
        .fetch_enabled = true,
    });
    b.default_step.dependOn(&uf2_samdx1_repo.step);

    {
        const exe = b.addExecutable(.{
            .name = "readuf2",
            .root_source_file = .{ .path = "readuf2.zig" },
            .target = target,
            .optimize = optimize,
        });

        b.installArtifact(exe);

        const run_cmd = b.addRunArtifact(exe);
        run_cmd.step.dependOn(b.getInstallStep());
        if (b.args) |args| {
            run_cmd.addArgs(args);
        }
        const run_step = b.step("run-readuf2", "Run the app");
        run_step.dependOn(&run_cmd.step);
    }

    //const microzig = @import("microzig").init(b, "microzig");
    //{
    //    const firmware = microzig.addFirmware(b, .{
    //        .name = "blink",
    //        .target = py_badge,
    //        .optimize = optimize,
    //        .source_file = .{ .path = "blink.zig" },
    //    });
    //    microzig.installFirmware(b, firmware, .{});
    //}

    const pybadge_target = @import("microzig").cpus.cortex_m4.target;
    {
        const exe = b.addExecutable(.{
            .name = "blink",
            .root_source_file = .{ .path = "blink.zig" },
            .target = pybadge_target,
            .optimize = optimize,
        });
        exe.setLinkerScriptPath(.{ .path = "samd51j19a/link.ld" });
        // TODO: add linker flag to set STACK_SIZE for linker script?
        b.installArtifact(exe);
    }
}
