$TestsPath = Split-Path $MyInvocation.MyCommand.Path

#$FunctionsPath = join-Path -Path (get-item $TestsPath).Parent -ChildPath "Functions"

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\pshtml.psd1 -Force

Context "Testing PSHTML"{
    Describe "Testing meta" {


        $Class = "MyClass"
        $Id = "MyID"
        $Style = "Background:green"
        $CustomAtt = @{"MyAttribute1"='MyValue1';"MyAttribute2"="MyValue2"}
        $string = meta -Attributes $CustomAtt -Style $Style -Class $class -id $id


        if($string -is [array]){
            $string = $String -join ""
        }

        it "Should contain opening tag" {
            $string -match '^<meta.*>' | should be $true
            #$string -match '.*</meta>$' | should be $true

        }

        $Primary = $null
        $Primary = meta -charset "Mycharset"

        it "Testing Primary parameters: Charset"{
            $Primary -match '^<meta.*charset="Mycharset".*>' | should be $true
        }

        $Primary = $null
        $Primary = meta -httpequiv refresh

        it "Testing Primary parameters: http-equiv"{
            $Primary -match '^<meta.*http-equiv="refresh".*>' | should be $true
        }

        $Primary = $null
        $Primary = meta -Name "author" -content "stephane"

        it "Testing Primary parameters: Author"{
            $Primary -match '^<meta.*name="author".*>' | should be $true
            $Primary -match '^<meta.*content="stephane".*>' | should be $true
        }


        it "Testing common parameters: Class"{
            $string -match '^<meta.*class="myclass".*>' | should be $true
        }
        it "Testing common parameters: ID"{
            $string -match '^<meta.*id="myid".*>' | should be $true
        }
        it "Testing common parameters: Style"{
            $string -match '^<meta.*style=".+".*>' | should be $true
        }

        it "Testing Attributes parameters"{

            foreach($at in $CustomAtt.Keys){
                $val = $null
                $val = $CustomAtt[$at]
                $string -match "^<meta.*$at=`"$val`".*>" | should be $true
            }


        }


    }

}

Pop-Location