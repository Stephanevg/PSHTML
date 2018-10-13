$TestsPath = Split-Path $MyInvocation.MyCommand.Path

#$FunctionsPath = join-Path -Path (get-item $TestsPath).Parent -ChildPath "Functions"

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\pshtml.psd1 -Force

Context "Testing PSHTML"{
    Describe "Testing h2 - ScriptBlock" {


        $Class = "MyClass"
        $Id = "MyID"
        $Style = "Background:green"
        $CustomAtt = @{"MyAttribute1"='MyValue1';"MyAttribute2"="MyValue2"}
        $string = h2 {"woop"} -Attributes $CustomAtt -Style $Style -Class $class -id $id

        if($string -is [array]){
            $string = $String -join ""
        }

        it "Should contain opening and closing tags" {
            $string -match '^<h2.*>' | should be $true
            $string -match '.*</h2>$' | should be $true

        }

        it "Testing content in child element"{
            $string -match "^.*>woop<.*" | should be $true
        }

        it "Testing common parameters: Class"{
            $string -match '^<h2.*class="myclass".*>' | should be $true
        }
        it "Testing common parameters: ID"{
            $string -match '^<h2.*id="myid".*>' | should be $true
        }
        it "Testing common parameters: Style"{
            $string -match '^<h2.*style=".+".*>' | should be $true
        }

        it "Testing Attributes parameters"{

            foreach($at in $CustomAtt.Keys){
                $val = $null
                $val = $CustomAtt[$at]
                $string -match "^<h2.*$at=`"$val`".*>" | should be $true
            }


        }


    }

    Describe "Testing h2 - String" {

        it 'Should not fail when passing String' {
            {h2 "woop"} | should not throw
        }



        $String = h2 "woop"

        if($string -is [array]){
            $string = $String -join ""
        }

        it "Should contain opening and closing tags" {
            $string -match '^<h2.*>' | should be $true
            $string -match '.*</h2>$' | should be $true

        }

        it "Testing content in child element"{
            $string -match "^.*>woop<.*" | should be $true
        }
    }

}

Pop-Location