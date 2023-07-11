$scriptStart = Get-Date

Write-Host "Script run on: $scriptStart"

$processList = Get-Process | Where-Object {$_.StartTime -ne $null } | Select-Object Id, ProcessName, StartTime

$lastObject = $null

#distinct elements with the earlier startDate

#open processStartList

$List = New-Object -Type 'System.Collections.ArrayList'


ForEach($el in $processList) {
    
    if($lastObject.ProcessName -ne $null -and $el.ProcessName -eq $lastObject.ProcessName) {
        #getTime
        if($el.StartTime -lt $lastObject.StartTime) {
            $lastObject = $el
        }
    }
    else 
    {
        $List.Add($lastObject)
        $lastObject = $el
    }

}

$fileCount = (Get-ChildItem $env:USERPROFILE\Documents\ProcessScriptData\dailydata* | Measure-Object).Count + 1

$fileName = "dailydata_"+ $fileCount + "_" + (Get-Date -Format "dd_MM_yyyy")

New-Item -Path $env:USERPROFILE\Documents\ProcessScriptData -ItemType "file" -Name $fileName

#Iterate through list and add data to file

Foreach($v in $List) {
    $fileFormat = "{0} {1} {2}" -f $v.Id, $v.ProcessName, $v.StartTime
    Add-Content -Path $env:USERPROFILE\Documents\ProcessScriptData\$fileName -Value $fileFormat
}
