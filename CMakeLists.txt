################################################################################
# @file CMakeLists.txt
# @author Josepablo C (josepablo134@gmail.com)
# @version 1.0
# @date 2023-02-27
################################################################################

cmake_minimum_required( VERSION 3.18.4 )

include(toolchain.cmake)

project( TivaCTemplate
		DESCRIPTION "Project template for TivaC microcontroller"
		VERSION 1.0.0
		LANGUAGES C ASM
)

set( PROJECT_NAME template )
set( EXEC_NAME ${PROJECT_NAME} )
set( WORK_DIR ${PROJECT_SOURCE_DIR} )
set( PJ_FOLDER ${PROJECT_SOURCE_DIR}/project )

set( CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib )
set( CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib )
set( CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin )
set( OUTPUT_S19 ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${EXEC_NAME}.s19)
set( OUTPUT_HEX ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${EXEC_NAME}.hex)
set( OUTPUT_MAP ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${EXEC_NAME}.map)

set( PRE_LINKER_SCRIPT ${WORK_DIR}/tm4c1294_cfg.ld)
set( LINKER_SCRIPT ${WORK_DIR}/tm4c1294.ld)

add_executable( ${EXEC_NAME} ${WORK_DIR}/project/main.c )

add_subdirectory( ${WORK_DIR}/project/board )
add_subdirectory( ${WORK_DIR}/project/lib/driverlib )
add_subdirectory( ${WORK_DIR}/project/lib/FreeRTOS )
add_subdirectory( ${WORK_DIR}/project/lib/MemMap )

target_link_libraries( ${EXEC_NAME}
		Board
		#BSP
		FreeRTOS
)

target_include_directories(${EXEC_NAME} PRIVATE
		${PJ_FOLDER}/
		${PJ_FOLDER}/project
		${PJ_FOLDER}/lib/
)

target_compile_options(${EXEC_NAME}
		PUBLIC
		$<$<COMPILE_LANGUAGE:C>:
				-nostdlib -fno-exceptions -nostartfiles -nodefaultlibs
				-g3 -gdwarf-2 -lgcc -lc
				-mthumb
				-mcpu=cortex-m4
				-mfpu=fpv4-sp-d16
				-mfloat-abi=hard
				-DTARGET_IS_TM4C129_RA1
				-DPART_TM4C129XNCZAD
		>
		$<$<COMPILE_LANGUAGE:ASM>:
				#TBD
		>
)

target_link_options(${EXEC_NAME}
		PUBLIC
		-nostdlib -fno-exceptions -nostartfiles -nodefaultlibs
		-mcpu=cortex-m4
		-mfpu=fpv4-sp-d16
		-mfloat-abi=hard
		-Wl,-n -Wl,-T ${LINKER_SCRIPT} -Wl,-Map ${OUTPUT_MAP}
)

add_custom_command(
		TARGET ${EXEC_NAME} PRE_LINK
		COMMAND
				${CMAKE_C_COMPILER} -E -P -x c ${PRE_LINKER_SCRIPT} -o ${LINKER_SCRIPT}
		DEPENDS 
				${PRE_LINKER_SCRIPT}
)
