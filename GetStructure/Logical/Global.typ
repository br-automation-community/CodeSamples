
TYPE
	testEnum : 
		(
		red,
		green
		);
	testStructure : 	STRUCT 
		Var1 : USINT;
		Var2 : UDINT;
		Var3 : ARRAY[0..5]OF UDINT;
		Enum : testEnum;
		RealLongVariableName : testSubStructure;
		SubStructure : testSubSubStructure;
	END_STRUCT;
	testSubStructure : 	STRUCT 
		Var1234567 : STRING[80];
		Var22 : UDINT;
		EvenLongerSubVariableName : testSubSubStructure;
	END_STRUCT;
	testSubSubStructure : 	STRUCT 
		Var11 : STRING[80];
		Var22 : UDINT;
		TheLongestSubVariableNameInisde : ARRAY[0..5]OF USINT;
	END_STRUCT;
END_TYPE
