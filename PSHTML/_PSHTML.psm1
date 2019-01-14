<#
.SYNOPSIS
    PowerShell Module file for PSHTML
.DESCRIPTION
    This PowerShell module file will load all the functions present under Private and Public folder.
.LINK
    https://github.com/Stephanevg/PSHTML
#>

# Retrieve parent folder
$ScriptPath = Split-Path -Path $MyInvocation.MyCommand.Path



write-verbose -Message "Loading private Classes"
$PublicClasses = Get-ChildItem -Path "$ScriptPath\Classes\Private" -Filter *.ps1 | Select-Object -ExpandProperty FullName

foreach ($pc in $PublicClasses){
    write-verbose "importing $($pc)"
    try{
        . $pc
    }catch{
        write-warning -Message $_
    }
}

write-verbose -Message "Loading Public Classes"
$PublicClasses = Get-ChildItem -Path "$ScriptPath\Classes\Public" -Filter *.ps1 | Select-Object -ExpandProperty FullName

foreach ($pc in $PublicClasses){
    write-verbose "importing $($pc)"
    try{
        . $pc
    }catch{
        write-warning -Message $_
    }
}




write-verbose -Message "Loading Private Functions"
$PrivateFunctions = Get-ChildItem -Path "$ScriptPath\Functions\Private" -Filter *.ps1 | Select-Object -ExpandProperty FullName

foreach ($Private in $PrivateFunctions){
    write-verbose -Message "importing function $($function)"
    try{
        . $Private
    }catch{
        write-warning -Message $_
    }
}

write-verbose -Message "Loading Public Functions"
$PublicFunctions = Get-ChildItem -Path "$ScriptPath\Functions\Public" -Filter *.ps1 | Select-Object -ExpandProperty FullName

foreach ($public in $PublicFunctions){
    write-verbose "importing function $($function)"
    try{
        . $public
    }catch{
        write-warning -Message $_
    }
}


Write-Verbose "Loading aliases:"
New-Alias -Name Include -Value 'Get-PSHTMLTemplate' -Description "Include parts of PSHTML documents using Templates" -Force



$ConfigFile = Join-Path -Path $ScriptPath -ChildPath "pshtml.configuration.json"
Write-Verbose "Loading data ConfigFile: $($ConfigFile)"



$Script:PSHTML_CONFIGURATION = New-ConfigurationDocument -Path $ConfigFile -Force