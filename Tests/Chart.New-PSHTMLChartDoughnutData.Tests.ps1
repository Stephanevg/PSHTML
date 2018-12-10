$TestsPath = Split-Path $MyInvocation.MyCommand.Path

#$FunctionsPath = join-Path -Path (get-item $TestsPath).Parent -ChildPath "Functions"

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\PSHTML -Force

InModuleScope PSHTML {

    Context "Testing Charts"{
 
        Describe "Testing New-PSHTMLChartDoughnutData"{

            it '[New-PSHTMLChartDoughnutData][Parameterless] Should Not throw'{
                {New-PSHTMLChartDoughnutDataSet} | should not throw
            }

            it '[New-PSHTMLChartDoughnutData][ReturnType] Should return an object of type [datasetDoughnut]'{
                $e = New-PSHTMLChartDoughnutDataSet
                $e.GetType().FullName | should be 'datasetDoughnut'
            }

        } -tag "Chart"

    }
}