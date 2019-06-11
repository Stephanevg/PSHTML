$TestsPath = Split-Path $MyInvocation.MyCommand.Path

#$FunctionsPath = join-Path -Path (get-item $TestsPath).Parent -ChildPath "Functions"

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\PSHTML -Force

InModuleScope "PSHTML"{
    Describe "Get-PSHTMLInclude (default - no include files)" {
        it 'Get-PSHTMLInclude should not throw when no include file present'{
            {Get-PSHTMLInclude} | should not throw
        }

        

    }

    Describe "Get-PSHTMLInclude with existing include files." {
        $includesFolderPath = Join-Path .\PSHTML\ -ChildPath "Includes"

        $head = @"
        head -content {
            meta -charset 'UTF-8'
            meta -name 'author' -content "Stéphane van Gulick"
            Write-PSHTMLAsset -Name Jquery -Type Script
            write-pshtmlAsset -Name BootStrap
    }
"@

        $FilePath = "$includesFolderPath\head.ps1"
        Set-Content -Path $FilePath -Value $head -Force
        (Get-PSHTMLConfiguration).Load()
        it 'Get-PSHTMLInclude should not be null or empty '{
            Get-PSHTMLInclude | should not beNullOrEmpty
        }

        it 'Should have correct include files'{
            $file = Get-PSHTMLInclude -Name Head
            $File.Name | should be 'head'
        }

        #Cleaning up
        remove-item $FilePath -Force
    }
}