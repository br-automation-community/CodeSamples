
FUNCTION_BLOCK StructureLoader
	VAR_INPUT
		Enable : BOOL; (*Will recursively load the structure and all structures inside the structure who's variable name is provided via StructAdr*)
		StructAdr : REFERENCE TO STRING[200]; (*Pointer to a string of the structure to be loaded*)
	END_VAR
	VAR_OUTPUT
		Busy : BOOL;
		Done : BOOL;
		Error : BOOL;
		ErrorText : STRING[200];
		ErrorCode : UINT;
		StructSize : UDINT;
		StructEntries : UINT;
		StructDetails : ARRAY[0..MAX_VARIABLE_IDX] OF StructLoad_Data_TYP;
	END_VAR
	VAR
		Internal : StructInternal_TYP;
		zzEdge00000 : BOOL;
		zzEdge00001 : BOOL;
	END_VAR
END_FUNCTION_BLOCK
