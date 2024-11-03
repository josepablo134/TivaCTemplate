################################################################################
# @file CMakeLists.txt
# @author Josepablo C (josepablo134@gmail.com)
# @version 1.0
################################################################################

set( CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/libs )
set( CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/libs )
set( CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin )
set( CMAKE_RUNTIME_LOCATE_DIRECTORY ${CMAKE_BINARY_DIR}/locate )
set( CMAKE_EXECUTABLE_SUFFIX .elf)
set( OUTPUT_S19 ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${EXEC_NAME}.s19)
set( OUTPUT_HEX ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${EXEC_NAME}.hex)
set( OUTPUT_MAP ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${EXEC_NAME}.map)

set( PRE_LINKER_SCRIPT ${WORK_DIR}/cmake/TM4C123GH6PM_cfg.ld)
set( LINKER_SCRIPT ${CMAKE_RUNTIME_LOCATE_DIRECTORY}/linkerscript.ld)

