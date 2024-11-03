#include "Tasks.h"

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

#include "Board.h"

void Tasks_init( void ){
    xTaskCreate(demoTask1, (const portCHAR *)"Demo Task 1",
                configMINIMAL_STACK_SIZE, NULL, 1, NULL);

    xTaskCreate(demoTask2, (const portCHAR *)"Demo Task 2",
                configMINIMAL_STACK_SIZE, NULL, 1, NULL);
}

void demoTask1(void *pvArg)
{
    const uint32_t      ms_period = 125/portTICK_PERIOD_MS;
    const uint32_t      port = GPIO_PORTF_BASE;
    const uint8_t       pin = GPIO_PIN_1;// TM4C123GXL board, Red Led
    //
    // Enable the GPIO pin for the LED (PN0).  Set the direction as output, and
    // enable the GPIO pin for digital function.
    //
    GPIOPinTypeGPIOOutput(port, pin);
    for (;;)
    {
        GPIOPinWrite(port, pin, ~GPIOPinRead( port, pin ) );
        vTaskDelay(ms_period);
    }
}

void demoTask2(void *pvArg)
{
    const uint32_t      ms_period = 250/portTICK_PERIOD_MS;
    const uint32_t      port = GPIO_PORTF_BASE;
    const uint8_t       pin = GPIO_PIN_2;// TM4C123GXL board, Blue Led
    //
    // Enable the GPIO pin for the LED (PN0).  Set the direction as output, and
    // enable the GPIO pin for digital function.
    //
    GPIOPinTypeGPIOOutput(port, pin);
    for (;;)
    {
        GPIOPinWrite(port, pin, ~GPIOPinRead( port, pin ) );
        vTaskDelay(ms_period);
    }
}
