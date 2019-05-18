#Finds accounts inactive longer than X days

$OUpath = Get-Content "C:\Users\hadend\Desktop\scripts\info.txt" | 
            Select-Object -First 1


$curDir = Get-Location
Set-Location AD:\


$DaysInactive = Read-Host -Prompt "List users inactive for more than how many days"

$time = (Get-Date).AddDays(-($DaysInactive))

Get-ADUser -Filter {(LastLogonDate -lt $time) -and (Enabled -eq $TRUE)} -SearchBase $OUpath -Properties * |
    Format-Table SamAccountName, UserPrincipalName, LastLogonDate

Set-Location $curDir