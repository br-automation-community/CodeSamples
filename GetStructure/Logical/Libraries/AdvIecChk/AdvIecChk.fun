(************************************************************************************

Advanced IEC Check Functions Library

File: AdvIecChk.fun
Description: Declaration of library functions

!! Note: See the Automation Studio Help file before modifying these declarations!   !!
!! Most of these functions must be declared exactly as-is in order for the          !!
!! processor to recognize them as check functions. The implementation can change    !!
!! but the declaration cannot!                                                      !!

Authors:
    - Matt Adams (B&R Industrial Automation)
    - Varad Darji (B&R Industrial Automation)
    - Marcus Mangel (B&R Industrial Automation)

************************************************************************************)

FUNCTION CheckDivSint : SINT (*Called before the division/module using a SINT value. Returns the divisor if no errors are found*)
	VAR_INPUT
		divisor : SINT; (*For division: Value that should be divided by. For modulo: Right operand*)
	END_VAR
END_FUNCTION

FUNCTION CheckDivUsint : USINT (*Called before the division/module using a USINT value. Returns the divisor if no errors are found*)
	VAR_INPUT
		divisor : USINT; (*For division: Value that should be divided by. For modulo: Right operand*)
	END_VAR
END_FUNCTION

FUNCTION CheckDivInt : INT (*Called before the division/module using a INT value. Returns the divisor if no errors are found*)
	VAR_INPUT
		divisor : INT; (*For division: Value that should be divided by. For modulo: Right operand*)
	END_VAR
END_FUNCTION

FUNCTION CheckDivUint : UINT (*Called before the division/module using a UINT value. Returns the divisor if no errors are found*)
	VAR_INPUT
		divisor : UINT; (*For division: Value that should be divided by. For modulo: Right operand*)
	END_VAR
END_FUNCTION

FUNCTION CheckDivDint : DINT (*Called before the division/module using a DINT value. Returns the divisor if no errors are found*)
	VAR_INPUT
		divisor : DINT; (*For division: Value that should be divided by. For modulo: Right operand*)
	END_VAR
END_FUNCTION

FUNCTION CheckDivUdint : UDINT (*Called before the division/module using a UDINT value. Returns the divisor if no errors are found*)
	VAR_INPUT
		divisor : UDINT; (*For division: Value that should be divided by. For modulo: Right operand*)
	END_VAR
END_FUNCTION

FUNCTION CheckDivReal : REAL (*Called before the division/module using a REAL value. Returns the divisor if no errors are found*)
	VAR_INPUT
		divisor : REAL; (*For division: Value that should be divided by. For modulo: Right operand*)
	END_VAR
END_FUNCTION

FUNCTION CheckDivLReal : LREAL (*Called before the division/module using a LREAL value. Returns the divisor if no errors are found. (Cannot be used on SG3 or SGC targets)*)
	VAR_INPUT
		divisor : LREAL; (*For division: Value that should be divided by. For modulo: Right operand*)
	END_VAR
END_FUNCTION

FUNCTION CheckBounds : DINT (*Called before accessing an array. Returns the index if no errors are found. Otherwise, returns the problematic index bound*)
	VAR_INPUT
		index : DINT; (*Index being accessed*)
		lower : DINT; (*Lower bound (lowest possible index) of the array*)
		upper : DINT; (*Upper bound (highest possible index) of the array*)
	END_VAR
	VAR
		LowString : STRING[ADVIECCHK_MAX_STRING_LEN]; (*[INTERNAL] Lower bound as a string*)
		UpString : STRING[ADVIECCHK_MAX_STRING_LEN]; (*[INTERNAL] Upper bound as a string*)
		IndexString : STRING[ADVIECCHK_MAX_STRING_LEN]; (*[INTERNAL] Index as a string*)
		ErrorText : STRING[ADVIECCHK_MAX_STRING_LEN]; (*[INTERNAL] Error text created for a long entry based on input data*)
	END_VAR
END_FUNCTION

FUNCTION CheckRange : DINT (*Called before write accessing an enumeration variable. Returns the value if no errors are found. Otherwise, returns the problematic value bound*)
	VAR_INPUT
		value : DINT; (*Enumeration value being accessed*)
		lower : DINT; (*Lower bound (lowest possible value) of the enumeration*)
		upper : DINT; (*Upper bound (highest possible value) of the enumeration*)
	END_VAR
	VAR
		LowString : STRING[ADVIECCHK_MAX_STRING_LEN]; (*[INTERNAL] Lower bound as a string*)
		UpString : STRING[ADVIECCHK_MAX_STRING_LEN]; (*[INTERNAL] Upper bound as a string*)
		ValueString : STRING[ADVIECCHK_MAX_STRING_LEN]; (*[INTERNAL] Value as a string*)
		ErrorText : STRING[ADVIECCHK_MAX_STRING_LEN]; (*[INTERNAL] Error text created for a long entry based on input data*)
	END_VAR
END_FUNCTION

FUNCTION CheckSignedSubrange : DINT (*Called before write access to a variable with the data type "Subrange" if the subrange is used on a signed data type. Returns the value if no errors are found.
Otherwise, returns the problematic value bound*)
	VAR_INPUT
		value : DINT; (*Index being accessed*)
		lower : DINT; (*Lower bound (lowest possible index) of the subrange*)
		upper : DINT; (*Upper bound (highest possible index) of the subrange*)
	END_VAR
	VAR
		LowString : STRING[ADVIECCHK_MAX_STRING_LEN]; (*[INTERNAL] Lower bound as a string*)
		UpString : STRING[ADVIECCHK_MAX_STRING_LEN]; (*[INTERNAL] Lower bound as a string*)
		ValueString : STRING[ADVIECCHK_MAX_STRING_LEN]; (*[INTERNAL] Value as a string*)
		ErrorText : STRING[ADVIECCHK_MAX_STRING_LEN]; (*[INTERNAL] Error text created for a long entry based on input data*)
	END_VAR
END_FUNCTION

FUNCTION CheckUnsignedSubrange : UDINT (*Called before write access to a variable with the data type "Subrange" if the subrange is used on an unsigned data type. Returns the value if no errors are found.
Otherwise, returns the problematic value bound*)
	VAR_INPUT
		value : UDINT; (*Index being accessed*)
		lower : UDINT; (*Lower bound (lowest possible index) of the subrange*)
		upper : UDINT; (*Upper bound (highest possible index) of the subrange*)
	END_VAR
	VAR
		LowString : STRING[ADVIECCHK_MAX_STRING_LEN]; (*[INTERNAL] Lower bound as a string*)
		UpString : STRING[ADVIECCHK_MAX_STRING_LEN]; (*[INTERNAL] Upper bound as a string*)
		ValueString : STRING[ADVIECCHK_MAX_STRING_LEN]; (*[INTERNAL] Value as a string*)
		ErrorText : STRING[ADVIECCHK_MAX_STRING_LEN]; (*[INTERNAL] Error text created for a long entry based on input data*)
	END_VAR
END_FUNCTION

FUNCTION CheckReadAccess : UDINT (*Called before (read) accessing a memory address using a dynamic variable (ADR). Returns the input address*)
	VAR_INPUT
		address : UDINT; (*Address of the memory area being accessed*)
	END_VAR
END_FUNCTION

FUNCTION CheckWriteAccess : UDINT (*Called before (write) accessing a memory address using a dynamic variable (ADR). Returns the input address*)
	VAR_INPUT
		address : UDINT; (*Address of the memory area being accessed*)
	END_VAR
END_FUNCTION

FUNCTION MakeEntry : UDINT (*Creates a Logger entry detailing any errors. Returns a pointer to out_text*)
	VAR_INPUT
		ErrorCode : UINT; (*Error code that is used to generate a logbook Entry ID. Valid values are 0 to 65535*)
		ErrorText : STRING[ADVIECCHK_MAX_STRING_LEN]; (*Message string for the logbook. Additional characters will be added by the function before publishing the logbook entry*)
	END_VAR
	VAR
		taskname : STRING[ADVIECCHK_MAX_STRING_LEN]; (*[INTERNAL] Name of the task which caused the error. From ST_name()*)
		group : USINT; (*[INTERNAL] Task group number - See docs for ST_name in sys_lib. This will always be zero*)
		status_name : UINT; (*[INTERNAL] Return status of ST_name()*)
		out_text : STRING[ADVIECCHK_MAX_STRING_LEN]; (*[INTERNAL] Final error message text that is written to the logbook. Must be null terminated and maximum 32 characters (see ERRxwarning() docs)*)
		error_facility : UINT; (*[INTERNAL] Facility used to create the log Event ID. See ArEventLog documentation*)
		fb_ArEventLogGetIdent : ArEventLogGetIdent; (*[INTERNAL] Function block to get the ident of a logbook*)
		fb_ArEventLogWrite : ArEventLogWrite; (*[INTERNAL] Function block to write a log entry to the logbook*)
	END_VAR
END_FUNCTION

FUNCTION StrCatToMaxLen : UDINT (*Concatenates two strings, but keeps the result under the max allowed length. Also ensures the the string ends in a zero (null). Returns the length of the new string*)
	VAR_INPUT
		pDest : UDINT; (*Address of the destination string (will be modified)*)
		pSrc : UDINT; (*Address of the source string (not modified)*)
		MaxLength : UDINT; (*Maximum character length of the destination string*)
	END_VAR
	VAR
		destLen : UDINT; (*[INTERNAL] Holds the length of the string at pDest*)
		srcLen : UDINT; (*[INTERNAL] Holds the length of the string at pSrc*)
		lenToCopy : UDINT; (*[INTERNAL] Number of bytes to be copied, in the case of a partial string*)
	END_VAR
END_FUNCTION
