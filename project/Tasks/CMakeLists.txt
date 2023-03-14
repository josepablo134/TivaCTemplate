################################################################################
# @file CMakeLists.txt
# @author Josepablo C (josepablo134@gmail.com)
################################################################################

set(COMPONENT_NAME Tasks)

add_library(${COMPONENT_NAME} STATIC
		${CMAKE_CURRENT_LIST_DIR}/src/Tasks.c
)

target_include_directories(${COMPONENT_NAME} PUBLIC
		${CMAKE_CURRENT_LIST_DIR}/include
)

target_link_libraries( ${COMPONENT_NAME}
		BSP
		RTOS
		TivaWare
		Misc
		System
		I2C::TivaCTM4C1294
		SPI::TivaCTM4C1294
		BUS8080::TivaCTM4C1294
		ILI9341::TivaCTM4C1294
		SSD1306::TivaCTM4C1294
		MCP2515::TivaCTM4C1294
		simpleGFX::TivaCTM4C1294
)

