function Install-PSHTMLVSCodeSnippets {
<#
.SYNOPSIS
    Copy the PSHTML VSCode Snippets to the right location
.DESCRIPTION
    Gets the PSHTML VSCode snippet files and copies them to users appdata folder
.NOTES
        Current version 0.1
        History:
        2018.10.16;FishFenly;Creation.
#>

    $callstack = Get-PSCallStack | Select-Object -ExpandProperty scriptname
    
    $path = Split-path -path (
        Split-path -Path (
            Split-Path -path $callstack -Parent) -Parent) -Parent

    $snippetsfolder = join-path $path -ChildPath "Snippets"


    foreach ($snippet in (Get-Item $snippetsfolder\*.code-snippets | Select-Object -ExpandProperty FullName)) {
            Write-Verbose "Copying $snippet to $($env:APPDATA)\Code\User\snippets"
            Copy-Item -Path $snippet `
                    -Destination "$($env:APPDATA)\Code\User\snippets" -Force
    }
}