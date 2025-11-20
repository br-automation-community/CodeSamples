/* Automation Studio generated header file */
/* Do not edit ! */
/* AdvIecChk 2.00.0 */

#ifndef _ADVIECCHK_
#define _ADVIECCHK_
#ifdef __cplusplus
extern "C" 
{
#endif
#ifndef _AdvIecChk_VERSION
#define _AdvIecChk_VERSION 2.00.0
#endif

#include <bur/plctypes.h>

#ifndef _BUR_PUBLIC
#define _BUR_PUBLIC
#endif
#ifdef _SG3
		#include "AsBrStr.h"
		#include "sys_lib.h"
		#include "ArEventLog.h"
#endif
#ifdef _SG4
		#include "AsBrStr.h"
		#include "sys_lib.h"
		#include "ArEventLog.h"
#endif
#ifdef _SGC
		#include "AsBrStr.h"
		#include "sys_lib.h"
		#include "ArEventLog.h"
#endif


/* Constants */
#ifdef _REPLACE_CONST
 #define ADVIECCHK_MAX_STRING_LEN 64U
#else
 _GLOBAL_CONST unsigned char ADVIECCHK_MAX_STRING_LEN;
#endif







/* Prototyping of functions and function blocks */
_BUR_PUBLIC signed char CheckDivSint(signed char divisor);
_BUR_PUBLIC unsigned char CheckDivUsint(unsigned char divisor);
_BUR_PUBLIC signed short CheckDivInt(signed short divisor);
_BUR_PUBLIC unsigned short CheckDivUint(unsigned short divisor);
_BUR_PUBLIC signed long CheckDivDint(signed long divisor);
_BUR_PUBLIC unsigned long CheckDivUdint(unsigned long divisor);
_BUR_PUBLIC float CheckDivReal(float divisor);
_BUR_PUBLIC double CheckDivLReal(double divisor);
_BUR_PUBLIC signed long CheckBounds(signed long index, signed long lower, signed long upper);
_BUR_PUBLIC signed long CheckRange(signed long value, signed long lower, signed long upper);
_BUR_PUBLIC signed long CheckSignedSubrange(signed long value, signed long lower, signed long upper);
_BUR_PUBLIC unsigned long CheckUnsignedSubrange(unsigned long value, unsigned long lower, unsigned long upper);
_BUR_PUBLIC unsigned long CheckReadAccess(unsigned long address);
_BUR_PUBLIC unsigned long CheckWriteAccess(unsigned long address);
_BUR_PUBLIC unsigned long MakeEntry(unsigned short ErrorCode, plcstring* ErrorText);
_BUR_PUBLIC unsigned long StrCatToMaxLen(unsigned long pDest, unsigned long pSrc, unsigned long MaxLength);


#ifdef __cplusplus
};
#endif
#endif /* _ADVIECCHK_ */

