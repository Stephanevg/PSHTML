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

    $string = Get-Service | Where-Object {$_.Status -eq "running" -and $_.StartType -eq "Automatic"} | Select-Object -Property DisplayName,Status,StartType -first 2 | ConvertTo-HTMLTable

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

    <#

    it "Should contain 3 <tr> tags" {
        $string -match '.*<tr.*>' | should be $true
        $string -match '.*</tr>.*' | should be $true

    }
    #>

    it "Header should match DisplayName,StartType,Status"{
        $string -match ".*<td>DisplayName</td><td>StartType</td><td>Status</td>.*" | should be $true
    }

    it "Should contain opening and closing <td> tags" {
        $string -match '.*<td.*>' | should be $true
        $string -match '.*</td>.*' | should be $true

    }


    #Add test to count td (should be 3)


}



Pop-Location