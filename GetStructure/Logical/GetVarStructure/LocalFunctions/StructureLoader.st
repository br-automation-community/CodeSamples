FUNCTION_BLOCK StructureLoader
	
	IF EDGENEG(Enable) THEN
		Internal.StateMachine := STRUCTDATA_INIT;
	END_IF
	
	CASE (Internal.StateMachine) OF
		
		STRUCTDATA_INIT:
			// Clear Indexes and structures
			brsmemset(ADR(StructDetails), 0, SIZEOF(StructDetails));
			brsmemset(ADR(Internal), 0, SIZEOF(Internal));
			Error := FALSE;
			ErrorCode := 0;
			ErrorText := '';
			StructSize := 0;
			StructEntries := 0;
			Done := FALSE;
			
			Internal.StateMachine := STRUCTDATA_WAIT_FOR_CMD;
			
		STRUCTDATA_WAIT_FOR_CMD:
			
			IF EDGEPOS(Enable) THEN
				// Check if the pointer is good
				IF ADR(StructAdr) = 0 THEN
					Error := TRUE;
					ErrorText := 'PV name is NULL';
					Internal.StateMachine := STRUCTDATA_ERROR;					
				ELSE				
					Busy := TRUE;
					Done := FALSE;
					Internal.StateMachine := STRUCTDATA_LOAD;
				
				END_IF;
			END_IF;	
			
		STRUCTDATA_LOAD:
			
			FOR Internal.Cycles:=0 TO OVERRIDE DO

				// Start with the main structure
				brsstrcpy(ADR(Internal.CurrentPath), ADR(StructAdr));
				brsstrcat(ADR(Internal.CurrentPath), ADR(Internal.CurrentSubPath));
				
				// Get basic variable information
				Internal.StatusFunction := PV_ninfo( ADR(StructAdr), ADR(Internal.CurrentData.Datatype), ADR(Internal.CurrentData.DataLength), ADR(Internal.CurrentData.Dimension));
				
				IF ErrorCode = 0 THEN
					StructSize := Internal.CurrentData.DataLength;
					GetStructureData;
					IF Internal.StateMachine <> STRUCTDATA_LOAD THEN
						EXIT;
					END_IF
				ELSE
					Error := TRUE;
					ErrorText := 'Failed to get struct size';
					Internal.StateMachine := STRUCTDATA_ERROR;
				END_IF;	
			END_FOR;
			
		STRUCTDATA_DONE:
			
			Busy := FALSE;
			Done := TRUE;
			
			IF NOT Enable THEN
				Done := FALSE;
				Internal.StateMachine := STRUCTDATA_WAIT_FOR_CMD;
				StructEntries := 0;
			END_IF;
	
		STRUCTDATA_ERROR:
			ErrorCode := Internal.StatusFunction;
			
			IF NOT Enable THEN
				Error := FALSE;
				ErrorText := '';
				Internal.StateMachine := STRUCTDATA_WAIT_FOR_CMD;
			END_IF;
			
	END_CASE;
	
END_FUNCTION_BLOCK
