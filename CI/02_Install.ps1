
write-host "Install core modules" -ForegroundColor Red -BackgroundColor White
Install-Module -Name PSScriptAnalyzer -Force  -Scope CurrentUser
Install-Module -Name Pester -Force  -Scope CurrentUser