#define CODE_BASE 0x00000000
#define CODE_SIZE 1M
#define SRAM_BASE 0x20000000
#define SRAM_SIZE 256K

MEMORY
{
	FLASH (rx): ORIGIN = CODE_BASE, LENGTH = CODE_SIZE
	SRAM  (rwx) : ORIGIN = SRAM_BASE, LENGTH = SRAM_SIZE
}

SECTIONS
{
	.text :
	{
		_text = .;
		KEEP(*(.isr_vector))
		*(.text*)
		*(.rodata*)
		_etext = .;
	} > FLASH

	.data : AT(ADDR(.text) + SIZEOF(.text))
	{
		_data = .;
		*(vtable)
		*(.data*)
		_edata = .;
	} > SRAM

	.bss :
	{
		_bss = .;
		*(.bss*)
		*(COMMON)
		_ebss = .;
	} > SRAM
}

_stack_top = ORIGIN(SRAM) + LENGTH(SRAM);
