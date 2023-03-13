target remote localhost:3333
set arm abi APCS
monitor reset halt
file "../build/bin/template.elf"
load
monitor reset
