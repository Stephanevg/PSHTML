$TestsPath = Split-Path $MyInvocation.MyCommand.Path

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\PSHTML -Force


Describe "Testing Install-VSCodeSnippets" {
    it "The cmdlet should not throw"{
        
    }
}



Pop-Location
