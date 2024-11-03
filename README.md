# TivaCTemplate

A template for projects based on TivaC microcontrollers and FreeRTOS made with CMake.

This template has been tested with TivaC (TM4C1294NCPDT) along with driverlib from TI's TivaWare SDK.

Recently updated and tested on TM4C123G succesfully.

This template supports Linux and Windows.

# Project structure

 - __project/cmake__ : Contains the toolchain (compiler, linker and options definition), the linker script and some project specific cmake variables.

 - __project/Tasks__ : Software component that contains the definition of FreeRTOS' tasks.

 - __project/BSP__ : Software component containing the basic software package (TivaWare driverlib, FreeRTOS kernel and Board configuration along with startup code).

 - __project/main.c__ : The file where the magic happens. After the startup code from the BSP, the system's entry point is defined here.

 - __project/package.json__ : Packages descriptor file meant to be used with [cpacman](https://github.com/josepablo134/SimpleSourcePackageManager) package manager.

# CMake and Ninja

[CMake](https://cmake.org/) is a tool for generation and automation of code. The name is an abbreviation of __cross platform make__. It is a multiplatform, open-source tool that can generate Makefiles (or different build system projects like Ninja) from a simple and more readable configuration file. CMake in a nutshell is a syntax to describe a project and the compiler environment so it can be abstracted from the final build system file (Makefiles, Ninja.build, Eclipse .cproject, etc)

[Ninja](https://ninja-build.org/), in other hand, is a build system tool meant to replace Makefiles. It is focused by design to run as fast as possible. It already knows the number of cores of your machine, so it dynamically decides when and how to parallelize the build process.

# CPacMan (Source Package Manager)

Is a simple package manager (inspired on npm) meant to download source code and integrate it to your project with a simple json descriptor file.

Check it out: [cpacman](https://github.com/josepablo134/SimpleSourcePackageManager)

## Dependencies installation

Just navigate to the `project` folder and invoke the package manager:

```.sh
$ cd project
$ cpacman install
```

This will create a `c_modules` folder containing a CMake file required to add the packages to the project.

For more information about how cpacman works and how to use it, check out: [cpacman](https://github.com/josepablo134/SimpleSourcePackageManager)

## Build Process

The build process is pretty straightforward, just create a build folder, invoke CMake over the `project` folder and then run ninja (I recommend to use Ninja instead of Make).

```.sh
$ #Assuming you are at the root folder of this repo:
$ mkdir build
$ cd build
$ cmake ../project -GNinja
$ ninja
```

After the compilation, the artifacts are located at the new `build/bin` folder. This will generate __ELF__, __S19__ and __HEX__ files.
You can now load the binary to the microcontroller using OpenOCD and see the leds blinking.

## __Important!__

If you have any comment or question, you can reach me out [josepablo134@gmail.com](mailto:josepablo134@gmail.com)
