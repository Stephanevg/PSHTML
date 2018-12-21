$TestsPath = Split-Path $MyInvocation.MyCommand.Path

#$FunctionsPath = join-Path -Path (get-item $TestsPath).Parent -ChildPath "Functions"

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\PSHTML -Force

InModuleScope PSHTML {

        Describe "Testing New-PSHTMLChartPieDataSet"{

            it '[New-PSHTMLChartPieData][Parameterless] Should Not throw'{
                {New-PSHTMLChartPieDataSet} | should not throw
            }

            it '[New-PSHTMLChartPieData][ReturnType] Should return an object of type [datasetPie]'{
                $e = New-PSHTMLChartPieDataSet
                $e.GetType().FullName | should be 'datasetPie'
            }

        } -tag "Chart","Pie"

    
}