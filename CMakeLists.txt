cmake_minimum_required(VERSION 3.31) # Specify minimum CMake version

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
set(CMAKE_TOOLCHAIN_FILE "toolchain-SDCC.cmake")

project(blink ASM) # Define project name and language

add_subdirectory("src")

