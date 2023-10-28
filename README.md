PyBadge LC
================================================================================
We're using the PyBadge LC which uses the ATSAMD51J19 microcontroller. Remember this name since it's used throughout code/documentation, many times with shorter variations (i.e. `samd51`).

It comes with a bootloader that will automatically expose a Mass Storage Device over USB.  Copy a "uf2" file to this USB device to flash an application onto the PyBadge.

PyBadge Default Bootloader Application
--------------------------------------------------------------------------------
The default bootloader for the PyBadge LC stays within the the first 0x4000 bytes of flash.  For this reason, it expects the application to be located at address 0x4000 of the flash.

Note that flash is memory-mapped to address 0, so every memory access within the flash size is direct access to the flash.

The bootloader uses the value at address 0x4000 to initialize the stack pointer.  The rest of the first 612 bytes of the data at address 0x4000 is the interrupt vector table. Of particular interest is the "reset vector" at address 0x4004, which is what the bootloader will jump to when it's ready to pass over control to the application.

Placing the code at the correct addresses for the bootloader to work properly is handled by the linker script in `samd51j19a/link.ld` and coordinates with the `def.zig` and `startup.zig` source in the same directory.

> You can see bootloader implementation the `check_start_application` function at: https://github.com/adafruit/uf2-samdx1/blob/master/src/main.c

> UF2 Format and SAMD51 start address: https://github.com/adafruit/uf2-samdx1/blob/a179d8e23dfc0e4f668df205e0cf5a835b947d05/inc/uf2format.h).

## Serial Port on Windows

https://learn.adafruit.com/adafruit-pybadge/advanced-serial-console-on-windows

- Find the COM port in Device Manager
- Use PUTTY to connect to that COM port.
   - Serial line: COMX (i.e. COM6)
   - Connection type: Serial
   - Speed: 115200

# Arm TOOLCHAIN

We don't need a toolchain to build, but if you need one to do things like readelf/disassemble, you can find one here: https://developer.arm.com/downloads/-/gnu-rm

I used these ones:
- Windows: https://developer.arm.com/-/media/Files/downloads/gnu-rm/10.3-2021.10/gcc-arm-none-eabi-10.3-2021.10-win32.zip?rev=8f4a92e2ec2040f89912f372a55d8cf3&hash=8A9EAF77EF1957B779C59EADDBF2DAC118170BBF
- Linux: https://developer.arm.com/-/media/Files/downloads/gnu-rm/10.3-2021.10/gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2?rev=78196d3461ba4c9089a67b5f33edf82a&hash=D484B37FF37D6FC3597EBE2877FB666A41D5253B
