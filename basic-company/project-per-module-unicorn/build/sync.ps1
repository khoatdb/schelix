$ErrorActionPreference = 'Stop'

. $PSScriptRoot\settings.ps1
if (Test-Path $PSScriptRoot\settings.user.ps1) {
    . $PSScriptRoot\settings.user.ps1
}

Write-Host "*******************************************************" -ForegroundColor Green
Write-Host " Build and Unicorn Sync $SitecoreSiteName" -ForegroundColor Green
Write-Host "*******************************************************" -ForegroundColor Green

Push-Location $ConfigPath
$buildAndSyncParams = @{
    Path = $BuildAndSyncConfiguration
    BuildProject = $BuildProject
    SitecoreUrl = $SitecoreSiteUrl
    UnicornSecretConfig = $UnicornSecretConfig
}
try {
    Install-SitecoreConfiguration @buildAndSyncParams *>&1 | Tee-Object "$PSScriptRoot\log.sync.txt"
}
catch
{
    write-host "Build and sync failed" -ForegroundColor Red
    throw
}
finally {
    Pop-Location
}