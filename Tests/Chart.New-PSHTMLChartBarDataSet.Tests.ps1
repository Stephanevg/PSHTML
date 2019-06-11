$TestsPath = Split-Path $MyInvocation.MyCommand.Path

#$FunctionsPath = join-Path -Path (get-item $TestsPath).Parent -ChildPath "Functions"

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\PSHTML -Force

InModuleScope PSHTML {


        Describe "Testing New-PSHTMLChartBarData"{

            it '[New-PSHTMLChartBarDataSet][Parameterless] Should Not throw'{
                {New-PSHTMLChartBarDataSet} | should not throw
            }

            it '[New-PSHTMLChartBarDataSet][ReturnType] Should return an object of type [datasetBar]'{
                $e = New-PSHTMLChartBarDataSet
                $e.GetType().FullName | should be 'datasetbar'
            }

        } -tag "Chart","Bar"

}