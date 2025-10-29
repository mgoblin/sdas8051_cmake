# ---- Remove if you dont need firmware build
# Firmware build description
add_executable(blink 
  # <item1> <item2> ... - assembler source files *.s *.asm
  blink.s
)
# ---- remove end

# Transform firmware ihx to hex
ihx_to_hex(blink)

# upload firmware to STC MCU
add_custom_target(flash
    COMMAND stcgal ${CMAKE_BINARY_DIR}/src/blink.hex
    DEPENDS blink
    JOB_POOL console # for ninja build tool output stgal command input to console
)

# ---- Remove if you dont need static library build
# Static library build desciption
add_library(blink_lib STATIC
  # <item1> <item2> ... - assembler source files *.s *.asm
  blink.s
)
# ---- remove end
