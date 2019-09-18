$TestsPath = Split-Path $MyInvocation.MyCommand.Path

#$FunctionsPath = join-Path -Path (get-item $TestsPath).Parent -ChildPath "Functions"

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\PSHTML -Force

Context "Testing PSHTML"{
    Describe "Testing New-PSHTMLMenu" {


        $Hash1 = @{
            Adress      = "https://testwebsite.com/home"
            LinkStyle   ="Bold"
            LinkId      = "1"
            Text        = "Home"
            LinkClass   = "TestClass1"
        }

        $Hash2 = @{
            Adress      = "https://testwebsite.com/Contact"
            LinkStyle   ="Thic"
            LinkId      = "2"
            Text        = "Contact"
            LinkClass   = "TestClass2"
        }

        $arr = @()
        $arr += $Hash1
        $arr += $Hash2

        $String = New-PSHTMLMenu -InputValues $arr -Class "JustAClass" -Id "2" -Style "thin"

        if($string -is [array]){
            $string = $String -join ""
        }

        it "Should contain opening and closing tags" {
            $string -match '^<div.*>' | should be $true
            $string -match '.*</div>$' | should be $true

        }

        it "Testing content in child element should contain 'Contact'"{
            $string -match "^.*>Contact<.*" | should be $true
        }

        it "Testing content in child element should contain 'Home'"{
            $string -match "^.*>Home<.*" | should be $true
        }

        it "Testing content in child element should contain 'Adress' from the first Hashtable"{
            $string -match '^<.*href="https://testwebsite.com/home".*>' | should be $true
        }

        it "Testing content in child element should contain 'Adress' from the second Hashtable"{
            $string -match '^<.*href="https://testwebsite.com/Contact".*>' | should be $true
        }

        it "Testing content in child element should contain 'LinkStyle' from the first Hashtable"{
            $string -match '^<.*Style="Bold".*>' | should be $true
        }

        it "Testing content in child element should contain 'LinkStyle' from the second Hashtable"{
            $string -match '^<.*Style="Thic".*>' | should be $true
        }

        it "Testing content in child element should contain 'ID' from the first Hashtable"{
            $string -match '^<.*ID="1".*>' | should be $true
        }

        it "Testing content in child element should contain 'ID' from the second Hashtable"{
            $string -match '^<.*ID="2".*>' | should be $true
        }

        it "Testing content in child element should contain 'Class' from the first Hashtable"{
            $string -match '^<.*Class="TestClass1".*>' | should be $true
        }

        it "Testing content in child element should contain 'Class' from the second Hashtable"{
            $string -match '^<.*Class="TestClass2".*>' | should be $true
        }

        it "Testing common parameters: Class"{
            $string -match '^<.*Class="JustAClass".*>' | should be $true
        }
        it "Testing common parameters: ID"{
            $string -match '^<.*id="2".*>' | should be $true
        }
        it "Testing common parameters: Style"{
            $string -match '^<.*style="thin".*>' | should be $true
        }
    }
}

Pop-Location