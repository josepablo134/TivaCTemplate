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

