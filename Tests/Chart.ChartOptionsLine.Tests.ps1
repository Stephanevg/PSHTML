$TestsPath = Split-Path $MyInvocation.MyCommand.Path

#$FunctionsPath = join-Path -Path (get-item $TestsPath).Parent -ChildPath "Functions"

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\PSHTML -Force

InModuleScope PSHTML {


        Describe "LineChartOptions"{
            it "[Constructor][Parameterless] Should not throw"{
                {[LineChartOptions]::New()} | should not throw
            }

            it "[Constructor][Parameterless] Should have default values"{
                $co = [LineChartOptions]::New()
                $co.showLines | should be $true
                $co.spanGaps | should be $false
            }
        } -tag "Chart","Line"

    
}