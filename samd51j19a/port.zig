pub const PortGroup = extern struct {
    DIR: u32,         // Offset: 0x00 (R/W 32) Data Direction
    DIRCLR: u32,      // Offset: 0x04 (R/W 32) Data Direction Clear
    DIRSET: u32,      // Offset: 0x08 (R/W 32) Data Direction Set
    DIRTGL: u32,      // Offset: 0x0C (R/W 32) Data Direction Toggle
    OUT: u32,         // Offset: 0x10 (R/W 32) Data Output Value
    OUTCLR: u32,      // Offset: 0x14 (R/W 32) Data Output Value Clear
    OUTSET: u32,      // Offset: 0x18 (R/W 32) Data Output Value Set
    OUTTGL: u32,      // Offset: 0x1C (R/W 32) Data Output Value Toggle
    IN: u32,          // Offset: 0x20 (R/  32) Data Input Value
    CTRL: u32,        // Offset: 0x24 (R/W 32) Control
    WRCONFIG: u32,    // Offset: 0x28 ( /W 32) Write Configuration
    EVCTRL: u32,      // Offset: 0x2C (R/W 32) Event Input Control
    PMUX: [16]u8,    // Offset: 0x30 (R/W  8) Peripheral Multiplexing
    PINCFG: [32]u8,  // Offset: 0x40 (R/W  8) Pin Configuration
    Reserved1: u8,
};

pub const Port = extern struct {
    group: [4]PortGroup,
};
