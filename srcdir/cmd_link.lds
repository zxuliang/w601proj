/* Linker script to configure memory regions. 
 * Need modifying for a specific board. 
 *   FLASH.ORIGIN: starting address of flash
 *   FLASH.LENGTH: length of flash
 *   RAM.ORIGIN: starting address of RAM bank 0
 *   RAM.LENGTH: length of RAM bank 0
 */
MEMORY
{
  FLASH (rx) : ORIGIN = 0x8010100, LENGTH = 512K /* 512KB-256B */
  RAM (rwx) : ORIGIN = 0x20000000, LENGTH = 0x38000 /* 224KB */
}

/* Linker script to place sections and symbol values. Should be used together
 * with other linker script that defines memory regions FLASH and RAM.
 * It references following symbols, which must be defined in code:
 *   Reset_Handler : Entry of reset handler
 * 
 * It defines following symbols, which code can use without definition:
 *   __etext
 *   __data_start__
 *   __data_end__
 *   __bss_start__
 *   __bss_end__
 *   __end__
 *   end
 *   __HeapLimit
 *   __StackLimit
 *   __StackTop
 *   __stack
 */
ENTRY(Reset_Handler)

SECTIONS
{
	.text :
	{
		KEEP(*(.isr_vector))
		*(.text*)
		*(.rodata*)
		. = ALIGN(4);
	} > FLASH

	__etext = .;
		
	.data : AT (__etext)
	{
		__data_start__ = .;
		*(vtable)
		*(.data*)

		. = ALIGN(4);
		__data_end__ = .;
	} > RAM

	.bss :
	{
		. = ALIGN(4);
		__bss_start__ = .;
		*(.bss*)
		*(COMMON)
		. = ALIGN(4);
		__bss_end__ = .;
	} > RAM 
	
	.stack_dummy (NOLOAD):
	{
		. = ALIGN(8);
		__stack_start__ = .;
		*(.stack*)
		__stack_end__ = .;
	} > RAM

	/* Remove information from the standard libraries */
	/DISCARD/ :
	{
		libc.a ( * )
		libm.a ( * )
		libgcc.a ( * )
	}

	__StackTop = __stack_end__;
	__StackLimit = __StackTop - SIZEOF(.stack_dummy);
	PROVIDE(__stack = __StackTop);	
	ASSERT(__StackTop <= 0x20028000, "stack address error")
}
