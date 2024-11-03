################################################################################
# @file CMakeLists.txt
# @author Josepablo C (josepablo134@gmail.com)
################################################################################

set(COMPONENT_NAME BSP)

set(BSP_NAME ${COMPONENT_NAME})
set(BSP_INC_FOLDER ${CMAKE_CURRENT_LIST_DIR}/include PARENT_SCOPE)
set(BSP_CFG_FOLDER ${CMAKE_CURRENT_LIST_DIR}/cfg PARENT_SCOPE)
set(BSP_SRC_FOLDER ${CMAKE_CURRENT_LIST_DIR}/src PARENT_SCOPE)

set(BSP_INC_FOLDER ${CMAKE_CURRENT_LIST_DIR}/include )
set(BSP_CFG_FOLDER ${CMAKE_CURRENT_LIST_DIR}/cfg )
set(BSP_SRC_FOLDER ${CMAKE_CURRENT_LIST_DIR}/src )

set(BSP_EXEC_ENTRY_POINT ResetISR PARENT_SCOPE)

add_library(${COMPONENT_NAME} STATIC
		${CMAKE_CURRENT_LIST_DIR}/src/Board.c
		${CMAKE_CURRENT_LIST_DIR}/src/startup_gcc_tm4c123gh6pm.c
		${CMAKE_CURRENT_LIST_DIR}/src/startup_gcc_tm4c1294ncpdt.c
)

target_include_directories(${COMPONENT_NAME} PUBLIC
		${CMAKE_CURRENT_LIST_DIR}/
		${CMAKE_CURRENT_LIST_DIR}/cfg
		${CMAKE_CURRENT_LIST_DIR}/include
)

include_directories(${COMPONENT_NAME}
		${CMAKE_CURRENT_LIST_DIR}/cfg
)

target_include_directories(${COMPONENT_NAME} PUBLIC
		${CMAKE_CURRENT_LIST_DIR}/libs/RTOS/FreeRTOS
		${CMAKE_CURRENT_LIST_DIR}/libs/RTOS/FreeRTOS/inc
		${CMAKE_CURRENT_LIST_DIR}/libs/RTOS/FreeRTOS/portable
)

add_subdirectory( ${CMAKE_CURRENT_LIST_DIR}/libs/RTOS )

target_link_libraries( ${COMPONENT_NAME}
		RTOS
		#Imported from microMiddlewares repo with package.json
		TivaWare
)

