$TestsPath = Split-Path $MyInvocation.MyCommand.Path

#$FunctionsPath = join-Path -Path (get-item $TestsPath).Parent -ChildPath "Functions"

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\PSHTML -Force

Context "Testing PSHTML"{
    Describe "Testing b" {


        $Class = "MyClass"
        $Id = "MyID"
        
        $CustomAtt = @{"MyAttribute1"='MyValue1';"MyAttribute2"="MyValue2"}
        $string = b {"woop"} -Attributes $CustomAtt -Class $class -id $id

        if($string -is [array]){
            $string = $String -join ""
        }

        it "Should contain opening and closing tags" {
            $string -match '^<b.*>' | should be $true
            $string -match '.*</b>$' | should be $true

        }

        it "Testing content in child element"{
            $string -match "^.*>woop<.*" | should be $true
        }


        it "Testing common parameters: Class"{
            $string -match '^<b.*class="myclass".*>' | should be $true
        }
        it "Testing common parameters: ID"{
            $string -match '^<b.*id="myid".*>' | should be $true
        }

        it "Testing Attributes parameters"{

            foreach($at in $CustomAtt.Keys){
                $val = $null
                $val = $CustomAtt[$at]
                $string -match "^<b.*$at=`"$val`".*>" | should be $true
            }
        }
    }

    Describe "Testing b without optional explicit Param" {

        $string = b {"woop"}

        if($string -is [array]){
            $string = $String -join ""
        }

        it "Should contain opening and closing tags" {
            $string -match '^<b.*>' | should be $true
            $string -match '.*</b>$' | should be $true

        }

        it "Testing content in child element"{
            $string -match "^.*>woop<.*" | should be $true
        }
    }
}
