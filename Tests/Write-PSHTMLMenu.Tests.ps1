$TestsPath = Split-Path $MyInvocation.MyCommand.Path

#$FunctionsPath = join-Path -Path (get-item $TestsPath).Parent -ChildPath "Functions"

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\PSHTML -Force

Context "Testing PSHTML"{
    Describe "Testing Write-PSHTMLMenu" {


        $Hash1 = @{
            Content        = "Home"
            href      = "https://plop.com/Home"
            Style   ="Height: 5px;"
            Id      = "nav_home_top"
            Class   = "TestClass1"
            Target      = "_self"
        }

        $Hash2 = @{
            Content        = "Contact"
            href      = "https://testwebsite.com/Contact"
            Style   ="Height: 6px;"
            Id      = "nav_home_contact"
            Class   = "TestClass2"
            Target      = "_Parent"
            Attributes = @{
                'Plop' = 'rop'
                'wep'  = 'sep'
            }
        }

        $arr = @()
        $arr += $Hash1
        $arr += $Hash2

        $String = Write-PSHTMLMenu -InputValues $arr -NavId "Menu_top" -NavClass "JustAClass"  -NavStyle "display:block;"

        if($string -is [array]){
            $string = $String -join ""
        }

        it "Should contain opening and closing nav tags" {
            $string -match '.*<nav.*>.*' | should be $true
            $string -match '.*</nav>$' | should be $true

        }

        it "Should contain opening and closing ul tags" {
            $string -match '.*<ul.*>.*' | should be $true
            $string -match '.*</ul>.*' | should be $true

        }

        it "Should contain opening and closing li tags" {
            $string -match '.*<li.*>.*' | should be $true
            $string -match '.*</li>.*$' | should be $true

        }

        it "Testing content in child element should contain 'Contact'"{
            $string -match ".*>Contact<.*" | should be $true
        }

        it "Testing content in child element should contain 'Home'"{
            $string -match ".*>Home<.*" | should be $true
        }

        it "Testing content in child element should contain 'href' from the first Hashtable"{
            $e = $Hash1.href.Replace('/','\/')
            $escapedUrl = $e.Replace(".","\.")
            $hr = ".*(href=`"$($escapedUrl)`").*"
            $string -match $hr | should be $true
        }

        it "Testing content in child element should contain 'href' from the second Hashtable"{
            $e = $Hash2.href.Replace('/','\/')
            $escapedUrl = $e.Replace(".","\.")
            $hr = ".*(href=`"$($escapedUrl)`").*"
            $string -match $hr | should be $true
        }

        it "Testing content in child element should contain 'Style' from the first Hashtable"{
            $string -match '^<.*Style="Height: 5px;".*>' | should be $true
        }

        it "Testing content in child element should contain 'Style' from the second Hashtable"{
            $string -match '^<.*Style="Height: 6px;".*>' | should be $true
        }

        it "Testing content in child element should contain 'ID' from the first Hashtable"{
            $string -match '^<.*ID="nav_home_top".*>' | should be $true
        }

        it "Testing content in child element should contain 'ID' from the second Hashtable"{
            $string -match '^<.*ID="nav_home_contact".*>' | should be $true
        }

        it "Testing content in child element should contain 'Class' from the first Hashtable"{
            $string -match '^<.*Class="TestClass1".*>' | should be $true
        }

        it "Testing content in child element should contain 'Class' from the second Hashtable"{
            $string -match '^<.*Class="TestClass2".*>' | should be $true
        }

        it "Testing common parameters: NavClass"{
            $string -match '^<.*Class="JustAClass".*>' | should be $true
        }
        it "Testing common parameters: NavID"{
            $string -match '^<.*id="Menu_top".*>' | should be $true
        }
        it "Testing common parameters: NavStyle"{
            $string -match '^<.*style="display:block;".*>' | should be $true
        }
    }
}

Pop-Location