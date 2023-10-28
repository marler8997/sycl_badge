# PyBadge LC

We're using the PyBadge LC which uses the SAMD51 microcontroller.  Remember this name since it's used throughout code/documentation.  It comes with a bootloader that will automatically expose a Mass Storage Device over USB.  Copy a "uf2" file to this USB device to flash an application onto the PyBadge.


## PyBadge Default Bootloader Application

| Address | Description                   |
|---------|-------------------------------|
| 0x4000  | The application start address |
| 0x4004  | The reset vector              |

For the SAMD51, the "application start address" is 0x4000. This is the address where the uf2 file will be flashed.  The flash contents can also be accessed through the mmu at the same address 0x4000.

The default bootloader will read the "reset vector" from the application at address 0x4004.  This reset vector must be between the start address (0x4000) and the flash size.  After some setup, the reset vector is where the bootloader will jump into the application.

> You can see these details in the `check_start_application` function at: https://github.com/adafruit/uf2-samdx1/blob/master/src/main.c

> UF2 Format and SAM51 start address: https://github.com/adafruit/uf2-samdx1/blob/a179d8e23dfc0e4f668df205e0cf5a835b947d05/inc/uf2format.h).
