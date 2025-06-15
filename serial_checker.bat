@echo off
MODE 93, 62
title 64th Service
echo.
color 90
echo.
color 90
:start
color 4
cls
echo [90m==========================[97m
echo [93m      MOTHERBOARD
echo [90m==========================[97m
wmic baseboard get serialnumber | sort
echo [90m==========================[97m
echo [92m        SMBIOS
echo [90m==========================[97m
wmic path win32_computersystemproduct get uuid | sort
echo [90m==========================[97m
echo [95m         BIOS
echo [90m==========================[97m
wmic csproduct get uuid | sort
echo [90m==========================[97m
echo [91m         CPU
echo [90m==========================[97m
wmic cpu get serialnumber | sort
echo [90m==========================[97m
echo [95m       CHASSIS
echo [90m==========================[97m
wmic systemenclosure get serialnumber | sort
echo [90m==========================[97m
echo [92m        TPM
echo [90m==========================[97m
powershell -Command "Try { $tpm = Get-WmiObject -Namespace 'Root\CIMv2\Security\MicrosoftTpm' -Class Win32_Tpm; if ($tpm) { Write-Host 'IsPresent: ' $tpm.IsEnabled; Write-Host 'ManufacturerID: ' $tpm.ManufacturerID; Write-Host 'ManufacturerVersion: ' $tpm.ManufacturerVersion; Write-Host 'SerialNumber (if available):' $tpm.SerialNumber } else { Write-Host 'TPM not found' } } Catch { Write-Host 'Error retrieving TPM info' }"
echo [90m==========================[97m
echo [93m       HARD DISK
echo [90m==========================[97m
wmic diskdrive get serialnumber | sort
echo [90m==========================[97m
echo [92m       GPU
echo [90m==========================[97m
wmic PATH Win32_VideoController GET Description, PNPDeviceID | sort
echo [90m==========================[97m
echo [91m       NETWORK ADAPTER
echo [90m==========================[97m
wmic path Win32_NetworkAdapter where "PNPDeviceID like '%%PCI%%' AND NetConnectionStatus=2 AND AdapterTypeID='0'" get MacAddress | sort
echo [90m==========================[97m
echo [95m         RAM
echo [90m==========================[97m
wmic memorychip get serialnumber | sort
echo [90m==========================[97m
pause>nul
goto start
