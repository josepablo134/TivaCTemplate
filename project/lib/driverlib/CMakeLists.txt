################################################################################
# @file CMakeLists.txt
# @author Josepablo C (josepablo134@gmail.com)
# @version 1.0
# @date 2023-02-27
################################################################################

set(COMPONENT_NAME BSP)
#add_library(${COMPONENT_NAME} STATIC
#		${CMAKE_CURRENT_LIST_DIR}/adc.c
#		${CMAKE_CURRENT_LIST_DIR}/aes.c
#		${CMAKE_CURRENT_LIST_DIR}/can.c
#		${CMAKE_CURRENT_LIST_DIR}/comp.c
#		${CMAKE_CURRENT_LIST_DIR}/cpu.c
#		${CMAKE_CURRENT_LIST_DIR}/crc.c
#		${CMAKE_CURRENT_LIST_DIR}/des.c
#		${CMAKE_CURRENT_LIST_DIR}/eeprom.c
#		${CMAKE_CURRENT_LIST_DIR}/emac.c
#		${CMAKE_CURRENT_LIST_DIR}/epi.c
#		${CMAKE_CURRENT_LIST_DIR}/flash.c
#		${CMAKE_CURRENT_LIST_DIR}/fpu.c
#		${CMAKE_CURRENT_LIST_DIR}/gpio.c
#		${CMAKE_CURRENT_LIST_DIR}/hibernate.c
#		${CMAKE_CURRENT_LIST_DIR}/i2c.c
#		${CMAKE_CURRENT_LIST_DIR}/interrupt.c
#		${CMAKE_CURRENT_LIST_DIR}/lcd.c
#		${CMAKE_CURRENT_LIST_DIR}/mpu.c
#		${CMAKE_CURRENT_LIST_DIR}/onewire.c
#		${CMAKE_CURRENT_LIST_DIR}/pwm.c
#		${CMAKE_CURRENT_LIST_DIR}/qei.c
#		${CMAKE_CURRENT_LIST_DIR}/shamd5.c
#		${CMAKE_CURRENT_LIST_DIR}/ssi.c
#		${CMAKE_CURRENT_LIST_DIR}/sw_crc.c
#		${CMAKE_CURRENT_LIST_DIR}/sysctl.c
#		${CMAKE_CURRENT_LIST_DIR}/sysexc.c
#		${CMAKE_CURRENT_LIST_DIR}/systick.c
#		${CMAKE_CURRENT_LIST_DIR}/timer.c
#		${CMAKE_CURRENT_LIST_DIR}/uart.c
#		${CMAKE_CURRENT_LIST_DIR}/udma.c
#		${CMAKE_CURRENT_LIST_DIR}/usb.c
#		${CMAKE_CURRENT_LIST_DIR}/watchdog.c
#)
#
#target_include_directories(${COMPONENT_NAME} PUBLIC
#		${PJ_FOLDER}/lib/
#		${CMAKE_CURRENT_LIST_DIR}/
#		${CMAKE_CURRENT_LIST_DIR}/inc
#)

target_include_directories(${EXEC_NAME} PUBLIC
		${CMAKE_CURRENT_LIST_DIR}/
		${CMAKE_CURRENT_LIST_DIR}/inc
)

target_link_libraries(${EXEC_NAME} ${CMAKE_CURRENT_LIST_DIR}/gcc/libdriver.a)

#target_compile_options(${COMPONENT_NAME}
#		PUBLIC
#		$<$<COMPILE_LANGUAGE:C>:
#				-nostdlib -fno-exceptions -nostartfiles -nodefaultlibs
#				-g3 -gdwarf-2 -lgcc -lc
#				-mthumb
#				-mcpu=cortex-m4
#				-mfpu=fpv4-sp-d16
#				-mfloat-abi=hard
#				-DTARGET_IS_TM4C129_RA1
#				-DPART_TM4C129XNCZAD
#		>
#		$<$<COMPILE_LANGUAGE:ASM>:
#				#TBD
#		>
#)


