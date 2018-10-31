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

    if($IsLinux){
        $Path = Join-Path -Path $env:HOME -ChildPath ".config/Code/User/snippets/"
    }else{
        $Path = "$($env:APPDATA)\Code\User\snippets"
    }
    
    $Items = gci $Path
    it "Should create the snippets at correct path: $($Path)"{
        $Items | should not benullOrEmpty
        
    }

    It "Should contain 5 snippets"{

        ($Items | measure).Count | should be 5
    }

    foreach($SnippetType in $SnippetTypes){

        It "Should contain snippet -> $($SnippetType)" {
            $Items | ? {$_.Name -like "*$SnippetType*"} | should not benullOrEmpty
        }
    }
}



Pop-Location
