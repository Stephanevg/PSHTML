$TestsPath = Split-Path $MyInvocation.MyCommand.Path

#$FunctionsPath = join-Path -Path (get-item $TestsPath).Parent -ChildPath "Functions"

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\PSHTML -Force

Context "Testing PSHTML"{
    Describe "Testing TextArea" {


        $Class = "MyClass"
        $Id = "MyID"
        $Style = "Background:green"
        $CustomAtt = @{"MyAttribute1"='MyValue1';"MyAttribute2"="MyValue2"}
        $string = TextArea {"woop"} -Attributes $CustomAtt -Style $Style -Class $class -id $id

        if($string -is [array]){
            $string = $String -join ""
        }

        it "Should contain opening and closing tags" {
            $string -match '^<TextArea.*>' | should be $true
            $string -match '.*</TextArea>$' | should be $true

        }

        it "Testing content in child element"{
            $string -match "^.*>woop<.*" | should be $true
        }

        it "Testing common paraTextAreas: Class"{
            $string -match '^<TextArea.*class="myclass".*>' | should be $true
        }
        it "Testing common paraTextAreas: ID"{
            $string -match '^<TextArea.*id="myid".*>' | should be $true
        }
        it "Testing common paraTextAreas: Style"{
            $string -match '^<TextArea.*style=".+".*>' | should be $true
        }

        it "Testing Attributes paraTextAreas"{

            foreach($at in $CustomAtt.Keys){
                $val = $null
                $val = $CustomAtt[$at]
                $string -match "^<TextArea.*$at=`"$val`".*>" | should be $true
            }


        }


    }

}

Pop-Location