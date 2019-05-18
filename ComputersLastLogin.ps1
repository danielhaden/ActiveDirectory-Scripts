$OUpath = Get-Content "C:\Users\hadend\Desktop\scripts\info.txt" | 
            Select-Object -First 1
            
$curDir = Get-Location
Set-Location AD:\


$DaysInactive = Read-Host -Prompt "List computers inactive for more than how many days"

$time = (Get-Date).AddDays(-($DaysInactive))

Get-ADComputer -Filter {(LastLogonDate -lt $time)} -SearchBase $OUpath -Properties * |
    Format-Table SamAccountName, LastLogonDate

Set-Location $curDir