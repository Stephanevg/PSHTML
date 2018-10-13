$TestsPath = Split-Path $MyInvocation.MyCommand.Path

#$FunctionsPath = join-Path -Path (get-item $TestsPath).Parent -ChildPath "Functions"

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\PSHtml -Force

Context "Testing PSHTML"{
    Describe "Testing link" {


        $Class = "MyClass"
        $Id = "MyID"
        $Style = "Background:green"
        $href = "woop"
        $rel = "author"
        $CustomAtt = @{"MyAttribute1"='MyValue1';"MyAttribute2"="MyValue2"}
        $string = link -href $href -rel $rel  -Attributes $CustomAtt -Style $Style -Class $class -id $id

        if($string -is [array]){
            $string = $String -join ""
        }

        it "Should contain opening and closing tags" {
            $string -match '^<link.*>' | should be $true
            #$string -match '.*</link>$' | should be $true

        }


        it "Testing common parameters: Class"{
            $string -match '^<link.*class="myclass".*>' | should be $true
        }
        it "Testing common parameters: ID"{
            $string -match '^<link.*id="myid".*>' | should be $true
        }
        it "Testing common parameters: Style"{
            $string -match '^<link.*style=".+".*>' | should be $true
        }

        it "Testing Attributes parameters"{

            foreach($at in $CustomAtt.Keys){
                $val = $null
                $val = $CustomAtt[$at]
                $string -match "^<link.*$at=`"$val`".*>" | should be $true
            }


        }


    }

}

Pop-Location