#Post Content

$ScriptPath = Split-Path -Path $MyInvocation.MyCommand.Path
$ScriptPath = Split-Path -Path $PSScriptRoot
New-Alias -Name Include -Value 'Write-PSHTMLInclude' -Description "Include parts of PSHTML documents using include files" -Force
function Get-ScriptDirectory {
    Split-Path -Parent $PSCommandPath
}
$ScriptPath = Get-ScriptDirectory
$CF = Join-Path -Path $ScriptPath -ChildPath "pshtml.configuration.json"
#Write-host "loading config file: $($CF)" -ForegroundColor Blue
#Setting module variables
    $Script:PSHTML_CONFIGURATION = Get-ConfigurationDocument -Path $CF -Force
    $Script:Logfile = $Script:PSHTML_CONFIGURATION.GetDefaultLogFilePath()
    $Script:Logger = [Logger]::New($Script:LogFile)
