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
            2018.10.21;Stephanevg;Fix wrong path due to module restrucutre.
            2018.10.17;stephanev;updated to v 1.0 - added error handling, and -force parameter
            2018.10.16;FishFenly;Creation.
    #>
    [CmdletBinding()]
    Param(
        [String]$Path = "$($env:APPDATA)\Code\User\Snippets",
        [Switch]$Force
    )
    

    $ModuleRoot = Get-ModuleRoot

    Write-host "Module Root is: $($ModuleRoot)"

   
    $snippetsfolder = join-path $ModuleRoot -ChildPath "Snippets"

    $AllSnipets = Get-childItem -path $snippetsfolder

    $Paras = @{}
    $Paras.Destination = $Path
    $Paras.errorAction =  "Stop"
    $Paras.Force = $true

    if($Force){
        $Paras.Force = $true
    }

    if($AllSnipets){
        foreach ($snippet in $AllSnipets) {
            $Paras.Path = $null
            $Paras.Path = $snippet.FullName 
            Write-Verbose "Copying $($snippet.FullName) to $($Paras.Destination)"
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
