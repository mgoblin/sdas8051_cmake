# sdas8051_cmake
Project template for SDCC 8051 assembler (sdas8051)  integrated with cmake for compilation/linking.

It demostrates how to make firmware and static library for 8051-architecture MCU using SDCC and cmake.

Template was tested on Debian 13 and Visual Studio Code.

# Why?
Intel 8051 architecure microcontrollers are stable and very cheap. This MCUs continue using for simple electronic devices. 

SDCC is free and opensource C/ASM toolkit for 8 and 16 bit microcontrollers firmware including 8051 architecure.

Cmake is a standard de facto to build C applications. 

On beggining STC15W408AS MCU programming I have desire to build firmware outside Platfromio. I'm having trouble building the firmware using cmake.

This repository contains my experiment results to compile STC MCU firmware and static libraries using cmake.


# Required software
Before using this template, you must install the following on your PC:
1. [SDCC toolkit](https://sdcc.sourceforge.net/). 
2. [stcgal](https://github.com/grigorig/stcgal) STC MCU ISP flash tool. For others 8051 MCU (not STC) flash target in src/CmakeLists.txt should be modified or removed.
3. Build tools: make or ninjia
4. cmake version >= 3.31
5. git (only for clone template files from gihub). 

# How to use it
## First steps
Clone this template from github.

Open terminal and go to &lt;template dir&gt;/build folder.

Run command: 
```bash
cmake ..
```
This command generate files to build project using make utility. Command output is:
```
-- The ASM compiler identification is SDAS8051
-- Found assembler: /usr/bin/sdas8051
-- Configuring done (0.0s)
-- Generating done (0.0s)
-- Build files have been written to: <absoule path to template_dir/build folder> 
```

Now you are ready to build firmware and static library. Run command:
```bash
make
```
Command output is:
```
[ 25%] Building ASM object src/CMakeFiles/blink.dir/blink.rel
[ 50%] Linking ASM executable blink.hex
packihx: read 2 lines, wrote 3: OK.
Firmware bytes size: 22
[ 50%] Built target blink
[ 75%] Building ASM object src/CMakeFiles/blink_lib.dir/blink.rel
[100%] Linking ASM static library blink_lib.lib
[100%] Built target blink_lib
```

Yap. Success. You can find firmware hex file &lt;template dir&gt;/build/src/blink.hex

If you have STC MCU (dev board) connected to PC with something like [programmator](https://github.com/mgoblin/STC-programmator) firmware could be uploaded.

Assume terminal in &lt;template dir&gt;/build folder.
To upload firmware run:
```bash
make flash
```
This command run stcgal flash tool.

Once the download is complete, the LED on the microcontroller pin P10 will start blinking.

## Source files
Source code assembler files placed in &lt;template dir&gt;/src subfolder. 
For demo purposes template contains one assembler source code file **blink.s**

Source files must have s or asm extension.

For change builded source files change src/CmakeLists.txt.

```cmake
# Firmware source files
add_executable(blink 
  blink.s
)
```

```cmake
# Static library source files
add_library(blink_lib STATIC
  blink.s
)
```

## Build one of firmware or static library



