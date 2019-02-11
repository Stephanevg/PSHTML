$TestsPath = Split-Path $MyInvocation.MyCommand.Path

#$FunctionsPath = join-Path -Path (get-item $TestsPath).Parent -ChildPath "Functions"

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\PSHTML -Force

InModuleScope "PSHTML"{
    Describe "Write-PSHTMLInclude (default - no include files)" {
        it 'Write-PSHTMLInclude should not throw when no include file present'{
            {Write-PSHTMLInclude} | should not throw
        }

        it 'write-pshtmlInclude should have alias: include'{
            (Get-Alias Include).Definition | should be "Write-PSHTMLInclude"
        }

    }

    Describe "Write-PSHTMLInclude with existing include files." {
        $includesFolderPath = Join-Path .\PSHTML\ -ChildPath "Includes"

        $head = @"
        head -content {
            Write-PSHTMLAsset -Name Jquery -Type Script
            write-pshtmlAsset -Name BootStrap
    }
"@

        $FilePath = "$includesFolderPath\head.ps1"
        Set-Content -Path $FilePath -Value $head -Force
        (Get-PSHTMLConfiguration).Load()
        it 'Write-PSHTMLInclude -Name Head should not be null or empty'{
            Write-PSHTMLInclude -Name head | should not beNullOrEmpty
        }

        it 'Write-PSHTMLInclude -Name Head should write correct html statements'{
            $Head = Write-PSHTMLInclude -Name Head
            $head -match '^<head ><Scipt.*</head>'
        }



        #Cleaning up
        remove-item $FilePath -Force
    }
}