$TestsPath = Split-Path $MyInvocation.MyCommand.Path

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\PSHTML -Force


Describe "Testing ConvertTo-HTMLTable" {


    $Class = "MyClass"
    $Id = "MyID"
    $Style = "Background:green"
    $CustomAtt = @{"MyAttribute1"='MyValue1';"MyAttribute2"="MyValue2"}
    $string = head {"woop"} -Attributes $CustomAtt -Style $Style -Class $class -id $id

    $string = Get-Process | Select-Object -Property Handles,ProcessName -first 2 | ConvertTo-HTMLTable

    if($string -is [array]){
        $string = $String -join ""
    }

    it "Should contain opening and closing <table> tags" {
        $string -match '^<table.*>' | should be $true
        $string -match '.*</table>$' | should be $true

    }

    it "Should contain opening and closing <thead> tags" {
        $string -match '.*<thead.*>' | should be $true
        $string -match '.*</thead>.*' | should be $true

    }

    it "Should contain opening and closing <tr> tags" {
        $string -match '.*<tr.*>' | should be $true
        $string -match '.*</tr>.*' | should be $true

    }


    it "Header should match DisplayName,StartType,Status"{
        $string -match ".*<td>Handles</td><td>ProcessName</td>.*" | should be $true
    }

    it "Should contain opening and closing <td> tags" {
        $string -match '.*<td.*>' | should be $true
        $string -match '.*</td>.*' | should be $true

    }


    #Add test to count td (should be 3)


}

Describe "Testing ConvertTo-HTMLTable Properties Parameter" {
    $string = Get-Process | Select-Object  -first 2 | ConvertTo-HTMLTable -properties  Handles,ProcessName
    if($string -is [array]){
        $string = $String -join ""
    }

    it "The header Names of the Table should be the values passed to the properties parameter" {
    
        $string -match ".*<td>Handles</td><td>ProcessName</td>.*" | should be $true

    }
    
}



Pop-Location
