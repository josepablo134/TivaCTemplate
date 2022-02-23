target remote localhost:3333
set arm abi APCS
monitor reset halt
file "output/output.elf"
load
monitor reset
