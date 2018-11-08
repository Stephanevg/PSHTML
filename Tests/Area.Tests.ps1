$TestsPath = Split-Path $MyInvocation.MyCommand.Path

#$FunctionsPath = join-Path -Path (get-item $TestsPath).Parent -ChildPath "Functions"

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\PSHTML -Force

Context "Testing PSHTML"{
    Describe "Testing area" {

        $link = "action_Page.php"
        $Method = "post"
        $Target = "_self"
        $Class = "MyClass"
        $Id = "MyID"
        $href = $Link
        $Style = "Background:green"
        $alt = "alternate description"
        $Coords = "0,0,10,10"
        $CustomAtt = @{"MyAttribute1"='MyValue1';"MyAttribute2"="MyValue2"}

        $String = area -href $Link -alt $Alt -coords $Coords -target $Target -Class $Class -Style $Style -Attributes $CustomAtt -Id $Id
        if($string -is [array]){
            $string = $String -join ""
        }

        it "Should contain opening (and voided closing) tag" {
            $string -match '^<area.*>' | should be $true

            $string -match '.*<.*/>$' | should be $true
            

        }

        it "Testing primary parameters: href"{
            $string -match '^<area.*href="action_Page\.php".*>'| should be $true
        }

        it "Testing primary parameters: coords"{
            $string -match '^<area.*coords="0,0,10,10".*>' | should be $true
        }

        it "Testing primary parameters: target"{
            $string -match '^<area.*target="_self".*>' | should be $true
        }

        it "Testing common parameters: Class"{
            $string -match '^<area.*class="myclass".*>' | should be $true
        }
        it "Testing common parameters: ID"{
            $string -match '^<area.*id="myid".*>' | should be $true
        }
        it "Testing common parameters: Style"{
            $string -match '^<area.*style=".+".*>' | should be $true
        }

        it "Testing Attributes parameters"{

            foreach($at in $CustomAtt.Keys){
                $val = $null
                $val = $CustomAtt[$at]
                $string -match "^<area.*$at=`"$val`".*>" | should be $true
            }


        }


    }
    Describe "Testing area without optional explicit Param" {

        $String = area 
        if($string -is [array]){
            $string = $String -join ""
        }

        it "Should contain opening (and voided closing) tag" {
            $string -match '^<area.*>' | should be $true

            $string -match '.*<.*/>$' | should be $true
            

        }
<# 
        it "Testing default parameters: target"{
            $string -match '^<area.*target="_Blank".*>' | should be $true
        }
 #>
    }
}

Pop-Location