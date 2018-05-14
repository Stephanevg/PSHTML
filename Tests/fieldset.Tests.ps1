$TestsPath = Split-Path $MyInvocation.MyCommand.Path

#$FunctionsPath = join-Path -Path (get-item $TestsPath).Parent -ChildPath "Functions"

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\PSHTML -Force

    Describe "Testing fieldset - ScriptBlock" {
        

        $Class = "MyClass"
        $Id = "MyID"
        $fieldset = "Background:green"
        $CustomAtt = @{"MyAttribute1"='MyValue1';"MyAttribute2"="MyValue2"}
        $form = "myform"
        $name = "form01"
        $string = fieldset {"woop"} -Attributes $CustomAtt -Class $class -id $id -form $form -name $name
       
        if($string -is [array]){
            $string = $String -join "" 
        }

        it "Should contain opening and closing tags" {
            $string -match '^<fieldset.*>' | should be $true
            $string -match '.*</fieldset>$' | should be $true
            
        }

        it "Testing content in child element"{
            $string -match "^.*>woop<.*" | should be $true
        }

        it "Testing common parameters: form"{
            $string -match "^<fieldset.*form=`"$form`".*>" | should be $true
        }

        it "Testing common parameters: name"{
            $string -match '^<fieldset.*name="form01".*>' | should be $true
        }

        it "Testing common parameters: Class"{
            $string -match '^<fieldset.*class="myclass".*>' | should be $true
        }
        it "Testing common parameters: ID"{
            $string -match '^<fieldset.*id="myid".*>' | should be $true
        }

        it "Testing Attributes parameters"{

            foreach($at in $CustomAtt.Keys){
                $val = $null
                $val = $CustomAtt[$at]
                $string -match "^<fieldset.*$at=`"$val`".*>" | should be $true
            }

            
        }

        
    }

Pop-Location