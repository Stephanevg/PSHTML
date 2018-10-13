$TestsPath = Split-Path $MyInvocation.MyCommand.Path

#$FunctionsPath = join-Path -Path (get-item $TestsPath).Parent -ChildPath "Functions"

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\pshtml.psd1 -Force

Context "Testing PSHTML"{
    Describe "Testing option" {


        $Class = "MyClass"
        $Id = "MyID"
        $Style = "Background:green"
        $CustomAtt = @{"MyAttribute1"='MyValue1';"MyAttribute2"="MyValue2"}
        $string = option {"woop"} -Attributes $CustomAtt -Style $Style -Class $class -id $id

        if($string -is [array]){
            $string = $String -join ""
        }

        it "Should contain opening and closing tags" {
            $string -match '^<option.*>' | should be $true
            $string -match '.*</option>$' | should be $true

        }

        it "Testing content in child element"{
            $string -match "^.*>woop<.*" | should be $true
        }

        it "Testing common parameters: Class"{
            $string -match '^<option.*class="myclass".*>' | should be $true
        }
        it "Testing common parameters: ID"{
            $string -match '^<option.*id="myid".*>' | should be $true
        }
        it "Testing common parameters: Style"{
            $string -match '^<option.*style=".+".*>' | should be $true
        }

        it "Testing Attributes parameters"{

            foreach($at in $CustomAtt.Keys){
                $val = $null
                $val = $CustomAtt[$at]
                $string -match "^<option.*$at=`"$val`".*>" | should be $true
            }


        }

        it 'Testing: -Content Parameter should expand child elements' {
            
            $string2 = option {em "Expanded" }
            $String2 = $string2 -join ""
            
                $string2 -match '^.*>.*<em.*>.*Expanded.*<.*' | should be $true
            
        }


    }

}

Pop-Location