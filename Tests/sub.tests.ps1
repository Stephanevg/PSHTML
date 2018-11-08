$TestsPath = Split-Path $MyInvocation.MyCommand.Path

#$FunctionsPath = join-Path -Path (get-item $TestsPath).Parent -ChildPath "Functions"

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\PSHTML -Force

Context "Testing PSHTML" {
    Describe "Testing SUB" {


        $Class = "MyClass"
        $Id = "MyID"
        $Style = "Background:green"
        $CustomAtt = @{"MyAttribute1" = 'MyValue1'; "MyAttribute2" = "MyValue2"}
        $string = SUB {'woop'} -Attributes $CustomAtt -Style $Style -Class $class -id $id

        if ($string -is [array]) {
            $string = $String -join ""
        }

        it "Should contain opening and closing tags" {
            $string -match '^<SUB.*>' | should be $true
            $string -match '.*</SUB>$' | should be $true

        }

        it "Testing content in child element" {
            $s = $string -join ""
            $s -match "^.*>.*woop.*<.*" | should be $true
        }

        it "Testing common parameters: Class" {
            $string -match '^<SUB.*class="myclass".*>' | should be $true
        }
        it "Testing common parameters: ID" {
            $string -match '^<SUB.*id="myid".*>' | should be $true
        }
        it "Testing common parameters: Style" {
            $string -match '^<SUB.*style=".+".*>' | should be $true
        }

        it "Testing Attributes parameters" {

            foreach ($at in $CustomAtt.Keys) {
                $val = $null
                $val = $CustomAtt[$at]
                $string -match "^<SUB.*$at=`"$val`".*>" | should be $true
            }


        }
    }
    Describe "Testing SUB with Pipeline" {
        $Class = "MyClass"
        $Id = "MyID"
        $Style = "Background:green"
        $CustomAtt = @{"MyAttribute1" = 'MyValue1'; "MyAttribute2" = "MyValue2"}
        $string = p {} | SUB -Attributes $CustomAtt -Style $Style -Class $class -id $id
        if ($string -is [array]) {
            $string = $String -join ""
        }
        it "Should contain opening and closing tags" {
            $string -match '^<SUB.*>' | should be $true
            $string -match '.*</SUB>$' | should be $true

        }

        it "Testing content p{} in child element" {
            $string -match "^.*<p.*></p>.*" | should be $true
        }

        it "Testing common parameters: Class" {
            $string -match '^<SUB.*class="myclass".*>' | should be $true
        }
        it "Testing common parameters: ID" {
            $string -match '^<SUB.*id="myid".*>' | should be $true
        }
        it "Testing common parameters: Style" {
            $string -match '^<SUB.*style=".+".*>' | should be $true
        }

        it "Testing Attributes parameters" {

            foreach ($at in $CustomAtt.Keys) {
                $val = $null
                $val = $CustomAtt[$at]
                $string -match "^<SUB.*$at=`"$val`".*>" | should be $true
            }
        }
    }
}

Pop-Location