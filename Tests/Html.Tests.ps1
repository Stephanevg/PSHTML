$TestsPath = Split-Path $MyInvocation.MyCommand.Path

#$FunctionsPath = join-Path -Path (get-item $TestsPath).Parent -ChildPath "Functions"

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\PSHTML -Force

Context "Testing PSHTML"{
    Describe "Testing html - Scripblock" {


        $Class = "MyClass"
        $Id = "MyID"
        $Style = "Background:green"
        $CustomAtt = @{"MyAttribute1"='MyValue1';"MyAttribute2"="MyValue2"}
        $xmlns = "http://www.w3.org/1999/xhtml"
        $string = html {"woop"} -xmlns $xmlns -Attributes $CustomAtt -Style $Style -Class $class -id $id

        if($string -is [array]){
            $string = $String -join ""
        }

        it "Should contain opening and closing tags" {
            $string -match '^<html.*>' | should be $true
            $string -match '.*</html>$' | should be $true

        }

        it "Testing content in child element"{
            $string -match "^.*>woop<.*" | should be $true
        }

        it "Testing Primary parameters: xmlns"{
            $string -match '^<html.*xmlns="http://www.w3.org/1999/xhtml.*>' | should be $true
        }

        it "Testing common parameters: Class"{
            $string -match '^<html.*class="myclass".*>' | should be $true
        }
        it "Testing common parameters: ID"{
            $string -match '^<html.*id="myid".*>' | should be $true
        }
        it "Testing common parameters: Style"{
            $string -match '^<html.*style=".+".*>' | should be $true
        }

        it "Testing Attributes parameters"{

            foreach($at in $CustomAtt.Keys){
                $val = $null
                $val = $CustomAtt[$at]
                $string -match "^<html.*$at=`"$val`".*>" | should be $true
            }


        }


    }

    Describe "Testing html - String" {

        it 'Should not fail when passing String' {
            {h5 "woop"} | should not throw
        }



        $String = html "woop"

        if($string -is [array]){
            $string = $String -join ""
        }

        it "Should contain opening and closing tags" {
            $string -match '^<html.*>' | should be $true
            $string -match '.*</html>$' | should be $true

        }

        it "Testing content in child element"{
            $string -match "^.*>woop<.*" | should be $true
        }
    }
}

Pop-Location