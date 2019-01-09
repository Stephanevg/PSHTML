$TestsPath = Split-Path $MyInvocation.MyCommand.Path

#$FunctionsPath = join-Path -Path (get-item $TestsPath).Parent -ChildPath "Functions"

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\PSHTML -Force

InModuleScope PSHTML {

Describe "Testing [DatasetLine]"{
    it "[DatasetLine][Constructors][ParameterLess] Should create an instance without throwing"{
        {[DatasetLine]::new()}| should not throw
    }

    it "[DatasetLine][Constructors][Array][String] Should create an instance without throwing"{
        {[DatasetLine]::new(@("2,3,4"),"Plop")} | should not throw
    }

    it "[DatasetLine][Constructors][Array][String] Should have correct values"{
        $d = [DatasetLine]::new(@(2,3),"Plop")
        $d.label | should be "Plop"
        $d.data | should contain 2
        $d.data | should contain 3
    }

    it "[DatasetLine][Methods][AddData][Array] Should not throw "{
        $d = [DatasetLine]::new(@(2,3),"Plop")
        {$d.AddData(@(55,76))} | should not throw

    }

    it "[DatasetLine][Methods][AddData][Array] Should set values "{
        $d = [DatasetLine]::new(@(2,3),"Plop")
        $d.AddData(@(55,76))
        $d.data | should contain 55
        $d.data | should contain 76
    }

    it "[DatasetLine][Methods][SetLabel][String] Should not throw"{
        $d = [DatasetLine]::new(@(2,3),"Plop")
        {$d.SetLabel("Label")} | should not throw
    }

    it "[DatasetLine][Methods][SetLabel][String] Should Set Label"{
        $d = [DatasetLine]::new(@(2,3),"Plop")
        $d.SetLabel("TestLabel")
        $d.label | should be "TestLabel"
    }

}

}