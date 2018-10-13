$TestsPath = Split-Path $MyInvocation.MyCommand.Path

#$FunctionsPath = join-Path -Path (get-item $TestsPath).Parent -ChildPath "Functions"

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\PSHtml -Force

Context "Testing PSHTML"{
    Describe "Testing col" {


        $Class = "MyClass"
        $Id = "MyID"
        $Style = "Background:green"
        $CustomAtt = @{"MyAttribute1"='MyValue1';"MyAttribute2"="MyValue2"}
        $string = col -span 4 -Attributes $CustomAtt -Style $Style -Class $class -id $id

        if($string -is [array]){
            $string = $String -join ""
        }

        it "Should contain opening and closing tags" {
            $string -match '^<col.*>' | should be $true


        }

        it "Testing tag parameters: span"{
            $string -match '^<col.*span="4".*>' | should be $true
        }

        it "Testing common parameters: Class"{
            $string -match '^<col.*class="myclass".*>' | should be $true
        }
        it "Testing common parameters: ID"{
            $string -match '^<col.*id="myid".*>' | should be $true
        }
        it "Testing common parameters: Style"{
            $string -match '^<col.*style=".+".*>' | should be $true
        }

        it "Testing Attributes parameters"{

            foreach($at in $CustomAtt.Keys){
                $val = $null
                $val = $CustomAtt[$at]
                $string -match "^<col.*$at=`"$val`".*>" | should be $true
            }


        }


    }

}

Pop-Location