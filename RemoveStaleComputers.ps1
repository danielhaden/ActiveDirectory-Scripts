#Finds computers that have been inactive for X days
$OUpath = Get-Content "C:\Users\hadend\Desktop\scripts\info.txt" | 
            Select-Object -First 1
            
$curDir = Get-Location
Set-Location AD:\


$DaysInactive = Read-Host -Prompt "List computers inactive for more than how many days"

$time = (Get-Date).AddDays(-($DaysInactive))

$staleComputers = Get-ADComputer -Filter {(LastLogonDate -lt $time)} -SearchBase $OUpath -Properties Name,LastLogonDate

ForEach ($computer In $staleComputers) {
    Write-Host "Computer", $computer.name, "last login at", $computer.LastLogonDate
    $response = Read-Host -Prompt "Do you want to remove this computer object(Y for yes)"

    if ($response -eq "Y") {
        Remove-ADComputer -Identity $computer -Verbose


    } Else {
        Write-Host $computer.name, "not deleted"
    }

}

Set-Location $curDir