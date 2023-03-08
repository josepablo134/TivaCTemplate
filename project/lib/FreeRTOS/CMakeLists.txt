################################################################################
# @file CMakeLists.txt
# @author Josepablo C (josepablo134@gmail.com)
# @version 1.0
# @date 2023-02-27
################################################################################

set(COMPONENT_NAME FreeRTOS)

add_library(${COMPONENT_NAME} STATIC
		${CMAKE_CURRENT_LIST_DIR}/croutine.c
		${CMAKE_CURRENT_LIST_DIR}/event_groups.c
		${CMAKE_CURRENT_LIST_DIR}/list.c
		${CMAKE_CURRENT_LIST_DIR}/queue.c
		${CMAKE_CURRENT_LIST_DIR}/stream_buffer.c
		${CMAKE_CURRENT_LIST_DIR}/tasks.c
		${CMAKE_CURRENT_LIST_DIR}/timers.c

		${CMAKE_CURRENT_LIST_DIR}/portable/heap_2.c
		${CMAKE_CURRENT_LIST_DIR}/portable/port.c
)

target_include_directories(${COMPONENT_NAME} PUBLIC
		${CMAKE_CURRENT_LIST_DIR}/
		${CMAKE_CURRENT_LIST_DIR}/inc
		${CMAKE_CURRENT_LIST_DIR}/portable
		${PJ_FOLDER}/board/
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


