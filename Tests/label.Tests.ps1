$TestsPath = Split-Path $MyInvocation.MyCommand.Path

#$FunctionsPath = join-Path -Path (get-item $TestsPath).Parent -ChildPath "Functions"

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\pshtml.psd1 -Force
    Describe "Testing label - ScriptBlock" {


        $Class = "MyClass"
        $Id = "MyID"
        $style = "Background:green"
        $CustomAtt = @{"MyAttribute1"='MyValue1';"MyAttribute2"="MyValue2"}

        $string = label {"woop"} -Attributes $CustomAtt -Class $class -id $id

        if($string -is [array]){
            $string = $String -join ""
        }

        it "Should contain opening and closing tags" {
            $string -match '^<label.*>' | should be $true
            $string -match '.*</label>$' | should be $true

        }

        it "Testing content in child element"{
            $string -match "^.*>woop<.*" | should be $true
        }

        it "Testing common parameters: Class"{
            $string -match '^<label.*class="myclass".*>' | should be $true
        }
        it "Testing common parameters: ID"{
            $string -match '^<label.*id="myid".*>' | should be $true
        }

        it "Testing Attributes parameters"{

            foreach($at in $CustomAtt.Keys){
                $val = $null
                $val = $CustomAtt[$at]
                $string -match "^<label.*$at=`"$val`".*>" | should be $true
            }


        }


    }


Pop-Location