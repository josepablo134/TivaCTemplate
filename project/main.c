#include <stdint.h>
#include <stdbool.h>

#include "FreeRTOSConfig.h"
#include "FreeRTOS.h"
#include "task.h"

#include "Board.h"
#include "Tasks.h"

int main( int argc, char *argv[] ){
	Board_init();

	Tasks_init();

    vTaskStartScheduler();

    return 0;
}

