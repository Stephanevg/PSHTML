$TestsPath = Split-Path $MyInvocation.MyCommand.Path

#$FunctionsPath = join-Path -Path (get-item $TestsPath).Parent -ChildPath "Functions"

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\PSHTML -Force

InModuleScope PSHTML {


    Describe "Testing New-PSHTMLCDNAssetFile" {

        It '[No Parameters] Should throw' {
            {New-PSHTMLCDNAssetFile | Should Throw}
        }

        $CDNFilePath = join-Path $TestDrive -ChildPath "woop.cdn"
        It 'Should create an Asset File' {
            New-PSHTMLCDNAssetFile -Type script -Source "MySource" -Integrity "12345" -CrossOrigin "Anonymous" -FilePath $CDNFilePath
        }

    }

}