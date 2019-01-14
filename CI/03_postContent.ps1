#Post Content

$ScriptPath = Split-Path -Path $MyInvocation.MyCommand.Path

Write-Verbose "Loading aliases:"
New-Alias -Name Include -Value 'Get-PSHTMLTemplate' -Description "Include parts of PSHTML documents using Templates" -Force


$ConfigFile = Join-Path -Path $ScriptPath -ChildPath "pshtml.configuration.json"
Write-Verbose "Loading data ConfigFile: $($ConfigFile)."

$Script:PSHTML_CONFIGURATION = New-ConfigurationDocument -Path $ConfigFile -Force