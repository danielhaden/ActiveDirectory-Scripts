#Gets inactivity stats on OU
$OUpath = Get-Content "C:\Users\hadend\Desktop\scripts\info.txt" | 
            Select-Object -First 1
            
$curDir = Get-Location
Set-Location AD:\


ForEach ($i in 1,2,3,4,5) {
    $DaysInactive = $i*365
    $time = (Get-Date).AddDays(-($DaysInactive))

    $computers = Get-ADComputer -Filter {(LastLogonDate -lt $time)} -SearchBase $OUpath -Properties Name,LastLogonDate
    
    Write-Host $computers.count, "computers inactive for more than", $i, "year(s)"

}
Write-Host ""

ForEach ($i in 1,2,3,4,5) {
    $DaysInactive = $i*365
    $time = (Get-Date).AddDays(-($DaysInactive))

    $users = Get-ADUSer -Filter {(LastLogonDate -lt $time)} -SearchBase $OUpath -Properties Name,LastLogonDate
    
    Write-Host $users.count, "users inactive for more than", $i, "year(s)"

}

Set-Location $curDir