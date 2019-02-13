$TestsPath = Split-Path $MyInvocation.MyCommand.Path

#$FunctionsPath = join-Path -Path (get-item $TestsPath).Parent -ChildPath "Functions"

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\PSHTML -Force

function Get-FileEncoding
{
    [CmdletBinding()] Param (
     [Parameter(Mandatory = $True, ValueFromPipelineByPropertyName = $True)] [string]$Path
    )
 

    [byte[]]$byte = get-content -Encoding byte -ReadCount 4 -TotalCount 4 -Path $Path
 

    if ( $byte[0] -eq 0xef -and $byte[1] -eq 0xbb -and $byte[2] -eq 0xbf )
    { Write-Output 'UTF8' }
    elseif ($byte[0] -eq 0xfe -and $byte[1] -eq 0xff)
    { Write-Output 'Unicode' }
    elseif ($byte[0] -eq 0 -and $byte[1] -eq 0 -and $byte[2] -eq 0xfe -and $byte[3] -eq 0xff)
    { Write-Output 'UTF32' }
    elseif ($byte[0] -eq 0x2b -and $byte[1] -eq 0x2f -and $byte[2] -eq 0x76)
    { Write-Output 'UTF7'}
    else
    { Write-Output 'ASCII' }
}

InModuleScope pshtml {
    Describe "Testing Out-PSHTMLDocument"{
        Context "Basics"{
            it "Should throw when called without any parameters"{
                {OUT-PSHTMLDocument} | should throw
            }

        }
        $File = Join-Path -Path $Testdrive -childPAth "Export.html"
        $o = Get-PRocess | select ProcessName,Handles | select -first 5
        
        $E = ConvertTo-PSHTMLTable -Object $o 
        Out-PSHTMLDocument -HTMLDocument $E -OutPath $File

        Context "Testing File export" {
            It "Should export file" {
                Test-Path -Path $File | should be true
            }

            It "Should contain correct HTML "{
                $content = gc $File -Raw
                $Content | should match '^<Table >.*</Table>'
            }

            <#
            
            It "File Should be encoded in UTF8"{
                Get-FileEncoding
            }
            #>
        }
    }
}


    

Pop-Location