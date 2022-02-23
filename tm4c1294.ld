MEMORY
{
    FLASH (rx) : ORIGIN = 0x00000000, LENGTH = 1M
    SRAM  (rwx) : ORIGIN = 0x20000000, LENGTH = 256K
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
