
ACTION AddData: 

	// Make sure that we dont exceed the maximum list of entries
	IF Internal.DataList_Index < SIZEOF(StructDetails)/SIZEOF(StructDetails[0]) THEN
				
		// Add each array element to the list
		IF Internal.CurrentData.Dimension > 1 THEN
			
			// Save the name of the base variable
			Internal.tempNameStr := Internal.CurrentData.Name;
			Internal.tempPointer := Internal.CurrentData.Pointer;

			// Get details for first element
			brsstrcat(ADR(Internal.CurrentPV), ADR('[0]'));
			Internal.StatusFunction := PV_ninfo(ADR(Internal.CurrentPV), ADR(Internal.CurrentData.Datatype), ADR(Internal.CurrentData.DataLength), ADR(Internal.tempDimension));
			
			IF Internal.StatusFunction = 0 THEN
											
				FOR Internal.Index := 0 TO Internal.CurrentData.Dimension - 1 DO
					// Refresh the base variable name
					Internal.CurrentData.Name := Internal.tempNameStr;
							
					// Append the array index, starting at 0
					brsstrcat(ADR(Internal.CurrentData.Name), ADR('['));
					brsitoa(Internal.Index, ADR(Internal.tempIdxStr));
					brsstrcat(ADR(Internal.CurrentData.Name), ADR(Internal.tempIdxStr));
					brsstrcat(ADR(Internal.CurrentData.Name), ADR(']'));
							
					// Shift pointer based on Datalength of the pointed to variable
					Internal.CurrentData.Pointer := Internal.tempPointer + (DINT_TO_UDINT(Internal.Index) * Internal.CurrentData.DataLength);

					// Check if the current index in the data list is lower than the size of the data list
					IF Internal.DataList_Index < SIZEOF(StructDetails)/SIZEOF(StructDetails[0]) THEN
						
						// Move the data into the final output structure
						brsmemcpy(ADR(StructDetails[Internal.DataList_Index]), ADR(Internal.CurrentData), SIZEOF(StructDetails[0]));
					ELSE
						
						Error := TRUE;
						ErrorText := 'No more entries available, increase the value of MAX_VARIABLE_IDX';
						Internal.StatusFunction := ERR_MAX_ENTRIES;
						Internal.StateMachine := STRUCTDATA_ERROR;
						RETURN;
					END_IF
							
					// Goto the next data list member
					Internal.DataList_Index := Internal.DataList_Index + 1;
					
				END_FOR
					
			ELSE
				
				Error := TRUE;
				ErrorText := 'Failed to get variable details';
				Internal.StateMachine := STRUCTDATA_ERROR;
			END_IF;	
				
		ELSE
			
			// Move the data into the final output structure
			brsmemcpy(ADR(StructDetails[Internal.DataList_Index]), ADR(Internal.CurrentData), SIZEOF(StructDetails[0]));
					
			// Goto the next data list member
			Internal.DataList_Index := Internal.DataList_Index + 1;
				
		END_IF
				
		// Goto the next member index in the current stuctured directory
		Internal.Structure_Index[Internal.SubStructure_Index] := Internal.Structure_Index[Internal.SubStructure_Index] + 1;
				
	ELSE
		
		Error := TRUE;
		ErrorText := 'No more entries available. Increase the value of MAX_VARIABLE_IDX';
		Internal.StateMachine := STRUCTDATA_ERROR;
	END_IF;
	
END_ACTION
