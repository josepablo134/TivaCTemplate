/*
 * All available sections on ARM GCC
 * #pragma arm section code="code" 
 * #pragma arm section rodata="constants" 
 * #pragma arm section rwdata="variables" 
 * #pragma arm section zidata="rstsafe" 
 **/

#define MEMMAP_ERROR

%s

#ifdef MEMMAP_ERROR
	#error "MemMap.h: Wrong pragma command / unknown memory section used. Please use only valid pragma commands and known memory sections."
#endif
