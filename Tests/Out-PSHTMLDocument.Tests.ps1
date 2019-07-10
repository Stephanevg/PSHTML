$TestsPath = Split-Path $MyInvocation.MyCommand.Path

#$FunctionsPath = join-Path -Path (get-item $TestsPath).Parent -ChildPath "Functions"

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\PSHTML -Force

function Get-NeinFileEncoding
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

Function Get-FileEncoding {
    ##############################################################################
##
## Get-FileEncoding
##
## From Windows PowerShell Cookbook (O'Reilly)
## by Lee Holmes (http://www.leeholmes.com/guide)
##
##############################################################################
#This version doesn't return the right format on MacOS (Return UTF7 although it is showed as 8 in vsCode.)
<#

.SYNOPSIS

Gets the encoding of a file

.EXAMPLE

Get-FileEncoding.ps1 .\UnicodeScript.ps1

BodyName          : unicodeFFFE
EncodingName      : Unicode (Big-Endian)
HeaderName        : unicodeFFFE
WebName           : unicodeFFFE
WindowsCodePage   : 1200
IsBrowserDisplay  : False
IsBrowserSave     : False
IsMailNewsDisplay : False
IsMailNewsSave    : False
IsSingleByte      : False
EncoderFallback   : System.Text.EncoderReplacementFallback
DecoderFallback   : System.Text.DecoderReplacementFallback
IsReadOnly        : True
CodePage          : 1201

#>

param(
    ## The path of the file to get the encoding of.
    $Path
)

Set-StrictMode -Version 3

## First, check if the file is binary. That is, if the first
## 5 lines contain any non-printable characters.
$nonPrintable = [char[]] (0..8 + 10..31 + 127 + 129 + 141 + 143 + 144 + 157)
$lines = Get-Content $Path -ErrorAction Ignore -TotalCount 5
$result = @($lines | Where-Object { $_.IndexOfAny($nonPrintable) -ge 0 })
if($result.Count -gt 0)
{
    "Binary"
    return
}

## Next, check if it matches a well-known encoding.

## The hashtable used to store our mapping of encoding bytes to their
## name. For example, "255-254 = Unicode"
$encodings = @{}

## Find all of the encodings understood by the .NET Framework. For each,
## determine the bytes at the start of the file (the preamble) that the .NET
## Framework uses to identify that encoding.
foreach($encoding in [System.Text.Encoding]::GetEncodings())
{
    $preamble = $encoding.GetEncoding().GetPreamble()
    if($preamble)
    {
        $encodingBytes = $preamble -join '-'
        $encodings[$encodingBytes] = $encoding.GetEncoding()
    }
}

## Find out the lengths of all of the preambles.
$encodingLengths = $encodings.Keys | Where-Object { $_ } |
    Foreach-Object { ($_ -split "-").Count }

## Assume the encoding is UTF7 by default
$result = [System.Text.Encoding]::UTF7

## Go through each of the possible preamble lengths, read that many
## bytes from the file, and then see if it matches one of the encodings
## we know about.
foreach($encodingLength in $encodingLengths | Sort -Descending)
{
    $bytes = Get-Content -encoding byte -readcount $encodingLength $path | Select -First 1
    $encoding = $encodings[$bytes -join '-']

    ## If we found an encoding that had the same preamble bytes,
    ## save that output and break.
    if($encoding)
    {
        $result = $encoding
        break
    }
}

## Finally, output the encoding.
$result

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
                Get-FileEncoding -Path $File
            }
            #>
        }
    }
}


    

Pop-Location