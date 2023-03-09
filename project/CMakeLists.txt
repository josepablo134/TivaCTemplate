################################################################################
# @file CMakeLists.txt
# @author Josepablo C (josepablo134@gmail.com)
# @version 1.0
################################################################################

cmake_minimum_required( VERSION 3.18.4 )

include(cmake/toolchain.cmake)

project( TivaCTemplate
		DESCRIPTION "Project template for TivaC microcontroller"
		VERSION 1.0.0
		LANGUAGES C ASM
)

# ===================================================================
# Project Set-Up
# ===================================================================

set( PROJECT_NAME template )
set( EXEC_NAME ${PROJECT_NAME} )
set( WORK_DIR ${PROJECT_SOURCE_DIR} )

include( ${WORK_DIR}/cmake/project.cmake)

# ===================================================================
# Project content
# ===================================================================

add_executable( ${EXEC_NAME} ${WORK_DIR}/main.c )

add_subdirectory( ${WORK_DIR}/BSP )

target_link_libraries( ${EXEC_NAME}
		BSP
)

include_directories( BEFORE
		${WORK_DIR}/BSP/libs/MemMap
		${WORK_DIR}/BSP/libs/RTOS/FreeRTOS
		${WORK_DIR}/BSP/libs/RTOS/FreeRTOS/inc
		${WORK_DIR}/BSP/libs/RTOS/FreeRTOS/portable
		${WORK_DIR}/BSP/libs/TivaWare
		${WORK_DIR}/BSP/libs/TivaWare/driverlib
)

target_include_directories(${EXEC_NAME} PRIVATE
		${BSP_INC_FOLDER}
		${BSP_CFG_FOLDER}
		${WORK_DIR}
)

# ===================================================================
# Compile and Link options
# ===================================================================
target_compile_options(${EXEC_NAME}
		PUBLIC
		$<$<COMPILE_LANGUAGE:CXX>:
				-mcpu=cortex-m4 -mfpu=fpv4-sp-d16 -mfloat-abi=hard
		>
		$<$<COMPILE_LANGUAGE:C>:
				-nostdlib -fno-exceptions -nostartfiles -nodefaultlibs -g3 -gdwarf-2 -lgcc -lc -mthumb -mcpu=cortex-m4 -mfpu=fpv4-sp-d16 -mfloat-abi=hard -DTARGET_IS_TM4C129_RA1 -DPART_TM4C129XNCZAD
		>
		$<$<COMPILE_LANGUAGE:ASM>:
				-mcpu=cortex-m4 -mfpu=fpv4-sp-d16 -mfloat-abi=hard
		>
)

target_link_options(${EXEC_NAME}
		PUBLIC
		# Entry point of the whole system.
		#-Wl,-eResetISR
		-Wl,-e${BSP_EXEC_ENTRY_POINT}
		-fno-exceptions -nostartfiles -lgcc -lc -mcpu=cortex-m4 -mfpu=fpv4-sp-d16 -mfloat-abi=hard -Wl,-n -Wl,-T ${LINKER_SCRIPT} -Wl,-Map ${OUTPUT_MAP}
)

# Generate Linker Script from configuration file
add_custom_command(
		TARGET ${EXEC_NAME} PRE_LINK
		COMMAND
				${CMAKE_COMMAND} -E make_directory ${CMAKE_RUNTIME_LOCATE_DIRECTORY}
		COMMAND
				${CMAKE_C_COMPILER} -E -P -x c ${PRE_LINKER_SCRIPT} -o ${LINKER_SCRIPT}
		DEPENDS 
				${PRE_LINKER_SCRIPT}
)

# Generate S19 file
add_custom_command(
		TARGET ${EXEC_NAME} POST_BUILD
		COMMAND
				${CMAKE_OBJCOPY} --srec-forceS3 -O srec ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${EXEC_NAME}${CMAKE_EXECUTABLE_SUFFIX} ${OUTPUT_S19}
		DEPENDS 
			${EXEC_NAME}
)

# Generate HEX file
add_custom_command(
		TARGET ${EXEC_NAME} POST_BUILD
		COMMAND
				${CMAKE_OBJCOPY} -O ihex ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${EXEC_NAME}${CMAKE_EXECUTABLE_SUFFIX} ${OUTPUT_HEX}
		DEPENDS 
			${EXEC_NAME}
)

