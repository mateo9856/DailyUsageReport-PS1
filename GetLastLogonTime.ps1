#Run this script to log on windows x64

$userName = $env:USERNAME

$lastLogon = Get-LocalUser | Where-Object {$_.Name -eq $userName} | Select-Object LastLogon

$fileCount = (Get-ChildItem $env:USERPROFILE\Documents\ProcessScriptData\logonTime* | Measure-Object).Count + 1
$fileName = "logonTime_"+ $fileCount + "_" + (Get-Date -Format "dd_MM_yyyy")

New-Item -Path $env:USERPROFILE\Documents\ProcessScriptData -ItemType "file" -Name $fileName

$fileFormat = "{0}" -f $lastLogon.LastLogon
Add-Content -Path $env:USERPROFILE\Documents\ProcessScriptData\$fileName -Value $fileFormat