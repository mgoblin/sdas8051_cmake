add_executable(blink 
  blink.s
) # Create an executable target

ihx_to_hex(blink)

add_custom_target(flash
    COMMAND stcgal ${CMAKE_BINARY_DIR}/src/blink.hex
    DEPENDS blink
    JOB_POOL console # for ninja build tool output stgal command input to console
)

add_library(blink_lib STATIC
  blink.s
)
