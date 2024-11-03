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

include(cmake/toolchain-epilog.cmake)

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
add_subdirectory( ${WORK_DIR}/Tasks )

# package.json
add_subdirectory( ${WORK_DIR}/c_modules )

target_link_libraries( ${EXEC_NAME}
		BSP
		Tasks
)

target_include_directories(${EXEC_NAME} PRIVATE
		${WORK_DIR}
)

target_link_options(${EXEC_NAME}
		PUBLIC
		-Wl,-e${BSP_EXEC_ENTRY_POINT} -Wl,-T ${LINKER_SCRIPT} -Wl,-Map=${OUTPUT_MAP}
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

