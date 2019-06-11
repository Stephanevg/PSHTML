$TestsPath = Split-Path $MyInvocation.MyCommand.Path

#$FunctionsPath = join-Path -Path (get-item $TestsPath).Parent -ChildPath "Functions"

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\PSHTML -Force

Context "Testing PSHTML"{
    Describe "Testing Form" {

        $Action = "action_Page.php"
        $Method = "get"
        $Target = "_self"
        $Class = "MyClass"
        $Id = "MyID"
        $Style = "Background:green"
        $CustomAtt = @{"MyAttribute1"='MyValue1';"MyAttribute2"="MyValue2"}
        $string = form $Action $Method $Target -Attributes $CustomAtt -Style $Style -Class $class -id $id

        if($string -is [array]){
            $string = $String -join ""
        }

        it "Should contain opening and closing tags" {
            $string -match '^<form.*>' | should be $true
            $string -match '.*</form>$' | should be $true

        }

        it "Testing primary parameters: Action"{
            $string -match '^<form.*action="action_Page\.php".*>'| should be $true
        }

        it "Testing primary parameters: Method"{
            $string -match '^<form.*method="get".*>' | should be $true
        }

        it "Testing primary parameters: target"{
            $string -match '^<form.*target="_self".*>' | should be $true
        }

        it "Testing common parameters: Class"{
            $string -match '^<form.*class="myclass".*>' | should be $true
        }
        it "Testing common parameters: ID"{
            $string -match '^<form.*id="myid".*>' | should be $true
        }
        it "Testing common parameters: Style"{
            $string -match '^<form.*style=".+".*>' | should be $true
        }

        it "Testing Attributes parameters"{

            foreach($at in $CustomAtt.Keys){
                $val = $null
                $val = $CustomAtt[$at]
                $string -match "^<form.*$at=`"$val`".*>" | should be $true
            }


        }

        it "#212-Should not throw when parameter -target is not specified"{
            {form -action "ee" -method Get} | Should not throw
        }

        it "#212-when target not specified, should set target=_self by default"{
            $tr = form -action "ee" -method Get
            $tr -match '<form.*target="_self".*' | Should be $true
        }

        it "#211-Should throw when parameter -enctype is specified when -Method get"{
            {form -action "ee" -method Get -enctype "plop"} | Should throw
        }

        it "#211-Should Not throw when parameter -enctype is specified with -Method Post"{
            {form -target _self -action "ee" -method Post -enctype "text/plain"} | Should Not throw
        }

        it "return correct enctype values"{
            $st = form -target _self -action "ee" -method Post -enctype "text/plain"
            $st -Match '^<form.*enctype.*text/plain.*' | Should be $true
        }


    }

}

Pop-Location