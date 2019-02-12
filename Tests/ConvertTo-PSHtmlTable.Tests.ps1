$TestsPath = Split-Path $MyInvocation.MyCommand.Path

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\PSHTML -Force


Describe "Testing ConverTo-PSHTMLTable" {


    $Class = "MyClass"
    $Id = "MyID"
    $Style = "Background:green"
    $CustomAtt = @{"MyAttribute1"='MyValue1';"MyAttribute2"="MyValue2"}
    $string = head {"woop"} -Attributes $CustomAtt -Style $Style -Class $class -id $id

    $Obb = Get-Process | Select-Object -Property Handles,ProcessName -first 2 
    $string = ConvertTo-PSHTMLTable -Object $Obb

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


    it "Header should match Handles and ProcessName"{
        $string -match ".*<td.*>Handles</td><td.*>ProcessName</td>.*" | should be $true
    }

    it "Should contain opening and closing <td> tags" {
        $string -match '.*<td.*>' | should be $true
        $string -match '.*</td>.*' | should be $true

    }


    #Add test to count td (should be 3)


}

Describe "Testing ConverTo-PSHTMLTable Properties Parameter" {
    $Obb = Get-Process | Select-Object -Property Handles,ProcessName -first 2 
    $string = ConvertTo-PSHTMLTable -Object $Obb
    if($string -is [array]){
        $string = $String -join ""
    }

    it "The header Names of the Table should be the values passed to the properties parameter" {
    
        $string -match ".*<td.*>Handles</td><td.*>ProcessName</td>.*" | should be $true

    }
    
}



Pop-Location
