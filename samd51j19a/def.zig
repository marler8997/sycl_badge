const Port = @import("port.zig").Port;

fn loopForever() callconv(.C) void {
    while (true) { }
}

const root = @import("root");
const root_vectors = if (@hasDecl(root, "vectors")) root.vectors else struct { };
fn getInterrupt(comptime name: []const u8, default: ?*const fn() callconv(.C) void) ?*const fn() callconv(.C) void {
    if (@hasDecl(root_vectors, name)) return @field(root_vectors, name) else default;
}

pub const Vectors = extern struct {
    // Stack pointer
    pvStack: *anyopaque,

    // Cortex-M handlers
    pfnReset_Handler: ?*const fn() callconv(.C) void,
    pfnNMI_Handler: ?*const fn() callconv(.C) void = loopForever,
    pfnHardFault_Handler: ?*const fn() callconv(.C) void = loopForever,
    pfnMemManage_Handler: ?*const fn() callconv(.C) void = loopForever,
    pfnBusFault_Handler: ?*const fn() callconv(.C) void = loopForever,
    pfnUsageFault_Handler: ?*const fn() callconv(.C) void = loopForever,
    pvReservedM9: ?*const fn() callconv(.C) void = null,
    pvReservedM8: ?*const fn() callconv(.C) void = null,
    pvReservedM7: ?*const fn() callconv(.C) void = null,
    pvReservedM6: ?*const fn() callconv(.C) void = null,
    pfnSVC_Handler: ?*const fn() callconv(.C) void = loopForever,
    pfnDebugMon_Handler: ?*const fn() callconv(.C) void = loopForever,
    pvReservedM3: ?*const fn() callconv(.C) void = null,
    pfnPendSV_Handler: ?*const fn() callconv(.C) void = loopForever,
    pfnSysTick_Handler: ?*const fn() callconv(.C) void = getInterrupt("sysTickHandler", loopForever),
    // Peripheral handlers
    pfnPM_Handler: ?*const fn() callconv(.C) void = loopForever,                    //  0 Power Manager
    pfnMCLK_Handler: ?*const fn() callconv(.C) void = loopForever,                  //  1 Main Clock
    pfnOSCCTRL_0_Handler: ?*const fn() callconv(.C) void = loopForever,             //  2 Oscillators Control IRQ 0
    pfnOSCCTRL_1_Handler: ?*const fn() callconv(.C) void = loopForever,             //  3 Oscillators Control IRQ 1
    pfnOSCCTRL_2_Handler: ?*const fn() callconv(.C) void = loopForever,             //  4 Oscillators Control IRQ 2
    pfnOSCCTRL_3_Handler: ?*const fn() callconv(.C) void = loopForever,             //  5 Oscillators Control IRQ 3
    pfnOSCCTRL_4_Handler: ?*const fn() callconv(.C) void = loopForever,             //  6 Oscillators Control IRQ 4
    pfnOSC32KCTRL_Handler: ?*const fn() callconv(.C) void = loopForever,            //  7 32kHz Oscillators Control
    pfnSUPC_0_Handler: ?*const fn() callconv(.C) void = loopForever,                //  8 Supply Controller IRQ 0
    pfnSUPC_1_Handler: ?*const fn() callconv(.C) void = loopForever,                //  9 Supply Controller IRQ 1
    pfnWDT_Handler: ?*const fn() callconv(.C) void = loopForever,                   // 10 Watchdog Timer
    pfnRTC_Handler: ?*const fn() callconv(.C) void = loopForever,                   // 11 Real-Time Counter
    pfnEIC_0_Handler: ?*const fn() callconv(.C) void = loopForever,                 // 12 External Interrupt Controller IRQ 0
    pfnEIC_1_Handler: ?*const fn() callconv(.C) void = loopForever,                 // 13 External Interrupt Controller IRQ 1
    pfnEIC_2_Handler: ?*const fn() callconv(.C) void = loopForever,                 // 14 External Interrupt Controller IRQ 2
    pfnEIC_3_Handler: ?*const fn() callconv(.C) void = loopForever,                 // 15 External Interrupt Controller IRQ 3
    pfnEIC_4_Handler: ?*const fn() callconv(.C) void = loopForever,                 // 16 External Interrupt Controller IRQ 4
    pfnEIC_5_Handler: ?*const fn() callconv(.C) void = loopForever,                 // 17 External Interrupt Controller IRQ 5
    pfnEIC_6_Handler: ?*const fn() callconv(.C) void = loopForever,                 // 18 External Interrupt Controller IRQ 6
    pfnEIC_7_Handler: ?*const fn() callconv(.C) void = loopForever,                 // 19 External Interrupt Controller IRQ 7
    pfnEIC_8_Handler: ?*const fn() callconv(.C) void = loopForever,                 // 20 External Interrupt Controller IRQ 8
    pfnEIC_9_Handler: ?*const fn() callconv(.C) void = loopForever,                 // 21 External Interrupt Controller IRQ 9
    pfnEIC_10_Handler: ?*const fn() callconv(.C) void = loopForever,                // 22 External Interrupt Controller IRQ 10
    pfnEIC_11_Handler: ?*const fn() callconv(.C) void = loopForever,                // 23 External Interrupt Controller IRQ 11
    pfnEIC_12_Handler: ?*const fn() callconv(.C) void = loopForever,                // 24 External Interrupt Controller IRQ 12
    pfnEIC_13_Handler: ?*const fn() callconv(.C) void = loopForever,                // 25 External Interrupt Controller IRQ 13
    pfnEIC_14_Handler: ?*const fn() callconv(.C) void = loopForever,                // 26 External Interrupt Controller IRQ 14
    pfnEIC_15_Handler: ?*const fn() callconv(.C) void = loopForever,                // 27 External Interrupt Controller IRQ 15
    pfnFREQM_Handler: ?*const fn() callconv(.C) void = loopForever,                 // 28 Frequency Meter
    pfnNVMCTRL_0_Handler: ?*const fn() callconv(.C) void = loopForever,             // 29 Non-Volatile Memory Controller IRQ 0
    pfnNVMCTRL_1_Handler: ?*const fn() callconv(.C) void = loopForever,             // 30 Non-Volatile Memory Controller IRQ 1
    pfnDMAC_0_Handler: ?*const fn() callconv(.C) void = loopForever,                // 31 Direct Memory Access Controller IRQ 0
    pfnDMAC_1_Handler: ?*const fn() callconv(.C) void = loopForever,                // 32 Direct Memory Access Controller IRQ 1
    pfnDMAC_2_Handler: ?*const fn() callconv(.C) void = loopForever,                // 33 Direct Memory Access Controller IRQ 2
    pfnDMAC_3_Handler: ?*const fn() callconv(.C) void = loopForever,                // 34 Direct Memory Access Controller IRQ 3
    pfnDMAC_4_Handler: ?*const fn() callconv(.C) void = loopForever,                // 35 Direct Memory Access Controller IRQ 4
    pfnEVSYS_0_Handler: ?*const fn() callconv(.C) void = loopForever,               // 36 Event System Interface IRQ 0
    pfnEVSYS_1_Handler: ?*const fn() callconv(.C) void = loopForever,               // 37 Event System Interface IRQ 1
    pfnEVSYS_2_Handler: ?*const fn() callconv(.C) void = loopForever,               // 38 Event System Interface IRQ 2
    pfnEVSYS_3_Handler: ?*const fn() callconv(.C) void = loopForever,               // 39 Event System Interface IRQ 3
    pfnEVSYS_4_Handler: ?*const fn() callconv(.C) void = loopForever,               // 40 Event System Interface IRQ 4
    pfnPAC_Handler: ?*const fn() callconv(.C) void = loopForever,                   // 41 Peripheral Access Controller
    pfnTAL_0_Handler: ?*const fn() callconv(.C) void = loopForever,
    pfnTAL_1_Handler: ?*const fn() callconv(.C) void = loopForever,
    pvReserved44: ?*const fn() callconv(.C) void = null,
    pfnRAMECC_Handler: ?*const fn() callconv(.C) void = loopForever,                // 45 RAM ECC
    pfnSERCOM0_0_Handler: ?*const fn() callconv(.C) void = loopForever,             // 46 Serial Communication Interface 0 IRQ 0
    pfnSERCOM0_1_Handler: ?*const fn() callconv(.C) void = loopForever,             // 47 Serial Communication Interface 0 IRQ 1
    pfnSERCOM0_2_Handler: ?*const fn() callconv(.C) void = loopForever,             // 48 Serial Communication Interface 0 IRQ 2
    pfnSERCOM0_3_Handler: ?*const fn() callconv(.C) void = loopForever,             // 49 Serial Communication Interface 0 IRQ 3
    pfnSERCOM1_0_Handler: ?*const fn() callconv(.C) void = loopForever,             // 50 Serial Communication Interface 1 IRQ 0
    pfnSERCOM1_1_Handler: ?*const fn() callconv(.C) void = loopForever,             // 51 Serial Communication Interface 1 IRQ 1
    pfnSERCOM1_2_Handler: ?*const fn() callconv(.C) void = loopForever,             // 52 Serial Communication Interface 1 IRQ 2
    pfnSERCOM1_3_Handler: ?*const fn() callconv(.C) void = loopForever,             // 53 Serial Communication Interface 1 IRQ 3
    pfnSERCOM2_0_Handler: ?*const fn() callconv(.C) void = loopForever,             // 54 Serial Communication Interface 2 IRQ 0
    pfnSERCOM2_1_Handler: ?*const fn() callconv(.C) void = loopForever,             // 55 Serial Communication Interface 2 IRQ 1
    pfnSERCOM2_2_Handler: ?*const fn() callconv(.C) void = loopForever,             // 56 Serial Communication Interface 2 IRQ 2
    pfnSERCOM2_3_Handler: ?*const fn() callconv(.C) void = loopForever,             // 57 Serial Communication Interface 2 IRQ 3
    pfnSERCOM3_0_Handler: ?*const fn() callconv(.C) void = loopForever,             // 58 Serial Communication Interface 3 IRQ 0
    pfnSERCOM3_1_Handler: ?*const fn() callconv(.C) void = loopForever,             // 59 Serial Communication Interface 3 IRQ 1
    pfnSERCOM3_2_Handler: ?*const fn() callconv(.C) void = loopForever,             // 60 Serial Communication Interface 3 IRQ 2
    pfnSERCOM3_3_Handler: ?*const fn() callconv(.C) void = loopForever,             // 61 Serial Communication Interface 3 IRQ 3
    pfnSERCOM4_0_Handler: ?*const fn() callconv(.C) void = loopForever,             // 62 Serial Communication Interface 4 IRQ 0
    pfnSERCOM4_1_Handler: ?*const fn() callconv(.C) void = loopForever,             // 63 Serial Communication Interface 4 IRQ 1
    pfnSERCOM4_2_Handler: ?*const fn() callconv(.C) void = loopForever,             // 64 Serial Communication Interface 4 IRQ 2
    pfnSERCOM4_3_Handler: ?*const fn() callconv(.C) void = loopForever,             // 65 Serial Communication Interface 4 IRQ 3
    pfnSERCOM5_0_Handler: ?*const fn() callconv(.C) void = loopForever,             // 66 Serial Communication Interface 5 IRQ 0
    pfnSERCOM5_1_Handler: ?*const fn() callconv(.C) void = loopForever,             // 67 Serial Communication Interface 5 IRQ 1
    pfnSERCOM5_2_Handler: ?*const fn() callconv(.C) void = loopForever,             // 68 Serial Communication Interface 5 IRQ 2
    pfnSERCOM5_3_Handler: ?*const fn() callconv(.C) void = loopForever,             // 69 Serial Communication Interface 5 IRQ 3
    pvReserved70: ?*const fn() callconv(.C) void = null,
    pvReserved71: ?*const fn() callconv(.C) void = null,
    pvReserved72: ?*const fn() callconv(.C) void = null,
    pvReserved73: ?*const fn() callconv(.C) void = null,
    pvReserved74: ?*const fn() callconv(.C) void = null,
    pvReserved75: ?*const fn() callconv(.C) void = null,
    pvReserved76: ?*const fn() callconv(.C) void = null,
    pvReserved77: ?*const fn() callconv(.C) void = null,
    pfnCAN0_Handler: ?*const fn() callconv(.C) void = loopForever,                  // 78 Control Area Network 0
    pfnCAN1_Handler: ?*const fn() callconv(.C) void = loopForever,                  // 79 Control Area Network 1
    pfnUSB_0_Handler: ?*const fn() callconv(.C) void = loopForever,                 // 80 Universal Serial Bus IRQ 0
    pfnUSB_1_Handler: ?*const fn() callconv(.C) void = loopForever,                 // 81 Universal Serial Bus IRQ 1
    pfnUSB_2_Handler: ?*const fn() callconv(.C) void = loopForever,                 // 82 Universal Serial Bus IRQ 2
    pfnUSB_3_Handler: ?*const fn() callconv(.C) void = loopForever,                 // 83 Universal Serial Bus IRQ 3
    pvReserved84: ?*const fn() callconv(.C) void = null,
    pfnTCC0_0_Handler: ?*const fn() callconv(.C) void = loopForever,                // 85 Timer Counter Control 0 IRQ 0
    pfnTCC0_1_Handler: ?*const fn() callconv(.C) void = loopForever,                // 86 Timer Counter Control 0 IRQ 1
    pfnTCC0_2_Handler: ?*const fn() callconv(.C) void = loopForever,                // 87 Timer Counter Control 0 IRQ 2
    pfnTCC0_3_Handler: ?*const fn() callconv(.C) void = loopForever,                // 88 Timer Counter Control 0 IRQ 3
    pfnTCC0_4_Handler: ?*const fn() callconv(.C) void = loopForever,                // 89 Timer Counter Control 0 IRQ 4
    pfnTCC0_5_Handler: ?*const fn() callconv(.C) void = loopForever,                // 90 Timer Counter Control 0 IRQ 5
    pfnTCC0_6_Handler: ?*const fn() callconv(.C) void = loopForever,                // 91 Timer Counter Control 0 IRQ 6
    pfnTCC1_0_Handler: ?*const fn() callconv(.C) void = loopForever,                // 92 Timer Counter Control 1 IRQ 0
    pfnTCC1_1_Handler: ?*const fn() callconv(.C) void = loopForever,                // 93 Timer Counter Control 1 IRQ 1
    pfnTCC1_2_Handler: ?*const fn() callconv(.C) void = loopForever,                // 94 Timer Counter Control 1 IRQ 2
    pfnTCC1_3_Handler: ?*const fn() callconv(.C) void = loopForever,                // 95 Timer Counter Control 1 IRQ 3
    pfnTCC1_4_Handler: ?*const fn() callconv(.C) void = loopForever,                // 96 Timer Counter Control 1 IRQ 4
    pfnTCC2_0_Handler: ?*const fn() callconv(.C) void = loopForever,                // 97 Timer Counter Control 2 IRQ 0
    pfnTCC2_1_Handler: ?*const fn() callconv(.C) void = loopForever,                // 98 Timer Counter Control 2 IRQ 1
    pfnTCC2_2_Handler: ?*const fn() callconv(.C) void = loopForever,                // 99 Timer Counter Control 2 IRQ 2
    pfnTCC2_3_Handler: ?*const fn() callconv(.C) void = loopForever,                // 100 Timer Counter Control 2 IRQ 3
    pfnTCC3_0_Handler: ?*const fn() callconv(.C) void = loopForever,                // 101 Timer Counter Control 3 IRQ 0
    pfnTCC3_1_Handler: ?*const fn() callconv(.C) void = loopForever,                // 102 Timer Counter Control 3 IRQ 1
    pfnTCC3_2_Handler: ?*const fn() callconv(.C) void = loopForever,                // 103 Timer Counter Control 3 IRQ 2
    pfnTCC4_0_Handler: ?*const fn() callconv(.C) void = loopForever,                // 104 Timer Counter Control 4 IRQ 0
    pfnTCC4_1_Handler: ?*const fn() callconv(.C) void = loopForever,                // 105 Timer Counter Control 4 IRQ 1
    pfnTCC4_2_Handler: ?*const fn() callconv(.C) void = loopForever,                // 106 Timer Counter Control 4 IRQ 2
    pfnTC0_Handler: ?*const fn() callconv(.C) void = loopForever,                   // 107 Basic Timer Counter 0
    pfnTC1_Handler: ?*const fn() callconv(.C) void = loopForever,                   // 108 Basic Timer Counter 1
    pfnTC2_Handler: ?*const fn() callconv(.C) void = loopForever,                   // 109 Basic Timer Counter 2
    pfnTC3_Handler: ?*const fn() callconv(.C) void = loopForever,                   // 110 Basic Timer Counter 3
    pfnTC4_Handler: ?*const fn() callconv(.C) void = loopForever,                   // 111 Basic Timer Counter 4
    pfnTC5_Handler: ?*const fn() callconv(.C) void = loopForever,                   // 112 Basic Timer Counter 5
    pvReserved113: ?*const fn() callconv(.C) void = null,
    pvReserved114: ?*const fn() callconv(.C) void = null,
    pfnPDEC_0_Handler: ?*const fn() callconv(.C) void = loopForever,                // 115 Quadrature Decodeur IRQ 0
    pfnPDEC_1_Handler: ?*const fn() callconv(.C) void = loopForever,                // 116 Quadrature Decodeur IRQ 1
    pfnPDEC_2_Handler: ?*const fn() callconv(.C) void = loopForever,                // 117 Quadrature Decodeur IRQ 2
    pfnADC0_0_Handler: ?*const fn() callconv(.C) void = loopForever,                // 118 Analog Digital Converter 0 IRQ 0
    pfnADC0_1_Handler: ?*const fn() callconv(.C) void = loopForever,                // 119 Analog Digital Converter 0 IRQ 1
    pfnADC1_0_Handler: ?*const fn() callconv(.C) void = loopForever,                // 120 Analog Digital Converter 1 IRQ 0
    pfnADC1_1_Handler: ?*const fn() callconv(.C) void = loopForever,                // 121 Analog Digital Converter 1 IRQ 1
    pfnAC_Handler: ?*const fn() callconv(.C) void = loopForever,                    // 122 Analog Comparators
    pfnDAC_0_Handler: ?*const fn() callconv(.C) void = loopForever,                 // 123 Digital-to-Analog Converter IRQ 0
    pfnDAC_1_Handler: ?*const fn() callconv(.C) void = loopForever,                 // 124 Digital-to-Analog Converter IRQ 1
    pfnDAC_2_Handler: ?*const fn() callconv(.C) void = loopForever,                 // 125 Digital-to-Analog Converter IRQ 2
    pfnDAC_3_Handler: ?*const fn() callconv(.C) void = loopForever,                 // 126 Digital-to-Analog Converter IRQ 3
    pfnDAC_4_Handler: ?*const fn() callconv(.C) void = loopForever,                 // 127 Digital-to-Analog Converter IRQ 4
    pfnI2S_Handler: ?*const fn() callconv(.C) void = loopForever,                   // 128 Inter-IC Sound Interface
    pfnPCC_Handler: ?*const fn() callconv(.C) void = loopForever,                   // 129 Parallel Capture Controller
    pfnAES_Handler: ?*const fn() callconv(.C) void = loopForever,                   // 130 Advanced Encryption Standard
    pfnTRNG_Handler: ?*const fn() callconv(.C) void = loopForever,                  // 131 True Random Generator
    pfnICM_Handler: ?*const fn() callconv(.C) void = loopForever,                   // 132 Integrity Check Monitor
    pfnPUKCC_Handler: ?*const fn() callconv(.C) void = loopForever,                 // 133 PUblic-Key Cryptography Controller
    pfnQSPI_Handler: ?*const fn() callconv(.C) void = loopForever,                  // 134 Quad SPI interface
    pfnSDHC0_Handler: ?*const fn() callconv(.C) void = loopForever,                 // 135 SD/MMC Host Controller 0
    pvReserved136: ?*const fn() callconv(.C) void = null,
};

//* **************************************************************************
//**  PERIPHERAL ID DEFINITIONS FOR SAME51J19A
//* **************************************************************************
//** \defgroup SAME51J19A_id Peripheral Ids Definitions
//*@{
//
// Peripheral instances on HPB0 bridge
//#define ID_PAC            0 /**< \brief Peripheral Access Controller (PAC)
//#define ID_PM             1 /**< \brief Power Manager (PM)
//#define ID_MCLK           2 /**< \brief Main Clock (MCLK)
//#define ID_RSTC           3 /**< \brief Reset Controller (RSTC)
//#define ID_OSCCTRL        4 /**< \brief Oscillators Control (OSCCTRL)
//#define ID_OSC32KCTRL     5 /**< \brief 32kHz Oscillators Control (OSC32KCTRL)
//#define ID_SUPC           6 /**< \brief Supply Controller (SUPC)
//#define ID_GCLK           7 /**< \brief Generic Clock Generator (GCLK)
//#define ID_WDT            8 /**< \brief Watchdog Timer (WDT)
//#define ID_RTC            9 /**< \brief Real-Time Counter (RTC)
//#define ID_EIC           10 /**< \brief External Interrupt Controller (EIC)
//#define ID_FREQM         11 /**< \brief Frequency Meter (FREQM)
//#define ID_SERCOM0       12 /**< \brief Serial Communication Interface 0 (SERCOM0)
//#define ID_SERCOM1       13 /**< \brief Serial Communication Interface 1 (SERCOM1)
//#define ID_TC0           14 /**< \brief Basic Timer Counter 0 (TC0)
//#define ID_TC1           15 /**< \brief Basic Timer Counter 1 (TC1)
//
// Peripheral instances on HPB1 bridge
//#define ID_USB           32 /**< \brief Universal Serial Bus (USB)
//#define ID_DSU           33 /**< \brief Device Service Unit (DSU)
//#define ID_NVMCTRL       34 /**< \brief Non-Volatile Memory Controller (NVMCTRL)
//#define ID_CMCC          35 /**< \brief Cortex M Cache Controller (CMCC)
//#define ID_PORT          36 /**< \brief Port Module (PORT)
//#define ID_DMAC          37 /**< \brief Direct Memory Access Controller (DMAC)
//#define ID_HMATRIX       38 /**< \brief HSB Matrix (HMATRIX)
//#define ID_EVSYS         39 /**< \brief Event System Interface (EVSYS)
//#define ID_SERCOM2       41 /**< \brief Serial Communication Interface 2 (SERCOM2)
//#define ID_SERCOM3       42 /**< \brief Serial Communication Interface 3 (SERCOM3)
//#define ID_TCC0          43 /**< \brief Timer Counter Control 0 (TCC0)
//#define ID_TCC1          44 /**< \brief Timer Counter Control 1 (TCC1)
//#define ID_TC2           45 /**< \brief Basic Timer Counter 2 (TC2)
//#define ID_TC3           46 /**< \brief Basic Timer Counter 3 (TC3)
//#define ID_RAMECC        48 /**< \brief RAM ECC (RAMECC)
//
// Peripheral instances on HPB2 bridge
//#define ID_CAN0          64 /**< \brief Control Area Network 0 (CAN0)
//#define ID_CAN1          65 /**< \brief Control Area Network 1 (CAN1)
//#define ID_TCC2          67 /**< \brief Timer Counter Control 2 (TCC2)
//#define ID_TCC3          68 /**< \brief Timer Counter Control 3 (TCC3)
//#define ID_TC4           69 /**< \brief Basic Timer Counter 4 (TC4)
//#define ID_TC5           70 /**< \brief Basic Timer Counter 5 (TC5)
//#define ID_PDEC          71 /**< \brief Quadrature Decodeur (PDEC)
//#define ID_AC            72 /**< \brief Analog Comparators (AC)
//#define ID_AES           73 /**< \brief Advanced Encryption Standard (AES)
//#define ID_TRNG          74 /**< \brief True Random Generator (TRNG)
//#define ID_ICM           75 /**< \brief Integrity Check Monitor (ICM)
//#define ID_PUKCC         76 /**< \brief PUblic-Key Cryptography Controller (PUKCC)
//#define ID_QSPI          77 /**< \brief Quad SPI interface (QSPI)
//#define ID_CCL           78 /**< \brief Configurable Custom Logic (CCL)
//
// Peripheral instances on HPB3 bridge
//#define ID_SERCOM4       96 /**< \brief Serial Communication Interface 4 (SERCOM4)
//#define ID_SERCOM5       97 /**< \brief Serial Communication Interface 5 (SERCOM5)
//#define ID_TCC4         100 /**< \brief Timer Counter Control 4 (TCC4)
//#define ID_ADC0         103 /**< \brief Analog Digital Converter 0 (ADC0)
//#define ID_ADC1         104 /**< \brief Analog Digital Converter 1 (ADC1)
//#define ID_DAC          105 /**< \brief Digital-to-Analog Converter (DAC)
//#define ID_I2S          106 /**< \brief Inter-IC Sound Interface (I2S)
//#define ID_PCC          107 /**< \brief Parallel Capture Controller (PCC)
//
// Peripheral instances on AHB (as if on bridge 4)
//#define ID_SDHC0        128 /**< \brief SD/MMC Host Controller (SDHC0)
//
//#define ID_PERIPH_COUNT 129 /**< \brief Max number of peripheral IDs
//*@}
//
//* **************************************************************************
//**  BASE ADDRESS DEFINITIONS FOR SAME51J19A
//* **************************************************************************
//** \defgroup SAME51J19A_base Peripheral Base Address Definitions
//*@{
//
//#if defined(__ASSEMBLY__) || defined(__IAR_SYSTEMS_ASM__)
//#define AC                            (0x42002000) /**< \brief (AC) APB Base Address
//#define ADC0                          (0x43001C00) /**< \brief (ADC0) APB Base Address
//#define ADC1                          (0x43002000) /**< \brief (ADC1) APB Base Address
//#define AES                           (0x42002400) /**< \brief (AES) APB Base Address
//#define CAN0                          (0x42000000) /**< \brief (CAN0) APB Base Address
//#define CAN1                          (0x42000400) /**< \brief (CAN1) APB Base Address
//#define CCL                           (0x42003800) /**< \brief (CCL) APB Base Address
//#define CMCC                          (0x41006000) /**< \brief (CMCC) APB Base Address
//#define CMCC_AHB                      (0x03000000) /**< \brief (CMCC) AHB Base Address
//#define DAC                           (0x43002400) /**< \brief (DAC) APB Base Address
//#define DMAC                          (0x4100A000) /**< \brief (DMAC) APB Base Address
//#define DSU                           (0x41002000) /**< \brief (DSU) APB Base Address
//#define EIC                           (0x40002800) /**< \brief (EIC) APB Base Address
//#define EVSYS                         (0x4100E000) /**< \brief (EVSYS) APB Base Address
//#define FREQM                         (0x40002C00) /**< \brief (FREQM) APB Base Address
//#define GCLK                          (0x40001C00) /**< \brief (GCLK) APB Base Address
//#define HMATRIX                       (0x4100C000) /**< \brief (HMATRIX) APB Base Address
//#define ICM                           (0x42002C00) /**< \brief (ICM) APB Base Address
//#define I2S                           (0x43002800) /**< \brief (I2S) APB Base Address
//#define MCLK                          (0x40000800) /**< \brief (MCLK) APB Base Address
//#define NVMCTRL                       (0x41004000) /**< \brief (NVMCTRL) APB Base Address
//#define NVMCTRL_SW0                   (0x00800080) /**< \brief (NVMCTRL) SW0 Base Address
//#define NVMCTRL_TEMP_LOG              (0x00800100) /**< \brief (NVMCTRL) TEMP_LOG Base Address
//#define NVMCTRL_USER                  (0x00804000) /**< \brief (NVMCTRL) USER Base Address
//#define OSCCTRL                       (0x40001000) /**< \brief (OSCCTRL) APB Base Address
//#define OSC32KCTRL                    (0x40001400) /**< \brief (OSC32KCTRL) APB Base Address
//#define PAC                           (0x40000000) /**< \brief (PAC) APB Base Address
//#define PCC                           (0x43002C00) /**< \brief (PCC) APB Base Address
//#define PDEC                          (0x42001C00) /**< \brief (PDEC) APB Base Address
//#define PM                            (0x40000400) /**< \brief (PM) APB Base Address
pub const port         : *Port = @ptrFromInt(0x41008000); // (PORT) APB Base Address
//#define PUKCC                         (0x42003000) /**< \brief (PUKCC) APB Base Address
//#define PUKCC_AHB                     (0x02000000) /**< \brief (PUKCC) AHB Base Address
//#define QSPI                          (0x42003400) /**< \brief (QSPI) APB Base Address
//#define QSPI_AHB                      (0x04000000) /**< \brief (QSPI) AHB Base Address
//#define RAMECC                        (0x41020000) /**< \brief (RAMECC) APB Base Address
//#define RSTC                          (0x40000C00) /**< \brief (RSTC) APB Base Address
//#define RTC                           (0x40002400) /**< \brief (RTC) APB Base Address
//#define SDHC0                         (0x45000000) /**< \brief (SDHC0) AHB Base Address
//#define SERCOM0                       (0x40003000) /**< \brief (SERCOM0) APB Base Address
//#define SERCOM1                       (0x40003400) /**< \brief (SERCOM1) APB Base Address
//#define SERCOM2                       (0x41012000) /**< \brief (SERCOM2) APB Base Address
//#define SERCOM3                       (0x41014000) /**< \brief (SERCOM3) APB Base Address
//#define SERCOM4                       (0x43000000) /**< \brief (SERCOM4) APB Base Address
//#define SERCOM5                       (0x43000400) /**< \brief (SERCOM5) APB Base Address
//#define SUPC                          (0x40001800) /**< \brief (SUPC) APB Base Address
//#define TC0                           (0x40003800) /**< \brief (TC0) APB Base Address
//#define TC1                           (0x40003C00) /**< \brief (TC1) APB Base Address
//#define TC2                           (0x4101A000) /**< \brief (TC2) APB Base Address
//#define TC3                           (0x4101C000) /**< \brief (TC3) APB Base Address
//#define TC4                           (0x42001400) /**< \brief (TC4) APB Base Address
//#define TC5                           (0x42001800) /**< \brief (TC5) APB Base Address
//#define TCC0                          (0x41016000) /**< \brief (TCC0) APB Base Address
//#define TCC1                          (0x41018000) /**< \brief (TCC1) APB Base Address
//#define TCC2                          (0x42000C00) /**< \brief (TCC2) APB Base Address
//#define TCC3                          (0x42001000) /**< \brief (TCC3) APB Base Address
//#define TCC4                          (0x43001000) /**< \brief (TCC4) APB Base Address
//#define TRNG                          (0x42002800) /**< \brief (TRNG) APB Base Address
//#define USB                           (0x41000000) /**< \brief (USB) APB Base Address
//#define WDT                           (0x40002000) /**< \brief (WDT) APB Base Address
//#else
//#define AC                ((Ac       *)0x42002000UL) /**< \brief (AC) APB Base Address
//#define AC_INST_NUM       1                          /**< \brief (AC) Number of instances
//#define AC_INSTS          { AC }                     /**< \brief (AC) Instances List
//
//#define ADC0              ((Adc      *)0x43001C00UL) /**< \brief (ADC0) APB Base Address
//#define ADC1              ((Adc      *)0x43002000UL) /**< \brief (ADC1) APB Base Address
//#define ADC_INST_NUM      2                          /**< \brief (ADC) Number of instances
//#define ADC_INSTS         { ADC0, ADC1 }             /**< \brief (ADC) Instances List
//
//#define AES               ((Aes      *)0x42002400UL) /**< \brief (AES) APB Base Address
//#define AES_INST_NUM      1                          /**< \brief (AES) Number of instances
//#define AES_INSTS         { AES }                    /**< \brief (AES) Instances List
//
//#define CAN0              ((Can      *)0x42000000UL) /**< \brief (CAN0) APB Base Address
//#define CAN1              ((Can      *)0x42000400UL) /**< \brief (CAN1) APB Base Address
//#define CAN_INST_NUM      2                          /**< \brief (CAN) Number of instances
//#define CAN_INSTS         { CAN0, CAN1 }             /**< \brief (CAN) Instances List
//
//#define CCL               ((Ccl      *)0x42003800UL) /**< \brief (CCL) APB Base Address
//#define CCL_INST_NUM      1                          /**< \brief (CCL) Number of instances
//#define CCL_INSTS         { CCL }                    /**< \brief (CCL) Instances List
//
//#define CMCC              ((Cmcc     *)0x41006000UL) /**< \brief (CMCC) APB Base Address
//#define CMCC_AHB                      (0x03000000UL) /**< \brief (CMCC) AHB Base Address
//#define CMCC_INST_NUM     1                          /**< \brief (CMCC) Number of instances
//#define CMCC_INSTS        { CMCC }                   /**< \brief (CMCC) Instances List
//
//#define DAC               ((Dac      *)0x43002400UL) /**< \brief (DAC) APB Base Address
//#define DAC_INST_NUM      1                          /**< \brief (DAC) Number of instances
//#define DAC_INSTS         { DAC }                    /**< \brief (DAC) Instances List
//
//#define DMAC              ((Dmac     *)0x4100A000UL) /**< \brief (DMAC) APB Base Address
//#define DMAC_INST_NUM     1                          /**< \brief (DMAC) Number of instances
//#define DMAC_INSTS        { DMAC }                   /**< \brief (DMAC) Instances List
//
//#define DSU               ((Dsu      *)0x41002000UL) /**< \brief (DSU) APB Base Address
//#define DSU_INST_NUM      1                          /**< \brief (DSU) Number of instances
//#define DSU_INSTS         { DSU }                    /**< \brief (DSU) Instances List
//
//#define EIC               ((Eic      *)0x40002800UL) /**< \brief (EIC) APB Base Address
//#define EIC_INST_NUM      1                          /**< \brief (EIC) Number of instances
//#define EIC_INSTS         { EIC }                    /**< \brief (EIC) Instances List
//
//#define EVSYS             ((Evsys    *)0x4100E000UL) /**< \brief (EVSYS) APB Base Address
//#define EVSYS_INST_NUM    1                          /**< \brief (EVSYS) Number of instances
//#define EVSYS_INSTS       { EVSYS }                  /**< \brief (EVSYS) Instances List
//
//#define FREQM             ((Freqm    *)0x40002C00UL) /**< \brief (FREQM) APB Base Address
//#define FREQM_INST_NUM    1                          /**< \brief (FREQM) Number of instances
//#define FREQM_INSTS       { FREQM }                  /**< \brief (FREQM) Instances List
//
//#define GCLK              ((Gclk     *)0x40001C00UL) /**< \brief (GCLK) APB Base Address
//#define GCLK_INST_NUM     1                          /**< \brief (GCLK) Number of instances
//#define GCLK_INSTS        { GCLK }                   /**< \brief (GCLK) Instances List
//
//#define HMATRIX           ((Hmatrixb *)0x4100C000UL) /**< \brief (HMATRIX) APB Base Address
//#define HMATRIXB_INST_NUM 1                          /**< \brief (HMATRIXB) Number of instances
//#define HMATRIXB_INSTS    { HMATRIX }                /**< \brief (HMATRIXB) Instances List
//
//#define ICM               ((Icm      *)0x42002C00UL) /**< \brief (ICM) APB Base Address
//#define ICM_INST_NUM      1                          /**< \brief (ICM) Number of instances
//#define ICM_INSTS         { ICM }                    /**< \brief (ICM) Instances List
//
//#define I2S               ((I2s      *)0x43002800UL) /**< \brief (I2S) APB Base Address
//#define I2S_INST_NUM      1                          /**< \brief (I2S) Number of instances
//#define I2S_INSTS         { I2S }                    /**< \brief (I2S) Instances List
//
//#define MCLK              ((Mclk     *)0x40000800UL) /**< \brief (MCLK) APB Base Address
//#define MCLK_INST_NUM     1                          /**< \brief (MCLK) Number of instances
//#define MCLK_INSTS        { MCLK }                   /**< \brief (MCLK) Instances List
//
//#define NVMCTRL           ((Nvmctrl  *)0x41004000UL) /**< \brief (NVMCTRL) APB Base Address
//#define NVMCTRL_SW0                   (0x00800080UL) /**< \brief (NVMCTRL) SW0 Base Address
//#define NVMCTRL_TEMP_LOG              (0x00800100UL) /**< \brief (NVMCTRL) TEMP_LOG Base Address
//#define NVMCTRL_USER                  (0x00804000UL) /**< \brief (NVMCTRL) USER Base Address
//#define NVMCTRL_INST_NUM  1                          /**< \brief (NVMCTRL) Number of instances
//#define NVMCTRL_INSTS     { NVMCTRL }                /**< \brief (NVMCTRL) Instances List
//
//#define OSCCTRL           ((Oscctrl  *)0x40001000UL) /**< \brief (OSCCTRL) APB Base Address
//#define OSCCTRL_INST_NUM  1                          /**< \brief (OSCCTRL) Number of instances
//#define OSCCTRL_INSTS     { OSCCTRL }                /**< \brief (OSCCTRL) Instances List
//
//#define OSC32KCTRL        ((Osc32kctrl *)0x40001400UL) /**< \brief (OSC32KCTRL) APB Base Address
//#define OSC32KCTRL_INST_NUM 1                          /**< \brief (OSC32KCTRL) Number of instances
//#define OSC32KCTRL_INSTS  { OSC32KCTRL }             /**< \brief (OSC32KCTRL) Instances List
//
//#define PAC               ((Pac      *)0x40000000UL) /**< \brief (PAC) APB Base Address
//#define PAC_INST_NUM      1                          /**< \brief (PAC) Number of instances
//#define PAC_INSTS         { PAC }                    /**< \brief (PAC) Instances List
//
//#define PCC               ((Pcc      *)0x43002C00UL) /**< \brief (PCC) APB Base Address
//#define PCC_INST_NUM      1                          /**< \brief (PCC) Number of instances
//#define PCC_INSTS         { PCC }                    /**< \brief (PCC) Instances List
//
//#define PDEC              ((Pdec     *)0x42001C00UL) /**< \brief (PDEC) APB Base Address
//#define PDEC_INST_NUM     1                          /**< \brief (PDEC) Number of instances
//#define PDEC_INSTS        { PDEC }                   /**< \brief (PDEC) Instances List
//
//#define PM                ((Pm       *)0x40000400UL) /**< \brief (PM) APB Base Address
//#define PM_INST_NUM       1                          /**< \brief (PM) Number of instances
//#define PM_INSTS          { PM }                     /**< \brief (PM) Instances List
//
//#define PORT              ((Port     *)0x41008000UL) /**< \brief (PORT) APB Base Address
//#define PORT_INST_NUM     1                          /**< \brief (PORT) Number of instances
//#define PORT_INSTS        { PORT }                   /**< \brief (PORT) Instances List
//
//#define PUKCC             ((void     *)0x42003000UL) /**< \brief (PUKCC) APB Base Address
//#define PUKCC_AHB         ((void     *)0x02000000UL) /**< \brief (PUKCC) AHB Base Address
//#define PUKCC_INST_NUM    1                          /**< \brief (PUKCC) Number of instances
//#define PUKCC_INSTS       { PUKCC }                  /**< \brief (PUKCC) Instances List
//
//#define QSPI              ((Qspi     *)0x42003400UL) /**< \brief (QSPI) APB Base Address
//#define QSPI_AHB                      (0x04000000UL) /**< \brief (QSPI) AHB Base Address
//#define QSPI_INST_NUM     1                          /**< \brief (QSPI) Number of instances
//#define QSPI_INSTS        { QSPI }                   /**< \brief (QSPI) Instances List
//
//#define RAMECC            ((Ramecc   *)0x41020000UL) /**< \brief (RAMECC) APB Base Address
//#define RAMECC_INST_NUM   1                          /**< \brief (RAMECC) Number of instances
//#define RAMECC_INSTS      { RAMECC }                 /**< \brief (RAMECC) Instances List
//
//#define RSTC              ((Rstc     *)0x40000C00UL) /**< \brief (RSTC) APB Base Address
//#define RSTC_INST_NUM     1                          /**< \brief (RSTC) Number of instances
//#define RSTC_INSTS        { RSTC }                   /**< \brief (RSTC) Instances List
//
//#define RTC               ((Rtc      *)0x40002400UL) /**< \brief (RTC) APB Base Address
//#define RTC_INST_NUM      1                          /**< \brief (RTC) Number of instances
//#define RTC_INSTS         { RTC }                    /**< \brief (RTC) Instances List
//
//#define SDHC0             ((Sdhc     *)0x45000000UL) /**< \brief (SDHC0) AHB Base Address
//#define SDHC_INST_NUM     1                          /**< \brief (SDHC) Number of instances
//#define SDHC_INSTS        { SDHC0 }                  /**< \brief (SDHC) Instances List
//
//#define SERCOM0           ((Sercom   *)0x40003000UL) /**< \brief (SERCOM0) APB Base Address
//#define SERCOM1           ((Sercom   *)0x40003400UL) /**< \brief (SERCOM1) APB Base Address
//#define SERCOM2           ((Sercom   *)0x41012000UL) /**< \brief (SERCOM2) APB Base Address
//#define SERCOM3           ((Sercom   *)0x41014000UL) /**< \brief (SERCOM3) APB Base Address
//#define SERCOM4           ((Sercom   *)0x43000000UL) /**< \brief (SERCOM4) APB Base Address
//#define SERCOM5           ((Sercom   *)0x43000400UL) /**< \brief (SERCOM5) APB Base Address
//#define SERCOM_INST_NUM   6                          /**< \brief (SERCOM) Number of instances
//#define SERCOM_INSTS      { SERCOM0, SERCOM1, SERCOM2, SERCOM3, SERCOM4, SERCOM5 } /**< \brief (SERCOM) Instances List
//
//#define SUPC              ((Supc     *)0x40001800UL) /**< \brief (SUPC) APB Base Address
//#define SUPC_INST_NUM     1                          /**< \brief (SUPC) Number of instances
//#define SUPC_INSTS        { SUPC }                   /**< \brief (SUPC) Instances List
//
//#define TC0               ((Tc       *)0x40003800UL) /**< \brief (TC0) APB Base Address
//#define TC1               ((Tc       *)0x40003C00UL) /**< \brief (TC1) APB Base Address
//#define TC2               ((Tc       *)0x4101A000UL) /**< \brief (TC2) APB Base Address
//#define TC3               ((Tc       *)0x4101C000UL) /**< \brief (TC3) APB Base Address
//#define TC4               ((Tc       *)0x42001400UL) /**< \brief (TC4) APB Base Address
//#define TC5               ((Tc       *)0x42001800UL) /**< \brief (TC5) APB Base Address
//#define TC_INST_NUM       6                          /**< \brief (TC) Number of instances
//#define TC_INSTS          { TC0, TC1, TC2, TC3, TC4, TC5 } /**< \brief (TC) Instances List
//
//#define TCC0              ((Tcc      *)0x41016000UL) /**< \brief (TCC0) APB Base Address
//#define TCC1              ((Tcc      *)0x41018000UL) /**< \brief (TCC1) APB Base Address
//#define TCC2              ((Tcc      *)0x42000C00UL) /**< \brief (TCC2) APB Base Address
//#define TCC3              ((Tcc      *)0x42001000UL) /**< \brief (TCC3) APB Base Address
//#define TCC4              ((Tcc      *)0x43001000UL) /**< \brief (TCC4) APB Base Address
//#define TCC_INST_NUM      5                          /**< \brief (TCC) Number of instances
//#define TCC_INSTS         { TCC0, TCC1, TCC2, TCC3, TCC4 } /**< \brief (TCC) Instances List
//
//#define TRNG              ((Trng     *)0x42002800UL) /**< \brief (TRNG) APB Base Address
//#define TRNG_INST_NUM     1                          /**< \brief (TRNG) Number of instances
//#define TRNG_INSTS        { TRNG }                   /**< \brief (TRNG) Instances List
//
//#define USB               ((Usb      *)0x41000000UL) /**< \brief (USB) APB Base Address
//#define USB_INST_NUM      1                          /**< \brief (USB) Number of instances
//#define USB_INSTS         { USB }                    /**< \brief (USB) Instances List
//
//#define WDT               ((Wdt      *)0x40002000UL) /**< \brief (WDT) APB Base Address
//#define WDT_INST_NUM      1                          /**< \brief (WDT) Number of instances
//#define WDT_INSTS         { WDT }                    /**< \brief (WDT) Instances List
//
//#endif /* (defined(__ASSEMBLY__) || defined(__IAR_SYSTEMS_ASM__))
//*@}
//
//* **************************************************************************
//**  PORT DEFINITIONS FOR SAME51J19A
//* **************************************************************************
//** \defgroup SAME51J19A_port PORT Definitions
//*@{
//
//#include "pio/same51j19a.h"
//*@}
//
//* **************************************************************************
//**  MEMORY MAPPING DEFINITIONS FOR SAME51J19A
//* **************************************************************************
//
//#define HSRAM_SIZE            _UL_(0x00030000) /* 192 kB
//#define FLASH_SIZE            _UL_(0x00080000) /* 512 kB
//#define FLASH_PAGE_SIZE       512
//#define FLASH_NB_OF_PAGES     1024
//#define FLASH_USER_PAGE_SIZE  512
//#define BKUPRAM_SIZE          _UL_(0x00002000) /* 8 kB
//#define QSPI_SIZE             _UL_(0x01000000) /* 16384 kB
//
//#define FLASH_ADDR            _UL_(0x00000000) /**< FLASH base address
//#define CMCC_DATARAM_ADDR     _UL_(0x03000000) /**< CMCC_DATARAM base address
//#define CMCC_DATARAM_SIZE     _UL_(0x00001000) /**< CMCC_DATARAM size
//#define CMCC_TAGRAM_ADDR      _UL_(0x03001000) /**< CMCC_TAGRAM base address
//#define CMCC_TAGRAM_SIZE      _UL_(0x00000400) /**< CMCC_TAGRAM size
//#define CMCC_VALIDRAM_ADDR    _UL_(0x03002000) /**< CMCC_VALIDRAM base address
//#define CMCC_VALIDRAM_SIZE    _UL_(0x00000040) /**< CMCC_VALIDRAM size
//#define HSRAM_ADDR            _UL_(0x20000000) /**< HSRAM base address
//#define HSRAM_ETB_ADDR        _UL_(0x20000000) /**< HSRAM_ETB base address
//#define HSRAM_ETB_SIZE        _UL_(0x00008000) /**< HSRAM_ETB size
//#define HSRAM_RET1_ADDR       _UL_(0x20000000) /**< HSRAM_RET1 base address
//#define HSRAM_RET1_SIZE       _UL_(0x00008000) /**< HSRAM_RET1 size
//#define HPB0_ADDR             _UL_(0x40000000) /**< HPB0 base address
//#define HPB1_ADDR             _UL_(0x41000000) /**< HPB1 base address
//#define HPB2_ADDR             _UL_(0x42000000) /**< HPB2 base address
//#define HPB3_ADDR             _UL_(0x43000000) /**< HPB3 base address
//#define SEEPROM_ADDR          _UL_(0x44000000) /**< SEEPROM base address
//#define BKUPRAM_ADDR          _UL_(0x47000000) /**< BKUPRAM base address
//#define PPB_ADDR              _UL_(0xE0000000) /**< PPB base address
//
//#define DSU_DID_RESETVALUE    _UL_(0x61810302)
//#define ADC0_TOUCH_LINES_NUM  32
//#define PORT_GROUPS           2
//
//* **************************************************************************
//**  ELECTRICAL DEFINITIONS FOR SAME51J19A
//* **************************************************************************
