$TestsPath = Split-Path $MyInvocation.MyCommand.Path

#$FunctionsPath = join-Path -Path (get-item $TestsPath).Parent -ChildPath "Functions"

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\PSHTML -Force

Context "Testing PSHTML"{
    Describe "Testing base - ScriptBlock" {


        $Class = "MyClass"
        $Id = "MyID"
        $CustomAtt = @{"MyAttribute1"='MyValue1';"MyAttribute2"="MyValue2"}

        $string = base -href "www.powershelldistrict.com" -Target "_top" -Attributes $CustomAtt -Class $class -id $id

        if($string -is [array]){
            $string = $String -join ""
        }

        it "Should contain opening and closing tags" {
            $string -match '^<base .*/>$' | should be $true

        }

        it "Testing common parameters: href"{
            $string -match '^<base.*href="www\.powershelldistrict\.com".*/>' | should be $true
        }

        it "Testing common parameters: Attributes should not be present"{
            $string -match '^<base.*attributes=.*>' | should be $false
        }

        it "Testing common parameters: Target"{
            $string -match '^<base.*target="_top".*>' | should be $true
        }

        it "Testing common parameters: Class"{
            $string -match '^<base.*class="myclass".*>' | should be $true
        }
        it "Testing common parameters: ID"{
            $string -match '^<base.*id="myid".*>' | should be $true
        }

        it "Testing Attributes parameters"{

            foreach($at in $CustomAtt.Keys){
                $val = $null
                $val = $CustomAtt[$at]
                $string -match "^<base.*$at=`"$val`".*>" | should be $true
            }


        }


    }

    Describe "Testing base without optional explicit Param" {

        $href = "www.powershelldistrict.com"
        $string = base -href $href

        if($string -is [array]){
            $string = $String -join ""
        }

        it "Should contain opening and closing tags" {
            $string -match '^<base .*/>$' | should be $true

        }

        it "Testing common parameters: href"{
            $string -match '^<base.*href="www\.powershelldistrict\.com".*/>' | should be $true
        }

        <#
         it "Testing default parameters: Target"{
            $string -match '^<base.*target="_self".*>' | should be $true
        }
 #>
        }
    }
Pop-Location