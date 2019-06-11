$TestsPath = Split-Path $MyInvocation.MyCommand.Path

#$FunctionsPath = join-Path -Path (get-item $TestsPath).Parent -ChildPath "Functions"

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\PSHTML -Force

Context "Testing PSHTML"{
    Describe "Testing br - ScriptBlock" {


        $Class = "MyClass"
        $Id = "MyID"
        $Style = "Background:green"
        $CustomAtt = @{"MyAttribute1"='MyValue1';"MyAttribute2"="MyValue2"}
        $string = br -Attributes $CustomAtt -Style $Style -Class $class -id $id

        if($string -is [array]){
            $string = $String -join ""
        }

        it "Should contain opening and closing tags" {
            $string -match '^<br.*/>' | should be $true
            $string -match '.*/>$' | should be $true

        }


        it "Testing common parameters: Class"{
            $string -match '^<br.*class="myclass".*>' | should be $true
        }
        it "Testing common parameters: ID"{
            $string -match '^<br.*id="myid".*>' | should be $true
        }
        it "Testing common parameters: Style"{
            $string -match '^<br.*style=".+".*>' | should be $true
        }

        it "Testing Attributes parameters"{

            foreach($at in $CustomAtt.Keys){
                $val = $null
                $val = $CustomAtt[$at]
                $string -match "^<br.*$at=`"$val`".*>" | should be $true
            }


        }


    }


}

Pop-Location