set(CMAKE_SYSTEM_NAME Generic)

set(CMAKE_CROSSCOMPILING TRUE)
set(CMAKE_ASM_COMPILER_ID "SDAS8051") 

set(CMAKE_ASM_COMPILER sdas8051 CACHE INTERNAL "asm compiler")
set(CMAKE_ASM_COMPILER_LINKER sdld CACHE INTERNAL "asm linker tool")
set(CMAKE_OBJCOPY sdobjcopy CACHE INTERNAL "objcopy tool")
set(CMAKE_PACKIHX packihx CACHE INTERNAL "packihx tool")
set(CMAKE_MAKEBIN makebin CACHE INTERNAL "makebin tool")

get_filename_component(SDCC_LOCATION "${CMAKE_ASM_COMPILER}" PATH)
get_filename_component(SDCC_LOCATION "${CMAKE_ASM_COMPILER_LINKER}" PATH)
find_program(SDCCLIB_EXECUTABLE sdar PATHS "${SDCC_LOCATION}" NO_DEFAULT_PATH)
find_program(SDCCLIB_EXECUTABLE sdar)
set(CMAKE_AR "${SDCCLIB_EXECUTABLE}" CACHE FILEPATH "The sdcc librarian" FORCE)

if(WIN32)
	# !! Firmware size output not tested !!
	function(ihx_to_hex bin)
	    add_custom_command( 
		TARGET ${bin} POST_BUILD COMMAND  ${CMAKE_PACKIHX} ${bin}.ihx > ${bin}.hex
		TARGET ${bin} POST_BUILD COMMAND  ${CMAKE_MAKEBIN} -p ${bin}.hex ${bin}.bin
		TARGET ${bin} POST_BUILD COMMAND  echo | set /p=\"Firmware bytes size: \"
		TARGET ${bin} POST_BUILD COMMAND  for %I in "\"${bin}.bin\"" do @echo %~zI
	    )
	endfunction(ihx_to_hex)

else()	
	function(ihx_to_hex bin)
	    add_custom_command( 
		TARGET ${bin} POST_BUILD COMMAND  ${CMAKE_PACKIHX} ${bin}.ihx > ${bin}.hex
		TARGET ${bin} POST_BUILD COMMAND  ${CMAKE_MAKEBIN} -p ${bin}.hex ${bin}.bin
		TARGET ${bin} POST_BUILD COMMAND  echo -n "Firmware bytes size: "
		TARGET ${bin} POST_BUILD COMMAND  stat --format '%s' ${bin}.bin
	    )
	endfunction(ihx_to_hex)
	
endif()
