$TestsPath = Split-Path $MyInvocation.MyCommand.Path

#$FunctionsPath = join-Path -Path (get-item $TestsPath).Parent -ChildPath "Functions"

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\PSHTML -Force

    Describe "Testing optgroup - ScriptBlock" {


        $Class = "MyClass"
        $Id = "MyID"
        $CustomAtt = @{"MyAttribute1"='MyValue1';"MyAttribute2"="MyValue2"}

        $string = optgroup -label "woop" -Target _top -Attributes $CustomAtt -Class $class -id $id

        if($string -is [array]){
            $string = $String -join ""
        }

        it "Should contain opening and closing tags" {
            $string -match '^<optgroup .*/>$' | should be $true

        }

        it "Testing common parameters: href"{
            $string -match '^<optgroup.*href="www\.powershelldistrict\.com".*/>' | should be $true
        }

        it "Testing common parameters: Attributes should not be present"{
            $string -match '^<optgroup.*attributes=.*>' | should be $false
        }

        it "Testing common parameters: Target"{
            $string -match '^<optgroup.*target="_top".*>' | should be $true
        }

        it "Testing common parameters: Class"{
            $string -match '^<optgroup.*class="myclass".*>' | should be $true
        }
        it "Testing common parameters: ID"{
            $string -match '^<optgroup.*id="myid".*>' | should be $true
        }

        it "Testing Attributes parameters"{

            foreach($at in $CustomAtt.Keys){
                $val = $null
                $val = $CustomAtt[$at]
                $string -match "^<optgroup.*$at=`"$val`".*>" | should be $true
            }


        }


    }

Pop-Location