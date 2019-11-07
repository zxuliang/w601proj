#ifndef __WM_BASE_HEAD__
#define __WM_BASE_HEAD__

#include <wm_regs.h>


typedef unsigned char		bool;
typedef unsigned char		u8;
typedef signed char		s8;
typedef unsigned short		 u16;
typedef signed short		s16;
typedef unsigned int		u32;
typedef signed int		 s32;
typedef unsigned long long	u64;
typedef long long		s64;



#ifdef  TRUE
#undef  TRUE
#endif
#define TRUE                     1

#ifdef  FALSE
#undef  FALSE
#endif
#define FALSE                    0

#define true				1
#define false				0

#define WM_SUCCESS               0
#define WM_FAILED               -1

#define NULL			(0)


#define BIT(x) (1UL << (x))
#define time_after(a, b)  ((long)(b) - (long)(a) < 0)
#define time_before(a,b)	time_after(b,a)

#define TLS_DBGPRT_IO_ERR(x...)		(void)0


#endif