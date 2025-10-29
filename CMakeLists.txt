cmake_minimum_required(VERSION 3.31) # Specify minimum CMake version

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
set(CMAKE_TOOLCHAIN_FILE "toolchain-SDCC.cmake")

set(CMAKE_BUILD_TYPE Debug)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Change complier and linker flags
set(CMAKE_ASM_FLAGS "-lso -a -y")
set(CMAKE_ASM_LINK_FLAGS "-niumwx -M -y")

project(blink ASM) # Define project name and language

add_subdirectory("src")

