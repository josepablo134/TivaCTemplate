################################################################################
# @file CMakeLists.txt
# @author Josepablo C (josepablo134@gmail.com)
# @version 1.0
################################################################################

IF(TOOLCHAIN_COMPILER_GCC_TYPE)
    message("TOOLCHAIN EPILOG: GCC Detected - Nothing to do")
elseif (TOOLCHAIN_COMPILER_TI_TYPE)
    message("TOOLCHAIN EPILOG: Texas Instrument Detected")
    include(${CMAKE_CURRENT_LIST_DIR}/ti-toolchain-epilog.cmake)
else()
    message(FATAL_ERROR  "TOOLCHAIN EPILOG: Toolchain mode not detected!" )
endif ()
