$TestsPath = Split-Path $MyInvocation.MyCommand.Path

#$FunctionsPath = join-Path -Path (get-item $TestsPath).Parent -ChildPath "Functions"

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\pshtml.psd1 -Force

Context "Testing PSHTML"{
    Describe "Testing p - Scriptblock" {


        $Class = "MyClass"
        $Id = "MyID"
        $Style = "Background:green"
        $Title = "MyTitle"
        $CustomAtt = @{"MyAttribute1"='MyValue1';"MyAttribute2"="MyValue2"}
        $string = p {"woop"} -title $Title -Attributes $CustomAtt -Style $Style -Class $class -id $id

        if($string -is [array]){
            $string = $String -join ""
        }

        it "Should contain opening and closing tags" {
            $string -match '^<p.*>' | should be $true
            $string -match '.*</p>$' | should be $true

        }

        it "Testing content in child element"{
            $string -match "^.*>woop<.*" | should be $true
        }

        it "Testing Primary parameters: Title"{
            $string -match '^<p.*title="MyTitle".*>' | should be $true
        }

        it "Testing common parameters: Class"{
            $string -match '^<p.*class="myclass".*>' | should be $true
        }
        it "Testing common parameters: ID"{
            $string -match '^<p.*id="myid".*>' | should be $true
        }
        it "Testing common parameters: Style"{
            $string -match '^<p.*style=".+".*>' | should be $true
        }

        it "Testing Attributes parameters"{

            foreach($at in $CustomAtt.Keys){
                $val = $null
                $val = $CustomAtt[$at]
                $string -match "^<p.*$at=`"$val`".*>" | should be $true
            }


        }


    }

    Describe "Testing p - String" {

        it 'Should not fail when passing String' {
            {h5 "woop"} | should not throw
        }



        $String = p "woop"

        if($string -is [array]){
            $string = $String -join ""
        }

        it "Should contain opening and closing tags" {
            $string -match '^<p.*>' | should be $true
            $string -match '.*</p>$' | should be $true

        }

        it "Testing content in child element"{
            $string -match "^.*>woop<.*" | should be $true
        }
    }
}

Pop-Location