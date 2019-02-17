$TestsPath = Split-Path $MyInvocation.MyCommand.Path

#$FunctionsPath = join-Path -Path (get-item $TestsPath).Parent -ChildPath "Functions"

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\PSHTML -Force

Context "Testing PSHTML"{
    Describe "Testing Title" {


        $Class = "MyClass"
        $Id = "MyID"
        $Style = "Background:green"
        $CustomAtt = @{"MyAttribute1"='MyValue1';"MyAttribute2"="MyValue2"}
        $string = Title {"woop"} -Attributes $CustomAtt -Style $Style -Class $class -id $id

        if($string -is [array]){
            $string = $String -join ""
        }

        it "Should contain opening and closing tags" {
            $string -match '^<Title.*>' | should be $true
            $string -match '.*</Title>$' | should be $true

        }

        it "Testing content in child element"{
            $string -match "^.*>woop<.*" | should be $true
        }

        it "Testing common paraTitles: Class"{
            $string -match '^<Title.*class="myclass".*>' | should be $true
        }
        it "Testing common paraTitles: ID"{
            $string -match '^<Title.*id="myid".*>' | should be $true
        }
        it "Testing common paraTitles: Style"{
            $string -match '^<Title.*style=".+".*>' | should be $true
        }

        it "Testing Attributes paraTitles"{

            foreach($at in $CustomAtt.Keys){
                $val = $null
                $val = $CustomAtt[$at]
                $string -match "^<Title.*$at=`"$val`".*>" | should be $true
            }


        }


    }

}

Pop-Location