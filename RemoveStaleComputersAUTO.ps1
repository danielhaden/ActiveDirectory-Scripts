#Finds and deletes computers that have been inactive for X days Automatically

$OUpath = Get-Content "C:\Users\hadend\Desktop\scripts\info.txt" | 
            Select-Object -First 1
            
$curDir = Get-Location
Set-Location AD:\


$DaysInactive = 1095 #3 years

$time = (Get-Date).AddDays(-($DaysInactive))

$staleComputers = Get-ADComputer -Filter {(LastLogonDate -lt $time)} -SearchBase $OUpath -Properties Name,LastLogonDate

$response = Read-Host "Are you sure you want to delete (Y for Yes)", $staleComputers.count, "computer objects from OU"

If ($response -ne "Y") {
    Write-Host "terminated without deleting"
    Exit(0)
}

$credential = Get-Credential

ForEach ($computer In $staleComputers) {
    Remove-ADComputer -Identity $computer -Credential $credential -confirm:$false
}

Set-Location $curDir