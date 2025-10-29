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


# Dependencies (required software)
Before using this template, you must install the following on your PC:
1. [SDCC toolkit](https://sdcc.sourceforge.net/). 
2. [stcgal](https://github.com/grigorig/stcgal) STC MCU ISP flash tool. For others 8051 MCU (not STC) flash target in src/CmakeLists.txt should be modified or removed.
3. Build tools: make or ninjia
4. cmake version >= 3.31
5. git (only for clone template files from gihub). 

# How to use it

