$TestsPath = Split-Path $MyInvocation.MyCommand.Path

#$FunctionsPath = join-Path -Path (get-item $TestsPath).Parent -ChildPath "Functions"

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\PSHTML -Force

InModuleScope PSHTML {


        Describe "Testing New-PSHTMLChartLineDataSet"{

            it '[New-PSHTMLChartLineDataSet][Parameterless] Should Not throw'{
                {New-PSHTMLChartLineDataSet} | should not throw
            }

            it '[New-PSHTMLChartLineDataSet][ReturnType] Should return an object of type [datasetLine]'{
                $e = New-PSHTMLChartLineDataSet
                $e.GetType().FullName | should be 'datasetLine'
            }

        } -tag "Chart","Line"

}