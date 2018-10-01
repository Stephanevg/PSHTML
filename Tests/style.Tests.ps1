$TestsPath = Split-Path $MyInvocation.MyCommand.Path

#$FunctionsPath = join-Path -Path (get-item $TestsPath).Parent -ChildPath "Functions"

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\PSHTML -Force

    Describe "Testing style - ScriptBlock" {


        $Class = "MyClass"
        $Id = "MyID"
        $Style = "Background:green"
        $CustomAtt = @{"MyAttribute1"='MyValue1';"MyAttribute2"="MyValue2"}
        $type = "text/css"
        $media = "print"
        $string = style {"woop"} -Attributes $CustomAtt -Class $class -id $id -Type $type -media $media

        if($string -is [array]){
            $string = $String -join ""
        }

        it "Should contain opening and closing tags" {
            $string -match '^<style.*>' | should be $true
            $string -match '.*</style>$' | should be $true

        }

        it "Testing content in child element"{
            $string -match "^.*>woop<.*" | should be $true
        }

        it "Testing common parameters: media"{
            $string -match '^<style.*media="print".*>' | should be $true
        }

        it "Testing common parameters: type"{
            $string -match '^<style.*type="text/css".*>' | should be $true
        }

        it "Testing common parameters: Class"{
            $string -match '^<style.*class="myclass".*>' | should be $true
        }
        it "Testing common parameters: ID"{
            $string -match '^<style.*id="myid".*>' | should be $true
        }

        it "Testing Attributes parameters"{

            foreach($at in $CustomAtt.Keys){
                $val = $null
                $val = $CustomAtt[$at]
                $string -match "^<style.*$at=`"$val`".*>" | should be $true
            }


        }


    }


Pop-Location