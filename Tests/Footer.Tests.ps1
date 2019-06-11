$TestsPath = Split-Path $MyInvocation.MyCommand.Path

#$FunctionsPath = join-Path -Path (get-item $TestsPath).Parent -ChildPath "Functions"

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\PSHTML -Force

Context "Testing PSHTML"{
    Describe "Testing footer" {


        $Class = "MyClass"
        $Id = "MyID"
        $Style = "Background:green"
        $CustomAtt = @{"MyAttribute1"='MyValue1';"MyAttribute2"="MyValue2"}
        $string = footer {"woop"} -Attributes $CustomAtt -Style $Style -Class $class -id $id

        if($string -is [array]){
            $string = $String -join ""
        }

        it "Should contain opening and closing tags" {
            $string -match '^<footer.*>' | should be $true
            $string -match '.*</footer>$' | should be $true

        }

        it "Testing content in child element"{
            $string -match "^.*>woop<.*" | should be $true
        }

        it "Testing common parameters: Class"{
            $string -match '^<footer.*class="myclass".*>' | should be $true
        }
        it "Testing common parameters: ID"{
            $string -match '^<footer.*id="myid".*>' | should be $true
        }
        it "Testing common parameters: Style"{
            $string -match '^<footer.*style=".+".*>' | should be $true
        }

        it "Testing Attributes parameters"{

            foreach($at in $CustomAtt.Keys){
                $val = $null
                $val = $CustomAtt[$at]
                $string -match "^<footer.*$at=`"$val`".*>" | should be $true
            }


        }


    }

    Describe "Testing Footer - String" {

        it 'Should not fail when passing String' {
            {p "woop"} | should not throw
        }



        $String = Footer "woop"

        if($string -is [array]){
            $string = $String -join ""
        }

        it "Should contain opening and closing tags" {
            $string -match '^<footer.*>' | should be $true
            $string -match '.*</footer>$' | should be $true

        }

        it "Testing content in child element"{
            $string -match "^.*>woop<.*" | should be $true
        }
    }
}

Pop-Location