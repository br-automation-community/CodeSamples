# Get structure details using StructureLoader

## Overview

`StructureLoader` is a function block that recursively loads information about a structure (and nested structures) whose variable name is provided via a reference string. It collects metadata such as total size, number of entries, and detailed entry descriptions in `StructDetails`. This can also be used to detect changes in the structure and list the exact variable that was changed.

## Contract (inputs / outputs)

- Inputs
  - `Enable : BOOL` — When set to TRUE, triggers a recursive load of the structure specified by `StructAdr`.
  - `StructAdr : REFERENCE TO STRING[200]` — Reference to a string containing the name (address) of the structure to load.

- Outputs
  - `Busy : BOOL` — TRUE while the loader is actively working.
  - `Done : BOOL` — TRUE when the load completes successfully.
  - `Error : BOOL` — TRUE if an error occurred during loading.
  - `ErrorText : STRING[200]` — Human-readable text describing the error (when `Error` is TRUE).
  - `ErrorCode : UINT` — Numeric error code for programmatic checks.
  - `StructSize : UDINT` — Total size in bytes (or units defined by implementation) of the loaded structure.
  - `StructEntries : UINT` — Number of entries (variables/members) discovered.
  - `StructDetails : ARRAY[0..MAX_VARIABLE_IDX] OF StructLoad_Data_TYP` — Array containing detailed metadata for each discovered variable.

- Internal
  - `Internal : StructInternal_TYP` — Internal state type used for the loader's operation (not intended for external use).
  

## Constants (from `StructVariables.var`)

The loader relies on a small set of project-wide constants defined in `StructVariables.var`. Below are the constants with their default values and recommended usage.

- `MAX_STRUCT_DEPTH : UINT := 10` — Maximum recursion depth when traversing nested structures. If your structures contain deeper nesting, increase this value to avoid `ERR_MAX_RECURSIONS`.

- `MAX_VARIABLE_IDX : UINT := 100` — Maximum number of variable entries the loader can record (this includes expanded array indices). This value defines the upper bound for the `StructDetails` array: `ARRAY[0..MAX_VARIABLE_IDX] OF StructLoad_Data_TYP`. Increase when you expect more members than this limit.

- `MAX_VARIABLE_NAME_LEN : UINT := 200` — Maximum length allowed for a fully qualified variable name passed in `StructAdr`. If you have long namespaces or deep instance paths, increase this value. Note that the loader checks and reports `ERR_VAR_TO_LONG` when the total name length exceeds the supported limit.

- `OVERRIDE : UINT := 2` — Number of executions per cycle. Increasing this value can speed up loading for large structures but may impact cycle time. Adjust based on performance needs.

## Error handling

- Check `Error` after `Busy` clears and `Done` is TRUE. When `Error = TRUE` use `ErrorText` and `ErrorCode` to determine the cause.


