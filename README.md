nrf51-pure-gcc-setup
====================

A simple and cross-platform GCC setup for nRF51 development. Forked from
original repo
[hlnd/nrf51-pure-gcc-setup](https://github.com/hlnd/nrf51-pure-gcc-setup).
We develop on Linux. Original files still exist for Windows, but have not been
tested in some time. Feel free to submit a pull request if you find something
that doesn't work.

The currently supported SDK versions are: 7, 9

The currently supported Softdevice versions are: s110_7.3.0, s110_8.0.0, s120_2.1.0, and s130_1.0.0

Things to Install
-----------------
1. gcc-arm-none-eabi
2. gdb-arm-none-eabi
3. The jlink tools for linux
4. The jlink debuger for linux

Usage
-----
We use this repo as a submodule of
[nrf5x-base](https://github.com/lab11/nrf5x-base), a collection of libraries,
SDKs, and Softdevices for the nRF5X family of chips. An example of this project
in use can be found
[here](https://github.com/helena-project/squall/tree/master/software/apps/beacon).

Alternatively, this repo can be submoduled within your own project to use it or
cloned elsewhere on your system. Your project Makefile will need to define:
 * TEMPLATE_PATH pointing to the template/ folder of
 * SDK_PATH pointing to the nRF51 SDK installation
 * SDK_VERSION set to the major version number of the SDK you are using (i.e. 9)
 * SOFTDEVICE pointing to the correct softdevice.hex file
 * USE_SOFTDEVICE set to the softdevice type you are using (i.e. s110)

You can override most of the defines from the other Makefiles by setting them
in your project file, since most of them use ?=.

If you want to use the GDB functionality with multiple J-Links, you should
make sure that all projects have a unique GDB port number defined in their
project Makefile.


Targets
-------
Most of the targets provided should be self explanatory, but some may use some
extra explanation:

###### flash:
Build project and flash onto a chip. Also checks that the correct softdevice is
already on the chip, and automatically runs flash-softdevice if not. 

###### flash ID=XX:XX:XX:XX:XX:XX
Sets the Bluetooth ID for the chip to whatever replaces XX:XX:XX:XX:XX:XX (must
be valid hex digits). Bluetooth ID is written to the top of flash and persists
across future flashes (but not erase-alls).

###### erase-all:
Does an erase all of a chip.

###### flash-softdevice
Used to flash a softdevice to a chip. (Note, this is done automatically by
make flash). Flashes softdevice as specified in the project Makefile.

###### flash-softdevice SOFTDEVICE=$(PATH_TO_SOFTDEVICE_WITHOUT_SPACES)
Flashes a specific version of the softdevice. The path to the softdevice hex
needs to be without spaces, due to Make limitations.

###### debug:
Makes with debug symbols. Use before startdebug.

###### startdebug:
Starts a J-Link GDB Server in a separate terminal window, and then GDB
also in a separate window. If you change the code, you can then make directly
from gdb, and do load to run the new code.

To use this feature you must enable the working path as safe! you can also 
enable all paths by adding 'set auto-load safe-path /' to ~/.gdbinit.

###### recover:
Provides equal functionality to that of nrfjprog / nRFgo Studio on Windows.


If you have multiple J-Links connected to your system, you should
set the SEGGER_SERIAL variable to the serial number of your J-Link, so that
the programming Just Works (tm). It seems Segger on Linux isn't capable of
giving you a selection of J-Links, as on Windows.


