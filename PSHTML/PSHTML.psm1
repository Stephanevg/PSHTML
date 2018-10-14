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

write-verbose -Message "Loading Private Functions"
$PublicFunctions = Get-ChildItem -Path "$ScriptPath\Functions\public" -Filter *.ps1 | Select-Object -ExpandProperty FullName

foreach ($public in $PublicFunctions){
    write-verbose "importing function $($function)"
    try{
        . $public
    }catch{
        write-warning -Message $_
    }
}

New-Alias -Name Include -Value 'Get-HTMLTemplate' -Description "Include parts of PSHTML documents using Templates"