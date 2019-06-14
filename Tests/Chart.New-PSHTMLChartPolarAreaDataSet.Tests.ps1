$TestsPath = Split-Path $MyInvocation.MyCommand.Path

#$FunctionsPath = join-Path -Path (get-item $TestsPath).Parent -ChildPath "Functions"

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\PSHTML -Force

InModuleScope PSHTML {


        Describe "Testing New-PSHTMLChartPolarAreaDataset"{

            it '[New-PSHTMLChartPolarAreaDataset][Parameterless] Should Not throw'{
                {New-PSHTMLChartPolarAreaDataset} | should not throw
            }

            it '[New-PSHTMLChartPolarAreaDataset][ReturnType] Should return an object of type [datasetPolarArea]'{
                $e = New-PSHTMLChartPolarAreaDataset
                $e.GetType().FullName | should be 'datasetPolarArea'
            }

        } -tag "Chart","PolarArea"

}