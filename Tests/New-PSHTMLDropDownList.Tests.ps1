$TestsPath = Split-Path $MyInvocation.MyCommand.Path

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\PSHTML -Force


Context "Testing New-PSHTMLDropDownList" {
    $Obb = Get-Process | Select-Object -Property Handles,ProcessName -first 2 
    $string = New-PSHTMLDropDownList -Items $Obb -Property ProcessName

    Describe "Testing passing object to New-PSHTMLDropDownList" {
        

        it "Should contain opening and closing <select> tags" {
            $string -match '^<select.*>' | should be $true
            $string -match '.*</select>$' | should be $true
        }

        it "Should contain opening and closing <option> tags" {
            $string -match '.*<option.*>' | should be $true
            $string -match '.*</option>.*' | should be $true
        }

        it "Option value should match ProcessName"{
            $string -match '.*<option value="ProcessName".*>.*' | should be $true
        }

        It "Should Not throw if property is correct" {
            {New-PSHTMLDropDownList -Items $Obb -Property ProcessName} | should Not throw
        }

        It "Should throw if property is not correct" {
            {New-PSHTMLDropDownList -Items $Obb -Property plop} | should throw
        }

    }

    Describe "Testing Parameter Sets: Items" {
        It "New-PSHTMLDropDownList Should Throw if Items ParameterSet is used with Content parameter" {
            {New-PSHTMLDropDownList -Items $Obb -Property ProcessName -Content "toto"} | Should Throw
        }

        It "New-PSHTMLDropDownList Should Throw if Items ParameterSet is used with Value parameter" {
            {New-PSHTMLDropDownList -Items $Obb -Property ProcessName -Value "toto"} | Should Throw
        }
    }

    Describe "Testing Parameter Sets: Classic" {
        It "New-PSHTMLDropDownList Should Throw if Classic ParameterSet is used with Items parameter" {
            {New-PSHTMLDropDownList -Value "toto" -Content "toto" -Items $obb} | Should Throw
        }

        It "New-PSHTMLDropDownList Should Throw if Items ParameterSet is used with Property parameter" {
            {New-PSHTMLDropDownList -Value "toto" -Content "toto" -property Name} | Should Throw
        }
    }
}

Context "Testing New-PSHTMLDropDownListItem" {
    $Obb = Get-Process | Select-Object -Property Handles,ProcessName -first 2 
    $string = New-PSHTMLDropDownListItem -Items $Obb -Property ProcessName

    Describe "Testing passing object to New-PSHTMLDropDownListItem" {
        

        it "Should contain opening and closing <option> tags" {
            $string -match '^<option.*>' | should be $true
            $string -match '.*</option>$' | should be $true
        }

        it "Option value should match ProcessName"{
            $string -match '<option value="ProcessName".*>.*' | should be $true
        }

        It "Should Not throw if property is correct" {
            {New-PSHTMLDropDownListItem -Items $Obb -Property ProcessName} | should Not throw
        }

        It "Should throw if property is not correct" {
            {New-PSHTMLDropDownListItem -Items $Obb -Property plop} | should throw
        }

    }

    Describe "Testing Parameter Sets: Items" {
        It "New-PSHTMLDropDownListItem Should Throw if Items ParameterSet is used with Content parameter" {
            {New-PSHTMLDropDownListItem -Items $Obb -Property ProcessName -Content "toto"} | Should Throw
        }

        It "New-PSHTMLDropDownList Should Throw if Items ParameterSet is used with Value parameter" {
            {New-PSHTMLDropDownListItem -Items $Obb -Property ProcessName -Value "toto"} | Should Throw
        }
    }

    Describe "Testing Parameter Sets: Classic" {
        It "New-PSHTMLDropDownListItem Should Throw if Classic ParameterSet is used with Items parameter" {
            {New-PSHTMLDropDownListItem -Value "toto" -Content "toto" -Items $obb} | Should Throw
        }

        It "New-PSHTMLDropDownListItem Should Throw if Items ParameterSet is used with Property parameter" {
            {New-PSHTMLDropDownListItem -Value "toto" -Content "toto" -property Name} | Should Throw
        }
    }
}

Pop-Location
