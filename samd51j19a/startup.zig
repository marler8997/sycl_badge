const cortexm4 = @import("cortexm4.zig");
const def = @import("def.zig");

export const exception_table linksection(".vectors") = def.Vectors{
    .pvStack = &_estack,
    .pfnReset_Handler = resetHandler,
};

// Initialize segments
extern const _sfixed: u32;
extern const _efixed: u32;
extern const _etext: u32;
extern const _srelocate: u32;
extern const _erelocate: u32;
extern const _szero: u32;
extern const _ezero: u32;
extern const _sstack: u32;
extern const _estack: u32;

// This is the code that gets called on processor reset.
// To initialize the device, and call the main() routine.
fn resetHandler() callconv(.C) void {
    // Initialize the relocate segment
    {
        var src = &_etext;
        var dst = &_srelocate;
        if (src != dst) {
            while (@intFromPtr(dst) < @intFromPtr(&_erelocate)) {
                dst.* = src.*;
                dst = @ptrFromInt(@intFromPtr(dst) + 4);
                src = @ptrFromInt(@intFromPtr(src) + 4);
            }
        }
    }

    // Clear the zero segment
    {
        var dst = &_szero;
        while (@intFromPtr(dst) < @intFromPtr(&_ezero)) : (dst = @ptrFromInt(@intFromPtr(dst) + 4)) {
            dst.* = 0;
        }
    }

    // Set the vector table base address
    {
        const src = &_sfixed;
        cortexm4.scb.VTOR = @intFromPtr(src) & cortexm4.scb_vtor_tbloff_msk;
    }

//#if __FPU_USED
//        /* Enable FPU */
//        SCB->CPACR |=  (0xFu << 20);
//        __DSB();
//        __ISB();
//#endif

    @import("root").main();
    while (true) { }
}

