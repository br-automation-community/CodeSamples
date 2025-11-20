
TYPE
	StructLoad_Data_TYP : 	STRUCT 
		Name : STRING[MAX_VARIABLE_NAME_LEN]; (*Member's name*)
		Pointer : UDINT; (*Member's memory address*)
		Datatype : UDINT; (*Member's datatype (See ad7773ad-be51-4500-a7ba-b8f12743a77a for more info)*)
		DataLength : UDINT; (*Number of Byte the member memory consumes*)
		Dimension : UDINT; (*If an array, the number of array elements.  If a structure, the number of structure elements*)
	END_STRUCT;
	StructInternal_TYP : 	STRUCT 
		StateMachine : StructData_StateMachine_TYP;
		StatusFunction : UINT;
		Index : UDINT;
		Cycles : UINT;
		DataList_Index : UINT;
		Structure_Index : ARRAY[0..MAX_STRUCT_DEPTH]OF USINT;
		SubStructure_Index : UDINT;
		Period_Index : UDINT;
		CurrentPath : STRING[TOTAL_STRUCTURE_NAME_LEN];
		CurrentSubPath : ARRAY[0..MAX_VARIABLE_NAME_LEN]OF USINT;
		CurrentMember : STRING[SINGLE_VARIABLE_NAME_LEN];
		CurrentPV : STRING[TOTAL_STRUCTURE_NAME_LEN];
		CurrentData : StructLoad_Data_TYP;
		tempIdxStr : STRING[10];
		tempNameStr : STRING[TOTAL_STRUCTURE_NAME_LEN];
		tempPointer : UDINT;
		tempDimension : UDINT; (*If an array, the number of array elements.  If a structure, the number of structure elements*)
	END_STRUCT;
	StructData_StateMachine_TYP : 
		(
		STRUCTDATA_INIT, (*Initialize State !MUST BE FIRST!*)
		STRUCTDATA_WAIT_FOR_CMD, (*Function block will wait for a command in this state*)
		STRUCTDATA_LOAD, (*Loading is active*)
		STRUCTDATA_DONE, (*Loading is done*)
		STRUCTDATA_ERROR (*An error occured.  The error will be reset once the command is set low.*)
		);
END_TYPE
