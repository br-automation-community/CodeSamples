(************************************************************************************

Advanced IEC Check Functions Library

File: AdvIecChk.st
Description: Implentation of library functions
Authors:
    - Matt Adams (B&R Industrial Automation)
    - Varad Darji (B&R Industrial Automation)
    - Marcus Mangel (B&R Industrial Automation)

************************************************************************************)

(* Called before the division/module using a SINT value. Returns the divisor if no errors are found *)
(* Replaces CheckDivByte, which may return incorrect results *)
FUNCTION CheckDivSint
    
    IF divisor=0 THEN
        CheckDivSint := 1;
        MakeEntry(55555,'SINT division by 0');
    ELSE
        CheckDivSint := divisor;
    END_IF
    
END_FUNCTION
    
(* Called before the division/module using a USINT value. Returns the divisor if no errors are found *)
(* Replaces CheckDivByte, which may return incorrect results *)
FUNCTION CheckDivUsint
    
    IF divisor=0 THEN
        CheckDivUsint := 1;
        MakeEntry(55555,'USINT division by 0');
    ELSE
        CheckDivUsint := divisor;
    END_IF
    
END_FUNCTION

(* Called before the division/module using an INT value. Returns the divisor if no errors are found *)
(* Replaces CheckDivWord, which may return incorrect results *)
FUNCTION CheckDivInt
    
    IF divisor=0 THEN
        CheckDivInt := 1;
        MakeEntry(55555,'INT division by 0');
    ELSE
        CheckDivInt := divisor;
    END_IF
    
END_FUNCTION

(* Called before the division/module using a UINT value. Returns the divisor if no errors are found *)
(* Replaces CheckDivWord, which may return incorrect results *)
FUNCTION CheckDivUint
    
    IF divisor=0 THEN
        CheckDivUint := 1;
        MakeEntry(55555,'UINT division by 0');
    ELSE
        CheckDivUint := divisor;
    END_IF
    
END_FUNCTION

(* Called before the division/module using a DINT value. Returns the divisor if no errors are found *)
(* Replaces CheckDivDWord, which may return incorrect results *)
FUNCTION CheckDivDint
    
    IF divisor=0 THEN
        CheckDivDint := 1;
        MakeEntry(55555,'DINT division by 0');
    ELSE
        CheckDivDint := divisor;
    END_IF
    
END_FUNCTION

(* Called before the division/module using a UDINT value. Returns the divisor if no errors are found *)
(* Replaces CheckDivDWord, which may return incorrect results *)
FUNCTION CheckDivUdint
    
    IF divisor=0 THEN
        CheckDivUdint := 1;
        MakeEntry(55555,'UDINT division by 0');
    ELSE
        CheckDivUdint := divisor;
    END_IF
    
END_FUNCTION

(* Called before the division/module using a REAL value. Returns the divisor if no errors are found *)
FUNCTION CheckDivReal
    
    IF divisor=0 THEN
        CheckDivReal := 1;
        MakeEntry(55555,'REAL division by 0');
    ELSE
        CheckDivReal := divisor;
    END_IF
    
END_FUNCTION

(* Called before the division/module using a LREAL value. Returns the divisor if no errors are found *)
(* CANNOT BE USED on SG3 OR SGC targets!! *)
FUNCTION CheckDivLReal
    
    IF divisor=0 THEN
        CheckDivLReal := 1;
        MakeEntry(55555,'LREAL division by 0');
    ELSE
        CheckDivLReal := divisor;
    END_IF
    
END_FUNCTION

(* Called before accessing an array. Returns the index if no errors are found.
Otherwise, returns the problematic index bound *)
FUNCTION CheckBounds
    
    IF index < lower THEN
        CheckBounds := lower; // Unless: See end of function
        brsitoa(lower, ADR(LowString));
        brsitoa(upper, ADR(UpString));
        brsitoa(index, ADR(IndexString));
        brsstrcpy(ADR(ErrorText),ADR('Array Index '));
        StrCatToMaxLen(ADR(ErrorText),ADR(IndexString),ADVIECCHK_MAX_STRING_LEN);
        StrCatToMaxLen(ADR(ErrorText),ADR(' is outside range ['),ADVIECCHK_MAX_STRING_LEN);
        StrCatToMaxLen(ADR(ErrorText),ADR(LowString),ADVIECCHK_MAX_STRING_LEN);
        StrCatToMaxLen(ADR(ErrorText),ADR('..'),ADVIECCHK_MAX_STRING_LEN);
        StrCatToMaxLen(ADR(ErrorText),ADR(UpString),ADVIECCHK_MAX_STRING_LEN);
        StrCatToMaxLen(ADR(ErrorText),ADR(']'),ADVIECCHK_MAX_STRING_LEN);
        MakeEntry(55555,ErrorText);
    ELSIF index > upper THEN
        CheckBounds := upper; // Unless: See end of function
        brsitoa(lower, ADR(LowString));
        brsitoa(upper, ADR(UpString));
        brsitoa(index, ADR(IndexString));
        brsstrcpy(ADR(ErrorText),ADR('Array Index '));
        StrCatToMaxLen(ADR(ErrorText),ADR(IndexString),ADVIECCHK_MAX_STRING_LEN);
        StrCatToMaxLen(ADR(ErrorText),ADR(' is outside range ['),ADVIECCHK_MAX_STRING_LEN);
        StrCatToMaxLen(ADR(ErrorText),ADR(LowString),ADVIECCHK_MAX_STRING_LEN);
        StrCatToMaxLen(ADR(ErrorText),ADR('..'),ADVIECCHK_MAX_STRING_LEN);
        StrCatToMaxLen(ADR(ErrorText),ADR(UpString),ADVIECCHK_MAX_STRING_LEN);
        StrCatToMaxLen(ADR(ErrorText),ADR(']'),ADVIECCHK_MAX_STRING_LEN);
        MakeEntry(55555,ErrorText);
    ELSE
        CheckBounds := index;
    END_IF
    
END_FUNCTION

(* Called before write accessing an enumeration variable. Returns the value if no errors are found.
Otherwise, returns the problematic value bound *)
FUNCTION CheckRange
    
	IF value < lower THEN
		CheckRange := lower; // Unless: See end of function
		brsitoa(lower, ADR(LowString));
		brsitoa(upper, ADR(UpString));
		brsitoa(value, ADR(ValueString));
		brsstrcpy(ADR(ErrorText),ADR('Enumeration Value '));
		StrCatToMaxLen(ADR(ErrorText),ADR(ValueString),ADVIECCHK_MAX_STRING_LEN);
		StrCatToMaxLen(ADR(ErrorText),ADR(' is outside range ['),ADVIECCHK_MAX_STRING_LEN);
		StrCatToMaxLen(ADR(ErrorText),ADR(LowString),ADVIECCHK_MAX_STRING_LEN);
		StrCatToMaxLen(ADR(ErrorText),ADR('..'),ADVIECCHK_MAX_STRING_LEN);
		StrCatToMaxLen(ADR(ErrorText),ADR(UpString),ADVIECCHK_MAX_STRING_LEN);
		StrCatToMaxLen(ADR(ErrorText),ADR(']'),ADVIECCHK_MAX_STRING_LEN);
		MakeEntry(55555,ErrorText);	
	ELSIF value > upper THEN
		CheckRange := upper; // Unless: See end of function
		brsitoa(lower, ADR(LowString));
		brsitoa(upper, ADR(UpString));
		brsitoa(value, ADR(ValueString));
		brsstrcpy(ADR(ErrorText),ADR('Enumeration Value '));
		StrCatToMaxLen(ADR(ErrorText),ADR(ValueString),ADVIECCHK_MAX_STRING_LEN);
		StrCatToMaxLen(ADR(ErrorText),ADR(' is outside range ['),ADVIECCHK_MAX_STRING_LEN);
		StrCatToMaxLen(ADR(ErrorText),ADR(LowString),ADVIECCHK_MAX_STRING_LEN);
		StrCatToMaxLen(ADR(ErrorText),ADR('..'),ADVIECCHK_MAX_STRING_LEN);
		StrCatToMaxLen(ADR(ErrorText),ADR(UpString),ADVIECCHK_MAX_STRING_LEN);
		StrCatToMaxLen(ADR(ErrorText),ADR(']'),ADVIECCHK_MAX_STRING_LEN);
		MakeEntry(55555,ErrorText);
	ELSE
		CheckRange := value;
	END_IF
       
END_FUNCTION

(* Called before write access to a variable with the data type "Subrange" if the subrange is used on a signed data type. Returns the value if no errors are found.
Otherwise, returns the problematic value bound *)
FUNCTION CheckSignedSubrange
    
    IF value < lower THEN
        CheckSignedSubrange := lower; // Unless: See end of function
        brsitoa(lower, ADR(LowString));
        brsitoa(upper, ADR(UpString));
        brsitoa(value, ADR(ValueString));
        brsstrcpy(ADR(ErrorText),ADR('Signed Subrange Index '));
        StrCatToMaxLen(ADR(ErrorText),ADR(ValueString),ADVIECCHK_MAX_STRING_LEN);
        StrCatToMaxLen(ADR(ErrorText),ADR(' is outside range ['),ADVIECCHK_MAX_STRING_LEN);
        StrCatToMaxLen(ADR(ErrorText),ADR(LowString),ADVIECCHK_MAX_STRING_LEN);
        StrCatToMaxLen(ADR(ErrorText),ADR('..'),ADVIECCHK_MAX_STRING_LEN);
        StrCatToMaxLen(ADR(ErrorText),ADR(UpString),ADVIECCHK_MAX_STRING_LEN);
        StrCatToMaxLen(ADR(ErrorText),ADR(']'),ADVIECCHK_MAX_STRING_LEN);
        MakeEntry(55555,ErrorText);	
    ELSIF value > upper THEN
        CheckSignedSubrange := upper; // Unless: See end of function	
        brsitoa(lower, ADR(LowString));
        brsitoa(upper, ADR(UpString));
        brsitoa(value, ADR(ValueString));
        StrCatToMaxLen(ADR(ErrorText),ADR('Signed Subrange Index '),ADVIECCHK_MAX_STRING_LEN);
        StrCatToMaxLen(ADR(ErrorText),ADR(ValueString),ADVIECCHK_MAX_STRING_LEN);
        StrCatToMaxLen(ADR(ErrorText),ADR(' is outside range ['),ADVIECCHK_MAX_STRING_LEN);
        StrCatToMaxLen(ADR(ErrorText),ADR(LowString),ADVIECCHK_MAX_STRING_LEN);
        StrCatToMaxLen(ADR(ErrorText),ADR('..'),ADVIECCHK_MAX_STRING_LEN);
        StrCatToMaxLen(ADR(ErrorText),ADR(UpString),ADVIECCHK_MAX_STRING_LEN);
        StrCatToMaxLen(ADR(ErrorText),ADR(']'),ADVIECCHK_MAX_STRING_LEN);
        MakeEntry(55555,ErrorText);
    ELSE
        CheckSignedSubrange := value;
    END_IF
    
END_FUNCTION

(* Called before write access to a variable with the data type "Subrange" if the subrange is used on an unsigned data type. Returns the value if no errors are found.
Otherwise, returns the problematic value bound *)
FUNCTION CheckUnsignedSubrange
    
    IF value < lower THEN
        CheckUnsignedSubrange := lower; // Unless: See end of function
        brsitoa(lower, ADR(LowString));
        brsitoa(upper, ADR(UpString));
        brsitoa(value, ADR(ValueString));
        brsstrcpy(ADR(ErrorText),ADR('Unsigned Subrange Index '));
        StrCatToMaxLen(ADR(ErrorText),ADR(ValueString),ADVIECCHK_MAX_STRING_LEN);
        StrCatToMaxLen(ADR(ErrorText),ADR(' is outside range ['),ADVIECCHK_MAX_STRING_LEN);
        StrCatToMaxLen(ADR(ErrorText),ADR(LowString),ADVIECCHK_MAX_STRING_LEN);
        StrCatToMaxLen(ADR(ErrorText),ADR('..'),ADVIECCHK_MAX_STRING_LEN);
        StrCatToMaxLen(ADR(ErrorText),ADR(UpString),ADVIECCHK_MAX_STRING_LEN);
        StrCatToMaxLen(ADR(ErrorText),ADR(']'),ADVIECCHK_MAX_STRING_LEN);
        MakeEntry(55555,ErrorText);	
    ELSIF value > upper THEN
        CheckUnsignedSubrange := upper; // Unless: See end of function
        brsitoa(lower, ADR(LowString));
        brsitoa(upper, ADR(UpString));
        brsitoa(value, ADR(ValueString));
        brsstrcpy(ADR(ErrorText),ADR('Unsigned Subrange Index '));
        StrCatToMaxLen(ADR(ErrorText),ADR(ValueString),ADVIECCHK_MAX_STRING_LEN);
        StrCatToMaxLen(ADR(ErrorText),ADR(' is outside range ['),ADVIECCHK_MAX_STRING_LEN);
        StrCatToMaxLen(ADR(ErrorText),ADR(LowString),ADVIECCHK_MAX_STRING_LEN);
        StrCatToMaxLen(ADR(ErrorText),ADR('..'),ADVIECCHK_MAX_STRING_LEN);
        StrCatToMaxLen(ADR(ErrorText),ADR(UpString),ADVIECCHK_MAX_STRING_LEN);
        StrCatToMaxLen(ADR(ErrorText),ADR(']'),ADVIECCHK_MAX_STRING_LEN);
        MakeEntry(55555,ErrorText);
    ELSE
        CheckUnsignedSubrange := value;
    END_IF
    
END_FUNCTION

(* Called before (read) accessing a memory address using a dynamic variable (ADR). Returns the input address *)
// Note: We cannot substitute in any addresses here
// This always returns a zero address
// That means a pagefault will occur no matter what, but at least we can log why
FUNCTION CheckReadAccess
    
    IF address=0 THEN
        MakeEntry(55555,'Read from memory address of zero');
        CheckReadAccess:=0;
    ELSE
        CheckReadAccess:=address;
    END_IF
    
END_FUNCTION

(* Called before (write) accessing a memory address using a dynamic variable (ADR). Returns the input address *)
// Note: We cannot substitute in any addresses here
// This always returns a zero address
// That means a pagefault will occur no matter what, but at least we can log why
FUNCTION CheckWriteAccess
    
    IF address=0 THEN
        MakeEntry(55555,'Write to memory address of zero'); 
        CheckWriteAccess:=0;
    ELSE
        CheckWriteAccess:=address;
    END_IF
    
END_FUNCTION

(* Creates a Logger entry detailing any errors. Returns a pointer to out_text *)
FUNCTION MakeEntry
    
    // Get task name and add to error text string
	status_name := ST_name(0,ADR(taskname),ADR(group));
    
	brsmemset(ADR(out_text),0,SIZEOF(out_text)); // We need to make sure the data is null terminated, so start with all zeros
	StrCatToMaxLen(ADR(out_text),ADR(ErrorText), ADVIECCHK_MAX_STRING_LEN);

	IF status_name = 0 THEN
		StrCatToMaxLen(ADR(out_text),ADR(' in task '), ADVIECCHK_MAX_STRING_LEN);
		StrCatToMaxLen(ADR(out_text),ADR('"'), ADVIECCHK_MAX_STRING_LEN);
		StrCatToMaxLen(ADR(out_text),ADR(taskname), ADVIECCHK_MAX_STRING_LEN);
		StrCatToMaxLen(ADR(out_text),ADR('"'), ADVIECCHK_MAX_STRING_LEN);
	END_IF;
    
	// Finalize logbook entry - Write to the existing User logbook
	// It would be possible to create our own logbook, but that would be much more complex
	error_facility := 0; // See ArEventLog documentation on the 32-bit event ID
    
	fb_ArEventLogGetIdent.Execute := TRUE;
	fb_ArEventLogGetIdent.Name := '$$arlogusr'; // This is the only system logbook we can access
	fb_ArEventLogGetIdent();
    
	fb_ArEventLogWrite.Execute := TRUE;
	fb_ArEventLogWrite.Ident := fb_ArEventLogGetIdent.Ident;
	fb_ArEventLogWrite.EventID := ArEventLogMakeEventID(arEVENTLOG_SEVERITY_ERROR,error_facility,ErrorCode);
	fb_ArEventLogWrite.AddData := ADR(out_text);
	fb_ArEventLogWrite.AddDataFormat := arEVENTLOG_ADDFORMAT_TEXT;
	fb_ArEventLogWrite.AddDataSize := MIN(SIZEOF(out_text),brsstrlen(ADR(out_text))+1); // If string doesn't fill the whole buffer, take just it's length
	fb_ArEventLogWrite.ObjectID := 'AdvIecChk';                                         // plus the next char (should be a zero, this is the trailing null char)
	fb_ArEventLogWrite();
    
	MakeEntry := brsstrlen(ADR(out_text));
    
	brsmemcpy(1,1,1); // Create a pagefault on purpose to get the backtrace data
	
END_FUNCTION

(* Concatenates two strings, but keeps the result under the max allowed length.
Also ensures the the string ends in a zero (null).
Returns the length of the new string *)
FUNCTION StrCatToMaxLen
    
    IF (pDest = 0) OR (pSrc = 0) OR (MaxLength = 0) THEN
        StrCatToMaxLen := 0;
        RETURN;
    END_IF;
    
    destLen := brsstrlen(pDest);
    srcLen := brsstrlen(pSrc);
    
    lenToCopy := MIN(srcLen,(MaxLength - destLen)); // Copy the full src string if possible, otherwise copy a partial string
    brsmemcpy(pDest + destLen, pSrc, lenToCopy);
    brsmemset(pDest + destLen + lenToCopy, 0, 1); // Ensure trailing null character
    StrCatToMaxLen := destLen + lenToCopy;

END_FUNCTION
