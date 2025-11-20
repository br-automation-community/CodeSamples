PROGRAM _INIT
	testvariable_org;
	testvariable_cpy;

END_PROGRAM

PROGRAM _CYCLIC
	// Call the structure loader functionblock to create a list of all members
	//StructureLoader_0.Enable := TRUE;
	StructureLoader_0.StructAdr := ADR('testvariable_org');
	StructureLoader_0();

	// This block compares the orginial structure against a backup
	// When a difference was detected the variable name is stored in 'diff_str'
	// The change can be acknowldged with 'ack'
	CASE compare OF
		1:
			// Call the structure loader functionblock to create a list of all members
			StructureLoader_1.Enable := TRUE;
			StructureLoader_1.StructAdr := ADR('testvariable_cpy');
			StructureLoader_1();
		
			IF StructureLoader_1.Done AND NOT StructureLoader_1.Error THEN
				i := 0;
				compare := 2;
			END_IF		
		2:	  
			result := brsmemcmp(StructureLoader_1.StructDetails[i].Pointer, StructureLoader_0.StructDetails[i].Pointer, StructureLoader_1.StructDetails[i].DataLength);
			IF result <> 0 THEN
				diff_str := StructureLoader_0.StructDetails[i].Name;
				compare := 3;
			ELSIF i < StructureLoader_0.StructEntries THEN
				i := i + 1;
			ELSE
				i := 0;
			END_IF
		3:
			IF ack THEN
				brsmemcpy(StructureLoader_1.StructDetails[i].Pointer, StructureLoader_0.StructDetails[i].Pointer, StructureLoader_1.StructDetails[i].DataLength);
				i := 0;
				ack := 0;
				diff_str := '';
				compare := 2;
			END_IF

	END_CASE;
		
END_PROGRAM

