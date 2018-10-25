$TestsPath = Split-Path $MyInvocation.MyCommand.Path

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\PSHTML -Force



Describe "Testing Install-VSCodeSnippets" {

    $SnippetTypes = @("small","medium","full")

    it "The cmdlet should not throw"{
        {install-PSHTMLVsCodeSnippets -force} | should not throw
    }

    if($IsLinux){
        $SnippetsPath = "$home/.vscode/User/Snippets"
    }else{
        
        $SnippetsPath = join-Path -Path $Env:AppData -ChildPath "/Code/User/Snippets/"
    }

    
    if(!(Test-Path $SnippetsPath)){
        $null = mkdir $SnippetsPath
    }

    $Items = gci $SnippetsPath
    it "Should create the snippets at correct path: $($SnippetsPath)"{
        $ITems | should not benullOrEmpty
        
    }

    It "Should contain at least 3 snippets"{

        ($Items | measure).Count | should BeGreaterOrEqual 3
    }

    foreach($SnippetType in $SnippetTypes){

        It "Should contain snippet -> $($SnippetType)" {
            $items | ? {$_.Name -like "*$SnippetType*"} | should not benullOrEmpty
        }
    }
}



Pop-Location
