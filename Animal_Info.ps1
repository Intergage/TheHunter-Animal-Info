function Make-InfoCard ($info) {

    $Habs = $info.Info.Habitats
    $Attr = $info.Info.Attractants
    $Star = $info.Info.StartLoc
    $Scor = $info.Info.Score
    $Ammo = $info.Info.Ammo
    $Maps = $info.Info.Maps

    # I have no idea what this is... Only way I could get those god damn embedded for loops to work.
    write-host "#### $($info.Animal) ####`r`n" -ForegroundColor Red
    Write-Host "Can be found at:        `t`t" -NoNewline
    Write-Host " $($Habs)" -ForegroundColor Green
    Write-Host "Can be attracted with:  `t`t" -NoNewline
    Write-Host " $($Attr)" -ForegroundColor Green
    Write-Host "Leaderboard Score:      `t`t" -NoNewline
    Write-Host " $Scor`r`n" -ForegroundColor Green
    Write-Host "Starting Locations:     `t`t " -NoNewline
    Write-Host "$(foreach($item in $Star){"$item`r`n`t`t`t`t`t"})`r`n" -ForegroundColor Green
    Write-Host "Permited Ammo:          `t`t " -NoNewline
    Write-Host "$(foreach($item in $Ammo){"$item`r`n`t`t`t`t`t"})" -ForegroundColor Green
    
}

# Get data from json file
$data = Get-Content .\data.json | ConvertFrom-Json

# Opening Text
Write-Host @"
                #### The Hunter Classic Animal Info ####
            Type in species name from the list below to get info card
            
"@

# Show all animals
$data.Animal -join ', ' | Sort-Object

$cont = 1
while ($cont -eq 1) {
    # Get species user wants to look up
    $species = Read-Host -Prompt "Species: "

    # Need to add some checks for user input
    # No Numbers, doesn't matter about case, is it an animal?, Can we suggest what they attempted to type?
    # If $species returns more then one json object it should be refined more
    if(!$species){
        Write-Host "Please type in an animal name"
    }
    elseif ($species -eq 'q') {
        Write-Host "Laters"
        $cont = 0
    }
    # Get species info from json data and sends to infocard function
    else{$info = $data | ? {$_.Animal -match $species} | Select-Object Animal, Info; Make-InfoCard -info $info }
    
}