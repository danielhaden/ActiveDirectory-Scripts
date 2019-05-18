$curDir = Get-Location
Set-Location AD:\

If ($args.Count -eq 1) {
    $lastName = $args[0]
    Get-ADUser -filter {(SurName -eq $lastName)}

} Elseif ($args.Count -eq 2) {
    $firstName = $args[0]
    $lastName = $args[1]
    Get-ADUser -filter {(GivenName -eq $firstName) -and 
                        (SurName -eq $lastName)}

}

Set-Location $curDir