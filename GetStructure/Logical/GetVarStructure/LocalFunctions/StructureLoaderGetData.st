
ACTION GetStructureData: 

	// Get the structure member
	Internal.StatusFunction := PV_item(ADR(Internal.CurrentPath), Internal.Structure_Index[Internal.SubStructure_Index], ADR(Internal.CurrentMember));
			
	IF Internal.StatusFunction = 0 THEN
				
		// Build complete members name
		IF Internal.SubStructure_Index > 0 THEN
			brsstrcpy(ADR(Internal.CurrentData.Name), ADR(Internal.CurrentSubPath[1]));
			
			// Make sure new name fits into destination
			IF brsstrlen(ADR(Internal.CurrentData.Name)) + brsstrlen(ADR(Internal.CurrentMember)) + 1 < SIZEOF(Internal.CurrentData.Name) THEN
				brsstrcat(ADR(Internal.CurrentData.Name), ADR('.') );
				brsstrcat(ADR(Internal.CurrentData.Name), ADR(Internal.CurrentMember));
				
			ELSE
				Error := TRUE;
				ErrorText := Internal.CurrentMember;
				brsstrcat(ADR(ErrorText), ADR(' <- excceeds the max length of MAX_VARIABLE_NAME_LEN'));
				Internal.StatusFunction := ERR_VAR_TO_LONG;
				Internal.StateMachine := STRUCTDATA_ERROR;
				RETURN;		
			END_IF;			
		ELSE
			
			Internal.CurrentData.Name := Internal.CurrentMember;
		END_IF;
				
		// Move variable full name
		brsstrcpy(ADR(Internal.CurrentPV), ADR(Internal.CurrentPath));
		
		// Make sure that new name fits into destination
		IF brsstrlen(ADR(Internal.CurrentPV)) + brsstrlen(ADR(Internal.CurrentMember)) + 1 < SIZEOF(Internal.CurrentPV) THEN
			brsstrcat(ADR(Internal.CurrentPV), ADR('.'));
			brsstrcat(ADR(Internal.CurrentPV), ADR(Internal.CurrentMember));
			
		ELSE
			
			Error := TRUE;
			ErrorText := Internal.CurrentMember;
			brsstrcat(ADR(ErrorText), ADR(' <- excceeds the max length of MAX_VARIABLE_NAME_LEN') );
			Internal.StatusFunction := ERR_VAR_TO_LONG;
			Internal.StateMachine := STRUCTDATA_ERROR;
			RETURN;
		END_IF;
				
		// Get variable details
		Internal.StatusFunction := PV_ninfo(ADR(Internal.CurrentPV), ADR(Internal.CurrentData.Datatype), ADR(Internal.CurrentData.DataLength), ADR(Internal.CurrentData.Dimension));
			
		IF Internal.StatusFunction = 0 THEN
			// Get the pointer to this variable
			Internal.StatusFunction := PV_xgetadr(ADR(Internal.CurrentPV), ADR(Internal.CurrentData.Pointer), ADR(Internal.CurrentData.DataLength));
			
			IF Internal.StatusFunction = 0 THEN
				
				// Check if the variable is a structure
				IF (Internal.CurrentData.Datatype = SYSLIB_IEC_TYPE_USER_DEFINED OR Internal.CurrentData.Datatype = SYSLIB_IEC_TYPE_USER_DEFINED_2) AND 
					(Internal.CurrentData.DataLength <> 4) AND 
					(Internal.CurrentData.Dimension <> 1) THEN
						
					// Move to the sub structure
					IF Internal.SubStructure_Index < MAX_STRUCT_DEPTH - 1 THEN
						//Add to the CurrentSubPath
						brsstrcat( ADR(Internal.CurrentSubPath), ADR('.') );
						brsstrcat( ADR(Internal.CurrentSubPath), ADR(Internal.CurrentMember) );
					
						//Move down a level in the structure
						Internal.SubStructure_Index := Internal.SubStructure_Index + 1;
					
						// Maximum number of recursion exceeded
					ELSE
						Error := TRUE;
						ErrorText := 'Max number of recursions exceeded, increase the value of MAX_STRUCT_DEPTH';
						Internal.StatusFunction := ERR_MAX_RECURSIONS;
						Internal.StateMachine := STRUCTDATA_ERROR;
					END_IF;
				
					// Variable is not a structure
				ELSE
					
					AddData;
				END_IF;
			ELSE
				
				Error := TRUE;
				ErrorText := 'Failed to get pointer';
				Internal.StateMachine := STRUCTDATA_ERROR;
			END_IF;			
		ELSE
			
			Error := TRUE;
			ErrorText := 'Failed to get variable details';
			Internal.StateMachine := STRUCTDATA_ERROR;
		END_IF;	
				
		// 14704 - Invalid Component - This suggests that the index listed is not a member and the structure has ended
		// 14713 - No PV Description avalaible - This error is known to occur when requesting information about a variable that is not a structure (e.g. Could be an ENUM)
	ELSIF Internal.StatusFunction = 14704 OR Internal.StatusFunction = 14713 THEN	    
				
		// Check if this is the root structure
		IF Internal.SubStructure_Index = 0 THEN
			Busy := FALSE;
			Done := TRUE;
			StructEntries := Internal.DataList_Index;
			Internal.StateMachine := STRUCTDATA_DONE;
				
			// This is a sub-structure
		ELSE
					
			// Done searching the sub-structure, set the index to zero for next sub-structure
			Internal.Structure_Index[Internal.SubStructure_Index] := 0;

			// Move down a level in the structure tree
			Internal.SubStructure_Index := Internal.SubStructure_Index - 1;
					
			// Find the last period in the subpath, move down the structure tree, the path must move down a level as well
			Internal.Period_Index := 0;
					
			FOR Internal.Index := 0 TO SIZEOF(Internal.CurrentSubPath) - 1 DO
				IF (Internal.CurrentSubPath[Internal.Index] = 46 ) THEN
					Internal.Period_Index := Internal.Index;
				ELSIF (Internal.CurrentSubPath[Internal.Index] = 0 ) THEN
					EXIT;
				END_IF;
			END_FOR;
					
			//Erase the string up to the period
			Internal.CurrentSubPath[Internal.Period_Index] := 0; 
					
			// Check if this is the end of structure or it is not a structure at all
			IF Internal.StatusFunction = 14704 THEN
				
				Internal.Structure_Index[Internal.SubStructure_Index] := Internal.Structure_Index[Internal.SubStructure_Index] + 1;
			ELSIF Internal.StatusFunction = 14713 THEN
				
				AddData;
			ELSE
				
				Error := TRUE;
				ErrorText := 'Unknown error';
				Internal.StateMachine := STRUCTDATA_ERROR;
			END_IF;
					
		END_IF;
				
	ELSE
				
		Error := TRUE;
		ErrorText := 'PV does not exist or not loaded';
		Internal.StateMachine := STRUCTDATA_ERROR;			
	END_IF;
	
END_ACTION
