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

include_directories( BEFORE
		${CMAKE_CURRENT_LIST_DIR}/libs/MemMap
		${CMAKE_CURRENT_LIST_DIR}/libs/RTOS/FreeRTOS
		${CMAKE_CURRENT_LIST_DIR}/libs/RTOS/FreeRTOS/inc
		${CMAKE_CURRENT_LIST_DIR}/libs/RTOS/FreeRTOS/portable
		${CMAKE_CURRENT_LIST_DIR}/libs/TivaWare
		${CMAKE_CURRENT_LIST_DIR}/libs/TivaWare/driverlib
)

add_library(${COMPONENT_NAME} STATIC
		${CMAKE_CURRENT_LIST_DIR}/src/Board.c
		${CMAKE_CURRENT_LIST_DIR}/src/startup_gcc.c
)

target_include_directories(${COMPONENT_NAME} PUBLIC
		${CMAKE_CURRENT_LIST_DIR}/
		${CMAKE_CURRENT_LIST_DIR}/cfg
		${CMAKE_CURRENT_LIST_DIR}/include
)

add_subdirectory( ${CMAKE_CURRENT_LIST_DIR}/libs/MemMap )
add_subdirectory( ${CMAKE_CURRENT_LIST_DIR}/libs/RTOS )
add_subdirectory( ${CMAKE_CURRENT_LIST_DIR}/libs/TivaWare )

target_link_libraries( ${COMPONENT_NAME}
		RTOS
		TivaWare
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

