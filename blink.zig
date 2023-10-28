comptime { _ = @import("samd51j19a/startup.zig"); }

const def = @import("samd51j19a/def.zig");
const arcade_pybadge_lc = @import("samd51j19a/arcade_pybadge_lc.zig");

pub fn panic(msg: []const u8, trace: ?*@import("std").builtin.StackTrace, addr: ?usize) noreturn {
    _ = msg;
    _ = trace;
    _ = addr;
    while (true) { }
}
pub const vectors = struct {
    pub fn sysTickHandler() callconv(.C) void {
        //led_tick();
    }
};

fn pinDirSet(comptime pin: comptime_int) void {
    def.port.group[@divTrunc(pin, 32)].DIRSET = (1 << (pin % 32));
}
fn pinOutSet(comptime pin: comptime_int) void {
    def.port.group[@divTrunc(pin, 32)].OUTSET = (1 << (pin % 32));
}
fn pinOutClr(comptime pin: comptime_int) void {
    def.port.group[@divTrunc(pin, 32)].OUTCLR = (1 << (pin % 32));
}

fn ledMscOn() void { pinOutSet(arcade_pybadge_lc.LED_PIN); }
fn ledMscOff() void { pinOutClr(arcade_pybadge_lc.LED_PIN); }
fn delay(ms: u32) void {
    // These multipliers were determined empirically and are only approximate.
    // After the pulsing LED is enabled (led_tick_on), the multipliers need to change
    // due to the interrupt overhead of the pulsing.
    // SAMD51 starts up at 48MHz by default, and we set the clock to
    // 48MHz, so we don't need to adjust for current_cpu_frequency_MHz.
    var count: u32 = ms * 6000;
    for (0 .. count) |_| {
        asm volatile("nop");
    }
}

pub fn main() void {
    pinDirSet(arcade_pybadge_lc.LED_PIN);
    ledMscOff();

    while (true) {
        delay(100);
        ledMscOn();
        delay(100);
        ledMscOff();
    }
}
