$TestsPath = Split-Path $MyInvocation.MyCommand.Path

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\PSHTML -Force


Describe "Testing Install-VSCodeSnippets" {

    $SnippetTypes = @("small","medium","full")
    $TestSnippetsPath = Join-Path -Path $TestDrive -ChildPath "Snippets"

    if(!(Test-Path $TestSnippetsPath)){
        $null = mkdir $TestSnippetsPath
    }

    it "The cmdlet should not throw"{
        {install-PSHTMLVsCodeSnippets -Path $TestSnippetsPath} | should not throw
    }

    <# if($IsLinux){
        $Path = Join-Path -Path $env:HOME -ChildPath ".config/Code/User/snippets/"
    }else{
        $Path = "$($env:APPDATA)\Code\User\snippets"
    } #>
    
    $Items = gci $TestSnippetsPath
    it "Should create the snippets at correct path: $($TestSnippetsPath)"{
        $Items | should not benullOrEmpty
        
    }

    It "Should contain at least 3 snippets"{

        ($Items | measure).Count | Should -BeGreaterOrEqual 3
    }

    foreach($SnippetType in $SnippetTypes){

        It "Should contain snippet -> $($SnippetType)" {
            $Items | ? {$_.Name -like "*$SnippetType*"} | should not benullOrEmpty
        }
    }
}



Pop-Location
