$TestsPath = Split-Path $MyInvocation.MyCommand.Path

#$FunctionsPath = join-Path -Path (get-item $TestsPath).Parent -ChildPath "Functions"

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\pshtml.psd1 -Force

Context "Testing PSHTML"{
    Describe "Testing datalist" {


        $Class = "MyClass"
        $Id = "MyID"
        $Style = "Background:green"
        $CustomAtt = @{"MyAttribute1"='MyValue1';"MyAttribute2"="MyValue2"}
        $string = datalist {"woop"} -Attributes $CustomAtt -Style $Style -Class $class -id $id

        if($string -is [array]){
            $string = $String -join ""
        }

        it "Should contain opening and closing tags" {
            $string -match '^<datalist.*>' | should be $true
            $string -match '.*</datalist>$' | should be $true

        }

        it "Testing content in child element"{
            $string -match "^.*>woop<.*" | should be $true
        }

        it "Testing common parameters: Class"{
            $string -match '^<datalist.*class="myclass".*>' | should be $true
        }
        it "Testing common parameters: ID"{
            $string -match '^<datalist.*id="myid".*>' | should be $true
        }
        it "Testing common parameters: Style"{
            $string -match '^<datalist.*style=".+".*>' | should be $true
        }

        it "Testing Attributes parameters"{

            foreach($at in $CustomAtt.Keys){
                $val = $null
                $val = $CustomAtt[$at]
                $string -match "^<datalist.*$at=`"$val`".*>" | should be $true
            }


        }

        it 'Testing: -Content Parameter should expand child elements' {
            
            $string2 = datalist {option -value "Volvo" -Content "Car" }
            $String2 = $string2 -join ""
            
                $string2 -match '^.*>.*<option value="Volvo".*<.*' | should be $true
            
        }


    }

    

}

Pop-Location