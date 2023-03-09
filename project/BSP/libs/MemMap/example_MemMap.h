/*
 * All available sections on ARM GCC
 * #pragma arm section code="code" 
 * #pragma arm section rodata="constants" 
 * #pragma arm section rwdata="variables" 
 * #pragma arm section zidata="rstsafe" 
 **/

#define MEMMAP_ERROR

	#if defined START_SEC_CODE 
		#pragma arm section code=".text.global.qm"
		#undef START_SEC_CODE 
		#undef MEMMAP_ERROR
	#elif defined START_SEC_CONST 
		#pragma arm section rodata=".rodata"
		#undef START_SEC_CONST 
		#undef MEMMAP_ERROR
	#elif defined START_SEC_VAR_INIT 
		#pragma arm section rwdata=".data.global.init"
		#undef START_SEC_VAR_INIT 
		#undef MEMMAP_ERROR
	#elif defined START_SEC_VAR_ZERO 
		#pragma arm section rwdata=".bss.global.zero"
		#undef START_SEC_VAR_ZERO 
		#undef MEMMAP_ERROR
	#elif defined START_SEC_VAR_NOINIT 
		#pragma arm section zidata=".bss.global.rstsafe"
		#undef START_SEC_VAR_NOINIT 
		#undef MEMMAP_ERROR
	#elif defined STOP_SEC_CODE 
		#pragma arm section code=""
		#undef STOP_SEC_CODE 
		#undef MEMMAP_ERROR
	#elif defined STOP_SEC_CONST 
		#pragma arm section rodata=""
		#undef STOP_SEC_CONST 
		#undef MEMMAP_ERROR
	#elif defined STOP_SEC_VAR_INIT 
		#pragma arm section rwdata=""
		#undef STOP_SEC_VAR_INIT 
		#undef MEMMAP_ERROR
	#elif defined STOP_SEC_VAR_ZERO 
		#pragma arm section rwdata=""
		#undef STOP_SEC_VAR_ZERO 
		#undef MEMMAP_ERROR
	#elif defined STOP_SEC_VAR_NOINIT 
		#pragma arm section zidata=""
		#undef STOP_SEC_VAR_NOINIT 
		#undef MEMMAP_ERROR
	#endif

#ifdef MEMMAP_ERROR
	#error "MemMap.h: Wrong pragma command / unknown memory section used. Please use only valid pragma commands and known memory sections."
#endif
