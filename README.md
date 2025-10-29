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
3. Build tools: make or ninjia or both
4. cmake version >= 3.31
5. git (only for clone template files from gihub). 

# How to use it
## First steps
Clone this template from github.

Open terminal and go to &lt;template dir&gt;/build folder.

Run command: 
```bash
# For make build tool
cmake -G "Unix Makefiles" ..
# For ninja build tool, but dont use make and ninja at the same time
cmake -G "Ninja" ..
```
This command generate files to build project using make utility (or ninja). Command output is:
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
# or ninja 
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

## Build either firmware or a static library
For demonstration purposes only, the blink.s assembler source file is compiled for both targets: the firmware (blink.hex)  and the static library (blink_lib.lib).

Really make both firmware and static library from the same sources doesn't make sence.

If you need build only firmware hex delete from src/CmakeLists.txt build library 
target defintion below

```cmake
# ---- Remove if you dont need static library build
# Static library build desciption
add_library(blink_lib STATIC
  # <item1> <item2> ... - assembler source files *.s *.asm
  blink.s
)
# ---- remove end
```

If you need only static library remove firmware build from src/CMakeLists.txt. In terms of cmake MCU firmware is executable.

```cmake
# ---- Remove if you dont need firmware build
# Firmware build description
add_executable(blink 
  # <item1> <item2> ... - assembler source files *.s *.asm
  blink.s
)
# ---- remove end
```

## Change assembler source files
Source code assembler files placed in &lt;template dir&gt;/src subfolder. 
For demo purposes template contains one assembler source code file **blink.s**

Source files must have s or asm extension.

For change builded source files edit src/CmakeLists.txt. Add or remove files

```cmake
# Firmware build description
add_executable(blink 
  # <item1> <item2> ... - assembler source files *.s *.asm
  blink.s 
)
```

```cmake
# Static library build desciption
add_library(blink_lib STATIC
  # <item1> <item2> ... - assembler source files *.s *.asm
  blink.s
)
```

## Change compiler and linker flags (optional)
See SDCC documentation and edit root folder CMakeLists.txt
```cmake
# Change complier and linker flags
set(CMAKE_ASM_FLAGS "-lso -a -y")
set(CMAKE_ASM_LINK_FLAGS "-niumwx -M -y")
```

# Use Cmake with Visual Studio code
This is optional step. 

With cmake you are free to use your favorite IDE/code editor.

But if you like to develop embedded software using VS code, do following steps: 
 - Install VS code. 
 - Install C/C++ and cmake plugins.
 - Go to command palette (Ctrl+Shift+P) and select "Edit User-Local Cmake Kits" command. File cmake-tools-kits.json will be opened.

At the end of json add SDCC Cmake Kit description 
```json
  [
  {
    "name": "GCC 14.2.0 x86_64-linux-gnu",
    "compilers": {
      "C": "/usr/bin/gcc",
      "CXX": "/usr/bin/g++"
    },
    "isTrusted": true
  },
  {
    "name": "GCC 14.2.1 arm-none-eabi",
    "compilers": {
      "C": "/usr/bin/arm-none-eabi-gcc",
      "CXX": "/usr/bin/arm-none-eabi-g++"
    },
    "isTrusted": true
  },
  {
    "name": "SDCC",
    "compilers": {
      "C": "/usr/bin/sdcc",
      "ASM": "/usr/bin/sdas8051"
    },
    "isTrusted": true
  }
]
```
Save cmake-tools-kits.json.

After that, you can open the project folder and VS Code will "pick up" the project with cmake support.

Using command palette you can build running "CMake:Build" and other cmake commands.

