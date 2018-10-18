function Install-PSHTMLVSCodeSnippets {
    <#
    .SYNOPSIS
        Copy the PSHTML VSCode Snippets to the right location
    .DESCRIPTION
        Gets the PSHTML VSCode snippet files and copies them to users appdata folder

    .EXAMPLE

    .EXAMPLE



    .NOTES
            Current version 1.0
            History:
            2018.10.17;stephanev;updated to v 1.0 - added error handling, and -force parameter
            2018.10.16;FishFenly;Creation.
    #>
    [CmdletBinding()]
    Param(
        [String]$DestinationPath = "$($env:APPDATA)\Code\User\snippets",
        [Switch]$Force
    )
    

    $callstack = Get-PSCallStack | Select-Object -ExpandProperty scriptname
    
    $Rootpath = Split-path -path (Split-path -Path (Split-Path -path $callstack -Parent) -Parent) -Parent

    $snippetsfolder = join-path $Rootpath -ChildPath "Snippets"

    $AllSnipets = Get-childItem -path $snippetsfolder

    $Paras = @{}
    $Paras.Destination = $DestinationPath
    $Paras.errorAction =  "Stop"

    if($Force){
        $Paras.Force = $true
    }

    if($AllSnipets){
        foreach ($snippet in $AllSnipets) {
            $Paras.Path = $null
            $Paras.Path = $snippet.FullName 
            Write-Verbose "Copying $($snippet.FullName) to $($env:APPDATA)\Code\User\snippets"
            try {
                Copy-Item @Paras
            }Catch{
                
                    Write-warning "$_"
            }
        }
    }else{
        write-warning "No snippts found in $SnippetsFolder"
    }
}
