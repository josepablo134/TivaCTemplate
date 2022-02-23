#include <stdint.h>
#include <stdbool.h>

#include "inc/hw_memmap.h"
#include "driverlib/debug.h"
#include "driverlib/gpio.h"
#include "driverlib/sysctl.h"
#include "driverlib/interrupt.h"
#include "driverlib/cpu.h"

#define	DUMMY_DELAY_TIME	1600000U

void dummyDelay( uint32_t counter ){
	while( counter-- ){}
}

int main( int argc, char *argv[] ){
	//
    // Enable the GPIO port that is used for the on-board LED.
    //
    SysCtlPeripheralEnable(SYSCTL_PERIPH_GPION);
    //
    // Check if the peripheral access is enabled.
    //
    while(!SysCtlPeripheralReady(SYSCTL_PERIPH_GPION))
    {
    }

	//
    // Enable the GPIO pin for the LED (PN0).  Set the direction as output, and
    // enable the GPIO pin for digital function.
    //
	GPIOPinTypeGPIOOutput(GPIO_PORTN_BASE, GPIO_PIN_0);
    for (;;)
    {
		GPIOPinWrite(GPIO_PORTN_BASE, GPIO_PIN_0, GPIO_PIN_0);
		dummyDelay( DUMMY_DELAY_TIME );
		GPIOPinWrite(GPIO_PORTN_BASE, GPIO_PIN_0, 0x00);
		dummyDelay( DUMMY_DELAY_TIME );
    }
	return 0;
}
