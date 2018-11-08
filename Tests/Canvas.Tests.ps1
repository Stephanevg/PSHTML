$TestsPath = Split-Path $MyInvocation.MyCommand.Path

#$FunctionsPath = join-Path -Path (get-item $TestsPath).Parent -ChildPath "Functions"

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\PSHTML -Force

Context "Testing PSHTML" {
    Describe "Testing Canvas" {


        $Class = "MyClass"
        $Id = "MyID"
        $Style = "Background:green"
        $CustomAtt = @{"MyAttribute1" = 'MyValue1'; "MyAttribute2" = "MyValue2"}
        $Height = 55
        $Width = 66
        $string = Canvas {'woop'} -Attributes $CustomAtt -Style $Style -Class $class -id $id -Height $Height -Width $Width

        if ($string -is [array]) {
            $string = $String -join ""
        }

        it "Should contain opening and closing tags" {
            $string -match '^<Canvas.*>' | should be $true
            $string -match '.*</Canvas>$' | should be $true

        }

        it "Testing content in child element" {
            $string -match "^.*>woop<.*" | should be $true
        }

        it "Testing common parameters: Class" {
            $string -match '^<Canvas.*class="myclass".*>' | should be $true
        }
        it "Testing common parameters: ID" {
            $string -match '^<Canvas.*id="myid".*>' | should be $true
        }
        it "Testing common parameters: Style" {
            $string -match '^<Canvas.*style=".+".*>' | should be $true
        }

        it "Testing common parameters: Height" {
            $string -match '^<Canvas.*height="55".*>' | should be $true
        }

        it "Testing common parameters: width" {
            $string -match '^<Canvas.*width="66".*>' | should be $true
        }

        it "Testing Attributes parameters" {

            foreach ($at in $CustomAtt.Keys) {
                $val = $null
                $val = $CustomAtt[$at]
                $string -match "^<Canvas.*$at=`"$val`".*>" | should be $true
            }


        }


    }

    Describe "Testing Canvas with Pipeline" {


        $Class = "MyClass"
        $Id = "MyID"
        $Style = "Background:green"
        $CustomAtt = @{"MyAttribute1" = 'MyValue1'; "MyAttribute2" = "MyValue2"}
        $string = p {} | Canvas -Attributes $CustomAtt -Style $Style -Class $class -id $id

        if ($string -is [array]) {
            $string = $String -join ""
        }

        it "Should contain opening and closing tags" {
            $string -match '^<Canvas.*>' | should be $true
            $string -match '.*</Canvas>$' | should be $true

        }

        it "Testing content p{} in child element" {
            $string -match "^.*<p.*></p>.*" | should be $true
        }

        it "Testing common parameters: Class" {
            $string -match '^<Canvas.*class="myclass".*>' | should be $true
        }
        it "Testing common parameters: ID" {
            $string -match '^<Canvas.*id="myid".*>' | should be $true
        }
        it "Testing common parameters: Style" {
            $string -match '^<Canvas.*style=".+".*>' | should be $true
        }

        it "Testing Attributes parameters" {

            foreach ($at in $CustomAtt.Keys) {
                $val = $null
                $val = $CustomAtt[$at]
                $string -match "^<Canvas.*$at=`"$val`".*>" | should be $true
            }


        }


    }
}

Pop-Location
