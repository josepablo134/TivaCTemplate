################################################################################
# @file CMakeLists.txt
# @author Josepablo C (josepablo134@gmail.com)
# @version 1.0
# @date 2023-02-27
################################################################################

set(COMPONENT_NAME Board)

add_library(${COMPONENT_NAME} STATIC
		${CMAKE_CURRENT_LIST_DIR}/Board.c
		${CMAKE_CURRENT_LIST_DIR}/startup_gcc.c
)

target_include_directories(${COMPONENT_NAME} PUBLIC
		${CMAKE_CURRENT_LIST_DIR}/
		${PJ_FOLDER}/board/
		${PJ_FOLDER}/lib/
		${PJ_FOLDER}/lib/driverlib/
		${PJ_FOLDER}/lib/driverlib/inc
)

target_include_directories(${EXEC_NAME} PUBLIC
		${CMAKE_CURRENT_LIST_DIR}/
		${CMAKE_CURRENT_LIST_DIR}/inc
)

target_compile_options(${COMPONENT_NAME}
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


