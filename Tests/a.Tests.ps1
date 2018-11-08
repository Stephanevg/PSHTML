$TestsPath = Split-Path $MyInvocation.MyCommand.Path

#$FunctionsPath = join-Path -Path (get-item $TestsPath).Parent -ChildPath "Functions"

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\PSHTML -Force

Context "Testing PSHTML"{
    Describe "Testing a" {


        $Class = "MyClass"
        $Id = "MyID"
        $href = "www.powershelldistrict.com"
        $target = "_self"
        $Style = "Background:green"
        $CustomAtt = @{"MyAttribute1"='MyValue1';"MyAttribute2"="MyValue2"}
        $string = a {"woop"} -Target $target -href $href -Attributes $CustomAtt -Style $Style -Class $class -id $id

        if($string -is [array]){
            $string = $String -join ""
        }

        it "Should contain opening and closing tags" {
            $string -match '^<a.*>' | should be $true
            $string -match '.*</a>$' | should be $true

        }

        it "Testing content in child element"{
            $string -match "^.*>woop<.*" | should be $true
        }


        it "Testing common parameters: target"{
            $string -match '^<a.*target="_self".*>' | should be $true
        }

        it "Testing common parameters: href"{
            $string -match '^<a.*href="www\.powershelldistrict\.com".*>' | should be $true
        }

        it "Testing common parameters: Class"{
            $string -match '^<a.*class="myclass".*>' | should be $true
        }
        it "Testing common parameters: ID"{
            $string -match '^<a.*id="myid".*>' | should be $true
        }
        it "Testing common parameters: Style"{
            $string -match '^<a.*style=".+".*>' | should be $true
        }

        it "Testing Attributes parameters"{

            foreach($at in $CustomAtt.Keys){
                $val = $null
                $val = $CustomAtt[$at]
                $string -match "^<a.*$at=`"$val`".*>" | should be $true
            }


        }


    }

    Describe "Testing a without optional explicit Param" {

        $href = "www.powershelldistrict.com"
        $string = a {"woop"} -href $href

        if($string -is [array]){
            $string = $String -join ""
        }

        it "Should contain opening and closing tags" {
            $string -match '^<a.*>' | should be $true
            $string -match '.*</a>$' | should be $true

        }

        it "Testing content in child element"{
            $string -match "^.*>woop<.*" | should be $true
        }


        #This feature will be implemented in next version.
        <# it "Testing default parameters: target"{
            $string -match '^<a.*target="_self".*>' | should be $true
        } #>

        it "Testing common parameters: href"{
            $string -match '^<a.*href="www\.powershelldistrict\.com".*>' | should be $true
        }

        }


    }

Pop-Location