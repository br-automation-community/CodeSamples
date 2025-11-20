SHELL := cmd.exe
CYGWIN=nontsec
export PATH := C:\Program Files\Python313\Scripts\;C:\Program Files\Python313\;C:\Program Files (x86)\VMware\VMware Workstation\bin\;C:\WINDOWS\system32;C:\WINDOWS;C:\WINDOWS\System32\Wbem;C:\WINDOWS\System32\WindowsPowerShell\v1.0\;C:\Program Files (x86)\Pulse Secure\VC142.CRT\X64\;C:\Program Files (x86)\Pulse Secure\VC142.CRT\X86\;C:\Program Files (x86)\Common Files\Pulse Secure\TNC Client Plugin\;C:\Program Files\dotnet\;C:\Program Files (x86)\NVIDIA Corporation\PhysX\Common;C:\Program Files\Microsoft VS Code\bin;C:\ProgramData\chocolatey\bin;C:\Program Files\PuTTY\;C:\Program Files\Git\cmd;C:\Program Files (x86)\Windows Kits\10\Windows Performance Toolkit\;C:\Users\strickers\AppData\Local\Microsoft\WindowsApps;C:\Users\strickers\.dotnet\tools;C:\Users\strickers\AppData\Local\gitkraken\bin;C:\Users\strickers\AppData\Local\Microsoft\WindowsApps;C:\Program Files\Python313;C:\Users\strickers\AppData\Roaming\Python\Python313\Scripts;C:\Users\strickers\AppData\Local\nvm;C:\nvm4w\nodejs;C:\Program Files (x86)\Common Files\Hilscher GmbH\TLRDecode;C:\Users\strickers\.dotnet\tools;C:\Users\strickers\AppData\Local\Microsoft\WindowsApps;C:\Users\strickers\.dotnet\tools;C:\Users\strickers\AppData\Local\gitkraken\bin;C:\Users\strickers\AppData\Local\Microsoft\WindowsApps;C:\Program Files\Python313;C:\Users\strickers\AppData\Roaming\Python\Python313\Scripts;C:\Users\strickers\AppData\Local\nvm;C:\nvm4w\nodejs;C:\Program Files (x86)\Common Files\Hilscher GmbH\TLRDecode;C:\Users\strickers\.dotnet\tools;C:\Program Files\BRAutomation4\AS412\bin-en\4.12;C:\Program Files\BRAutomation4\AS412\bin-en\4.11;C:\Program Files\BRAutomation4\AS412\bin-en\4.10;C:\Program Files\BRAutomation4\AS412\bin-en\4.9;C:\Program Files\BRAutomation4\AS412\bin-en\4.8;C:\Program Files\BRAutomation4\AS412\bin-en\4.7;C:\Program Files\BRAutomation4\AS412\bin-en\4.6;C:\Program Files\BRAutomation4\AS412\bin-en\4.5;C:\Program Files\BRAutomation4\AS412\bin-en\4.4;C:\Program Files\BRAutomation4\AS412\bin-en\4.3;C:\Program Files\BRAutomation4\AS412\bin-en\4.2;C:\Program Files\BRAutomation4\AS412\bin-en\4.1;C:\Program Files\BRAutomation4\AS412\bin-en\4.0;C:\Program Files\BRAutomation4\AS412\bin-en
export AS_BUILD_MODE := BuildAndCreateCompactFlash
export AS_VERSION := 4.12.8.41 SP
export AS_WORKINGVERSION := 4.12
export AS_COMPANY_NAME := B&R Industrial Automation GmbH
export AS_USER_NAME := strickers
export AS_PATH := C:/Program Files/BRAutomation4/AS412
export AS_BIN_PATH := C:/Program Files/BRAutomation4/AS412/bin-en
export AS_PROJECT_PATH := C:/Projects/Samples/AS/CodeSamples/GetStructure
export AS_PROJECT_NAME := StructureSample
export AS_SYSTEM_PATH := C:/Program\ Files/BRAutomation4/AS/System
export AS_VC_PATH := C:/Program\ Files/BRAutomation4/AS412/AS/VC
export AS_TEMP_PATH := C:/Projects/Samples/AS/CodeSamples/GetStructure/Temp
export AS_CONFIGURATION := Config1
export AS_BINARIES_PATH := C:/Projects/Samples/AS/CodeSamples/GetStructure/Binaries
export AS_GNU_INST_PATH := C:/Program\ Files/BRAutomation4/AS412/AS/GnuInst/V4.1.2
export AS_GNU_BIN_PATH := C:/Program\ Files/BRAutomation4/AS412/AS/GnuInst/V4.1.2/4.9/bin
export AS_GNU_INST_PATH_SUB_MAKE := C:/Program Files/BRAutomation4/AS412/AS/GnuInst/V4.1.2
export AS_GNU_BIN_PATH_SUB_MAKE := C:/Program Files/BRAutomation4/AS412/AS/GnuInst/V4.1.2/4.9/bin
export AS_INSTALL_PATH := C:/Program\ Files/BRAutomation4/AS412
export WIN32_AS_PATH := "C:\Program Files\BRAutomation4\AS412"
export WIN32_AS_BIN_PATH := "C:\Program Files\BRAutomation4\AS412\bin-en"
export WIN32_AS_PROJECT_PATH := "C:\Projects\Samples\AS\CodeSamples\GetStructure"
export WIN32_AS_SYSTEM_PATH := "C:\Program Files\BRAutomation4\AS\System"
export WIN32_AS_VC_PATH := "C:\Program Files\BRAutomation4\AS412\AS\VC"
export WIN32_AS_TEMP_PATH := "C:\Projects\Samples\AS\CodeSamples\GetStructure\Temp"
export WIN32_AS_BINARIES_PATH := "C:\Projects\Samples\AS\CodeSamples\GetStructure\Binaries"
export WIN32_AS_GNU_INST_PATH := "C:\Program Files\BRAutomation4\AS412\AS\GnuInst\V4.1.2"
export WIN32_AS_GNU_BIN_PATH := "C:\Program Files\BRAutomation4\AS412\AS\GnuInst\V4.1.2\bin"
export WIN32_AS_INSTALL_PATH := "C:\Program Files\BRAutomation4\AS412"

.suffixes:

ProjectMakeFile:

	@'$(AS_BIN_PATH)/4.9/BR.AS.AnalyseProject.exe' '$(AS_PROJECT_PATH)/StructureSample.apj' -t '$(AS_TEMP_PATH)' -c '$(AS_CONFIGURATION)' -o '$(AS_BINARIES_PATH)'   -sfas -buildMode 'BuildAndCreateCompactFlash'   

