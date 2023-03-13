################################################################################
# @file CMakeLists.txt
# @author Josepablo C (josepablo134@gmail.com)
################################################################################

set(COMPONENT_NAME RTOS)

add_library(${COMPONENT_NAME} STATIC
		${CMAKE_CURRENT_LIST_DIR}/FreeRTOS/croutine.c
		${CMAKE_CURRENT_LIST_DIR}/FreeRTOS/event_groups.c
		${CMAKE_CURRENT_LIST_DIR}/FreeRTOS/list.c
		${CMAKE_CURRENT_LIST_DIR}/FreeRTOS/queue.c
		${CMAKE_CURRENT_LIST_DIR}/FreeRTOS/stream_buffer.c
		${CMAKE_CURRENT_LIST_DIR}/FreeRTOS/tasks.c
		${CMAKE_CURRENT_LIST_DIR}/FreeRTOS/timers.c

		${CMAKE_CURRENT_LIST_DIR}/FreeRTOS/portable/heap_2.c
		${CMAKE_CURRENT_LIST_DIR}/FreeRTOS/portable/port.c
)

target_include_directories(${COMPONENT_NAME} PUBLIC
		${BSP_CFG_FOLDER}
		${CMAKE_CURRENT_LIST_DIR}/FreeRTOS/
		${CMAKE_CURRENT_LIST_DIR}/FreeRTOS/inc
		${CMAKE_CURRENT_LIST_DIR}/FreeRTOS/portable
)

target_compile_options(${COMPONENT_NAME}
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

