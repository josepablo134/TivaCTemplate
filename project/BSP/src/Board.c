#include "Board.h"
#include <stdint.h>
#include <stdbool.h>

// TivaWare includes
#include "driverlib/sysctl.h"
#include "driverlib/rom.h"
#include "driverlib/rom_map.h"

#include "FreeRTOSConfig.h"

void Board_init(){
    ROM_FPUEnable();
    ROM_FPULazyStackingEnable();

    #if 0
        // Set Clock to 120Mhz on TM4C1294
        SysCtlClockFreqSet( (SYSCTL_XTAL_25MHZ | SYSCTL_OSC_MAIN |
                            SYSCTL_USE_PLL | SYSCTL_CFG_VCO_480),
                            SYSTEM_CLOCK );
    #else
        // Set Clock to 80Mhz using PIOSC (on TM4C123G)
        ROM_SysCtlClockSet( SYSCTL_SYSDIV_2_5 | SYSCTL_USE_PLL | SYSCTL_OSC_INT );

        // Set Clock to 80Mhz using MOSC (on TM4C123G)
        // ROM_SysCtlClockSet( SYSCTL_SYSDIV_2_5 | SYSCTL_USE_PLL | SYSCTL_XTAL_16MHZ | SYSCTL_OSC_MAIN);
    #endif

	//
    // Enable the GPIO port that is used for the on-board LED.
    // (TM4C123GXL board)
    SysCtlPeripheralEnable(SYSCTL_PERIPH_GPIOF);
    //
    // Check if the peripheral access is enabled.
    // (TM4C123GXL board)
    while( (!SysCtlPeripheralReady(SYSCTL_PERIPH_GPIOF)) )
    {
    }
}

