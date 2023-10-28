pub const Scb = extern struct {
    CPUID: u32,         // Offset: 0x000 (R/ )  CPUID Base Register
    ICSR: u32,          // Offset: 0x004 (R/W)  Interrupt Control and State Register
    VTOR: u32,          // Offset: 0x008 (R/W)  Vector Table Offset Register
    AIRCR: u32,         // Offset: 0x00C (R/W)  Application Interrupt and Reset Control Register
    SCR: u32,           // Offset: 0x010 (R/W)  System Control Register
    CCR: u32,           // Offset: 0x014 (R/W)  Configuration Control Register
    SHP: [12]u32,       // Offset: 0x018 (R/W)  System Handlers Priority Registers (4-7, 8-11, 12-15)
    SHCSR: u32,         // Offset: 0x024 (R/W)  System Handler Control and State Register
    CFSR: u32,          // Offset: 0x028 (R/W)  Configurable Fault Status Register
    HFSR: u32,          // Offset: 0x02C (R/W)  HardFault Status Register
    DFSR: u32,          // Offset: 0x030 (R/W)  Debug Fault Status Register
    MMFAR: u32,         // Offset: 0x034 (R/W)  MemManage Fault Address Register
    BFAR: u32,          // Offset: 0x038 (R/W)  BusFault Address Register
    AFSR: u32,          // Offset: 0x03C (R/W)  Auxiliary Fault Status Register
    PFR: [2]u32,        // Offset: 0x040 (R/ )  Processor Feature Register
    DFR: u32,           // Offset: 0x048 (R/ )  Debug Feature Register
    ADR: u32,           // Offset: 0x04C (R/ )  Auxiliary Feature Register
    MMFR: [4]u32,       // Offset: 0x050 (R/ )  Memory Model Feature Register
    ISAR: [5]u32,       // Offset: 0x060 (R/ )  Instruction Set Attributes Register
    RESERVED0: [5]u32,
    CPACR: u32,         // Offset: 0x088 (R/W)  Coprocessor Access Control Register
};
const scb_vtor_tbloff_pos = 7;
pub const scb_vtor_tbloff_msk: u32 = (0x1ffffff << scb_vtor_tbloff_pos);

// Memory mapping of Cortex-M4 Hardware
const scs_base        : u32 = 0xE000E000;                            // System Control Space Base Address
const itm_base        : u32 = 0xE0000000;                            // ITM Base Address
const dwt_base        : u32 = 0xE0001000;                            // DWT Base Address
const tpi_base        : u32 = 0xE0040000;                            // TPI Base Address
const core_debug_base : u32 = 0xE000EDF0;                            // Core Debug Base Address
const sys_tick_base   : u32 = scs_base +  0x0010;                    // SysTick Base Address
const nvic_base       : u32 = scs_base +  0x0100;                    // NVIC Base Address
const scb_base        : u32 = scs_base +  0x0D00;                    // System Control Block Base Address

//const SCnSCB        : (SCnSCB_Type    *)     scs_base      )   // System control Register not in SCB
pub const scb         : *Scb = @ptrFromInt(scb_base);   // SCB configuration struct
//const SysTick       : (SysTick_Type   *)     sys_tick_base  )   // SysTick configuration struct
//const NVIC          : (NVIC_Type      *)     nvic_base     )   // NVIC configuration struct
//const ITM           : (ITM_Type       *)     itm_base      )   // ITM configuration struct
//const DWT           : (DWT_Type       *)     dwt_base      )   // DWT configuration struct
//const TPI           : (TPI_Type       *)     tpi_base      )   // TPI configuration struct
//const CoreDebug     : (CoreDebug_Type *)     core_debug_base)   // Core Debug configuration struct
