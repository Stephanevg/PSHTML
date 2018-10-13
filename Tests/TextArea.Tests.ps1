$TestsPath = Split-Path $MyInvocation.MyCommand.Path

#$FunctionsPath = join-Path -Path (get-item $TestsPath).Parent -ChildPath "Functions"

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\pshtml.psd1 -Force

Context "Testing PSHTML"{
    Describe "Testing output" {


        $Class = "MyClass"
        $Id = "MyID"
        $Style = "Background:green"
        $CustomAtt = @{"MyAttribute1"='MyValue1';"MyAttribute2"="MyValue2"}
        $string = output {"woop"} -Attributes $CustomAtt -Style $Style -Class $class -id $id

        if($string -is [array]){
            $string = $String -join ""
        }

        it "Should contain opening and closing tags" {
            $string -match '^<output.*>' | should be $true
            $string -match '.*</output>$' | should be $true

        }

        it "Testing content in child element"{
            $string -match "^.*>woop<.*" | should be $true
        }

        it "Testing common paraoutputs: Class"{
            $string -match '^<output.*class="myclass".*>' | should be $true
        }
        it "Testing common paraoutputs: ID"{
            $string -match '^<output.*id="myid".*>' | should be $true
        }
        it "Testing common paraoutputs: Style"{
            $string -match '^<output.*style=".+".*>' | should be $true
        }

        it "Testing Attributes paraoutputs"{

            foreach($at in $CustomAtt.Keys){
                $val = $null
                $val = $CustomAtt[$at]
                $string -match "^<output.*$at=`"$val`".*>" | should be $true
            }


        }


    }

}

Pop-Location