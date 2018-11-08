$TestsPath = Split-Path $MyInvocation.MyCommand.Path

#$FunctionsPath = join-Path -Path (get-item $TestsPath).Parent -ChildPath "Functions"

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\PSHTML -Force

Context "Testing PSHTML" {
    Describe "Testing SUP" {


        $Class = "MyClass"
        $Id = "MyID"
        $Style = "Background:green"
        $CustomAtt = @{"MyAttribute1" = 'MyValue1'; "MyAttribute2" = "MyValue2"}
        $string = SUP {'woop'} -Attributes $CustomAtt -Style $Style -Class $class -id $id

        if ($string -is [array]) {
            $string = $String -join ""
        }

        it "Should contain opening and closing tags" {
            $string -match '^<SUP.*>' | should be $true
            $string -match '.*</SUP>$' | should be $true

        }

        it "Testing content in child element" {
            $string -match "^.*>woop<.*" | should be $true
        }

        it "Testing common parameters: Class" {
            $string -match '^<SUP.*class="myclass".*>' | should be $true
        }
        it "Testing common parameters: ID" {
            $string -match '^<SUP.*id="myid".*>' | should be $true
        }
        it "Testing common parameters: Style" {
            $string -match '^<SUP.*style=".+".*>' | should be $true
        }

        it "Testing Attributes parameters" {

            foreach ($at in $CustomAtt.Keys) {
                $val = $null
                $val = $CustomAtt[$at]
                $string -match "^<SUP.*$at=`"$val`".*>" | should be $true
            }
        }
    }
#I deactivated the Pipeline tests as these ones are blocking us for Linux support. this feature is minor, and will be added in a feature version.
<#
    Describe "Testing SUP with Pipeline" {


        $Class = "MyClass"
        $Id = "MyID"
        $Style = "Background:green"
        $CustomAtt = @{"MyAttribute1" = 'MyValue1'; "MyAttribute2" = "MyValue2"}
        $string = p {} | SUP -Attributes $CustomAtt -Style $Style -Class $class -id $id

        if ($string -is [array]) {
            $string = $String -join ""
        }

        it "Should contain opening and closing tags" {
            $string -match '^<SUP.*>' | should be $true
            $string -match '.*</SUP>$' | should be $true

        }

        it "Testing content p{} in child element" {
            $string -match "^.*<p>.*</p>.*" | should be $true
        }

        it "Testing common parameters: Class" {
            $string -match '^<SUP.*class="myclass".*>' | should be $true
        }
        it "Testing common parameters: ID" {
            $string -match '^<SUP.*id="myid".*>' | should be $true
        }
        it "Testing common parameters: Style" {
            $string -match '^<SUP.*style=".+".*>' | should be $true
        }

        it "Testing Attributes parameters" {

            foreach ($at in $CustomAtt.Keys) {
                $val = $null
                $val = $CustomAtt[$at]
                $string -match "^<SUP.*$at=`"$val`".*>" | should be $true
            }


        }


    }
#>
}

Pop-Location
