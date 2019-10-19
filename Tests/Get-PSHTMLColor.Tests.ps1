$TestsPath = Split-Path $MyInvocation.MyCommand.Path

$RootFolder = (Get-Item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

Set-Location -Path $RootFolder.FullName

#Hack to load the [System.Drawing.Color] ahead of time
#read more here -> https://github.com/PowerShell/vscode-powershell/issues/219
#Microsoft.PowerShell.Management\Get-Clipboard | Out-Null
Add-Type -Assembly System.Drawing
#Could also be loaded directly via Add-Type -Assembly System.Drawing but apperently, Get-ClipBoard thingy is better..

Write-Verbose "Importing module"

Import-Module .\PSHTML -Force
InModuleScope -ModuleName PSHTML {
    Describe "Basic Get-PSHTMLColor Tests" {
        It "Get-PSHTMLColor should return correct W3C rgb values when no -Type parameter is supplied" {
            $red = Get-PSHTMLColor -Color "red"
            $green = Get-PSHTMLColor -Color "green"
            $blue = Get-PSHTMLColor -Color "blue"
            $white = Get-PSHTMLColor -Color "white"
            $black = Get-PSHTMLColor -Color "black"
            $red | should be 'rgb(255,0,0)'
            $green | should be 'rgb(0,128,0)'
            $blue | should be 'rgb(0,0,255)'
            $white | should be 'rgb(255,255,255)'
            $black | should be 'rgb(0,0,0)'
        }
        It "Get-PSHTMLColor should return correct W3C rgb values when -Type parameter is 'rgb'" {
            $red = Get-PSHTMLColor -Type 'rgb' -Color "red"
            $green = Get-PSHTMLColor -Type 'rgb' -Color "green"
            $blue = Get-PSHTMLColor -Type 'rgb' -Color "blue"
            $white = Get-PSHTMLColor -Type 'rgb' -Color "white"
            $black = Get-PSHTMLColor  -Type 'rgb' -Color "black"
            $red | should be 'rgb(255,0,0)'
            $green | should be 'rgb(0,128,0)'
            $blue | should be 'rgb(0,0,255)'
            $white | should be 'rgb(255,255,255)'
            $black | should be 'rgb(0,0,0)'        
        }
        It "Get-PSHTMLColor should return correct W3C hex values when -Type parameter is 'hex'" {
            $red = Get-PSHTMLColor -Type 'hex' -Color "red"
            $green = Get-PSHTMLColor -Type 'hex' -Color "green"
            $blue = Get-PSHTMLColor -Type 'hex' -Color "blue"
            $white = Get-PSHTMLColor -Type 'hex' -Color "white"
            $black = Get-PSHTMLColor  -Type 'hex' -Color "black"
            $red | should be '#FF0000'
            $green | should be '#008000'
            $blue | should be '#0000FF'
            $white | should be '#FFFFFF'
            $black | should be '#000000'
        }
        It "Get-PSHTMLColor should return correct W3C hsl values when -Type parameter is 'hsl'" {
            $red = Get-PSHTMLColor -Type 'hsl' -Color "red"
            $green = Get-PSHTMLColor -Type 'hsl' -Color "green"
            $blue = Get-PSHTMLColor -Type 'hsl' -Color "blue"
            $white = Get-PSHTMLColor -Type 'hsl' -Color "white"
            $black = Get-PSHTMLColor  -Type 'hsl' -Color "black"
            $red | should be 'hsl(0,100%,50%)'
            $green | should be 'hsl(120,100%,25%)'
            $blue | should be 'hsl(240,100%,50%)'
            $white | should be 'hsl(0,0%,100%)'
            $black | should be 'hsl(0,0%,0%)'
        }
    }
}