$TestsPath = Split-Path $MyInvocation.MyCommand.Path

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\PSHTML -Force



Describe "Testing Install-VSCodeSnippets" {

    $SnippetTypes = @("small","medium","full")

    it "The cmdlet should not throw"{
        {install-PSHTMLVsCodeSnippets} | should not throw
    }

    $SnippetsPath = "$($env:APPDATA)\Code\User\Snippets\"
    $Items = gci $SnippetsPath
    it "Should create the snippets at correct path: $($SnippetsPath)"{
        $ITems | should not benullOrEmpty
        
    }

    It "Should contain 3 snippets"{

        ($Items | measure).Count | should be 3
    }

    foreach($SnippetType in $SnippetTypes){

        It "Should contain snippet -> $($SnippetType)" {
            $items | ? {$_.Name -like "*$SnippetType*"} | should not benullOrEmpty
        }
    }
}



Pop-Location
