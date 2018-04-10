$TestsPath = Split-Path $MyInvocation.MyCommand.Path

#$FunctionsPath = join-Path -Path (get-item $TestsPath).Parent -ChildPath "Functions"

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\PSHTML -Force

Context "Testing PSHTML"{
    Describe "Testing h1 - ScriptBlock" {
        

        $Class = "MyClass"
        $Id = "MyID"
        $Style = "Background:green"
        $CustomAtt = @{"MyAttribute1"='MyValue1';"MyAttribute2"="MyValue2"}
        $string = h1 {"woop"} -Attributes $CustomAtt -Style $Style -Class $class -id $id
       
        if($string -is [array]){
            $string = $String -join "" 
        }

        it "Should contain opening and closing tags" {
            $string -match '^<h1.*>' | should be $true
            $string -match '.*</h1>$' | should be $true
            
        }

        it "Testing content in child element"{
            $string -match "^.*>woop<.*" | should be $true
        }

        it "Testing common parameters: Class"{
            $string -match '^<h1.*class="myclass".*>' | should be $true
        }
        it "Testing common parameters: ID"{
            $string -match '^<h1.*id="myid".*>' | should be $true
        }
        it "Testing common parameters: Style"{
            $string -match '^<h1.*style=".+".*>' | should be $true
        }

        it "Testing Attributes parameters"{

            foreach($at in $CustomAtt.Keys){
                $val = $null
                $val = $CustomAtt[$at]
                $string -match "^<h1.*$at=`"$val`".*>" | should be $true
            }

            
        }

        
    }

    Describe "Testing h1 - String" {
     
        it 'Should not fail when passing String' {
            {h1 "woop"} | should not throw
        }

        

        $String = h1 "woop"
       
        if($string -is [array]){
            $string = $String -join "" 
        }

        it "Should contain opening and closing tags" {
            $string -match '^<h1.*>' | should be $true
            $string -match '.*</h1>$' | should be $true
            
        }

        it "Testing content in child element"{
            $string -match "^.*>woop<.*" | should be $true
        }
    }
    
}

Pop-Location