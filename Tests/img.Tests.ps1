$TestsPath = Split-Path $MyInvocation.MyCommand.Path

#$FunctionsPath = join-Path -Path (get-item $TestsPath).Parent -ChildPath "Functions"

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\PSHtml -Force

Context "Testing PSHTML"{
    Describe "Testing img - ScriptBlock" {


        $Class = "MyClass"
        $Id = "MyID"
        $Style = "Background:green"
        $CustomAtt = @{"MyAttribute1"='MyValue1';"MyAttribute2"="MyValue2"}
        $string = img -src "Myimage.png" -alt "alternative display" -Attributes $CustomAtt -Style $Style -Class $class -id $id

        if($string -is [array]){
            $string = $String -join ""
        }

        it "Should contain opening and closing tags" {
            $string -match '^<img.*/>' | should be $true
            $string -match '.*/>$' | should be $true

        }

        it "Testing common parameters: src"{
            $string -match '^<img.*src="Myimage.png".*>' | should be $true
        }

        it "Testing common parameters: alt"{
            $string -match '^<img.*alt="alternative display".*>' | should be $true
        }

        it "Testing common parameters: Class"{
            $string -match '^<img.*class="myclass".*>' | should be $true
        }
        it "Testing common parameters: ID"{
            $string -match '^<img.*id="myid".*>' | should be $true
        }
        it "Testing common parameters: Style"{
            $string -match '^<img.*style=".+".*>' | should be $true
        }

        it "Testing Attributes parameters"{

            foreach($at in $CustomAtt.Keys){
                $val = $null
                $val = $CustomAtt[$at]
                $string -match "^<img.*$at=`"$val`".*>" | should be $true
            }


        }


    }


}

Pop-Location