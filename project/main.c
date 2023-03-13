#include <stdint.h>
#include <stdbool.h>

#include "inc/hw_memmap.h"
#include "driverlib/debug.h"
#include "driverlib/gpio.h"
#include "driverlib/sysctl.h"
#include "driverlib/interrupt.h"
#include "driverlib/cpu.h"

#include "FreeRTOSConfig.h"
#include "FreeRTOS.h"
#include "task.h"
#include "queue.h"

#include "Board.h"

void demoTask1( void *pvArg);
void demoTask2( void *pvArg);

int main( int argc, char *argv[] ){
	Board_init();
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

    xTaskCreate(demoTask1, (const portCHAR *)"Demo Task 1",
                configMINIMAL_STACK_SIZE, NULL, 1, NULL);

    xTaskCreate(demoTask2, (const portCHAR *)"Demo Task 2",
                configMINIMAL_STACK_SIZE, NULL, 1, NULL);

    vTaskStartScheduler();

    return 0;
}

void demoTask1(void *pvArg)
{
    //
    // Enable the GPIO pin for the LED (PN0).  Set the direction as output, and
    // enable the GPIO pin for digital function.
    //
    GPIOPinTypeGPIOOutput(GPIO_PORTN_BASE, GPIO_PIN_0);
    for (;;)
    {
        GPIOPinWrite(GPIO_PORTN_BASE, GPIO_PIN_0, GPIO_PIN_0);
        vTaskDelay(100 / portTICK_PERIOD_MS);
        GPIOPinWrite(GPIO_PORTN_BASE, GPIO_PIN_0, 0x00);
        vTaskDelay(100 / portTICK_PERIOD_MS);
    }
}

void demoTask2(void *pvArg)
{
    //
    // Enable the GPIO pin for the LED (PN0).  Set the direction as output, and
    // enable the GPIO pin for digital function.
    //
    GPIOPinTypeGPIOOutput(GPIO_PORTN_BASE, GPIO_PIN_1);
    for (;;)
    {
        GPIOPinWrite(GPIO_PORTN_BASE, GPIO_PIN_1, GPIO_PIN_1);
        vTaskDelay(250 / portTICK_PERIOD_MS);
        GPIOPinWrite(GPIO_PORTN_BASE, GPIO_PIN_1, 0x00);
        vTaskDelay(250 / portTICK_PERIOD_MS);
    }
}
