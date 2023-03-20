#include "Board.h"
#include <stdint.h>
#include <stdbool.h>

// TivaWare includes
#include "driverlib/sysctl.h"
#include "driverlib/rom.h"
#include "driverlib/rom_map.h"

#include "FreeRTOSConfig.h"

void Board_init(){
	SysCtlClockFreqSet( (SYSCTL_XTAL_25MHZ | SYSCTL_OSC_MAIN |
       					 SYSCTL_USE_PLL | SYSCTL_CFG_VCO_480),
       					 SYSTEM_CLOCK );
	//
    // Enable the GPIO port that is used for the on-board LED.
    //
    SysCtlPeripheralEnable(SYSCTL_PERIPH_GPION);
    SysCtlPeripheralEnable(SYSCTL_PERIPH_GPIOA);
    //
    // Check if the peripheral access is enabled.
    //
    while(
		(!SysCtlPeripheralReady(SYSCTL_PERIPH_GPION)) ||
		(!SysCtlPeripheralReady(SYSCTL_PERIPH_GPIOA))
	)
    {
    }

}

