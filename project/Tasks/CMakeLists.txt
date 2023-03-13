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

