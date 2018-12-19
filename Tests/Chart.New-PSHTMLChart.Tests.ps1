$TestsPath = Split-Path $MyInvocation.MyCommand.Path

#$FunctionsPath = join-Path -Path (get-item $TestsPath).Parent -ChildPath "Functions"

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\PSHTML -Force

InModuleScope PSHTML {

        Describe "Testing New-PSHTMLChart"{

            it '[New-PSHTMLChart][Parameterless] Should throw' {
                {New-PSHTMLChart} | should throw
            }

            $Labels = @("january","february")
            $Data = @(3,5)
            $Title = "Test Title"
            $CanvasID = "TestCanvasID"
            #$bds = 
            <# mock -CommandName New-PSHTMLChartBarDataSet -MockWith {
                New-MockObject -Type "datasetbar"
            } #>
            $bds = New-PSHTMLChartBarDataSet
            
            it '[New-PSHTMLChart][-Type Bar][-DataSet BarDataSet][Label][Title][CanvasId] Should not throw' {
                {New-PSHTMLChart -Type bar -DataSet $bds -Labels $Labels -Title $Title -CanvasID $CanvasID} | should not throw
            }

            it '[New-PSHTMLChart][-Type Bar][-DataSet BarDataSet][Label][Title][CanvasId] Should create ChartJS javascript Code' {
                $Is = New-PSHTMLChart -Type bar -DataSet $bds -Labels $Labels -Title $Title -CanvasID $CanvasID
#don't touche this part, as the regex is very 'fragile'
$Should = @'
var ctx = document.getElementById("TestCanvasID").getContext('2d');
var myChart = new Chart(ctx, {
    "type":  "bar",
    "data":  {
                 "labels":  [
                                "january",
                                "february"
                            ],
                 "datasets":  [
                                  {
                                      "borderWidth":  1,
                                      "xAxisID":  null,
                                      "yAxisID":  null,
                                      "backgroundColor":  null,
                                      "borderColor":  null,
                                      "borderSkipped":  null,
                                      "hoverBackgroundColor":  null,
                                      "hoverBorderColor":  null,
                                      "hoverBorderWidth":  0,
                                      "data":  [

                                               ],
                                      "label":  null
                                  }
                              ]
             },
    "options":  {
                    "barPercentage":  1,
                    "categoryPercentage":  1,
                    "responsive":  false,
                    "barThickness":  null,
                    "maxBarThickness":  0,
                    "offsetGridLines":  true,
                    "scales":  {
                                   "yAxes":  [
                                                 {
                                                     "ticks":  {
                                                                   "beginAtZero":  true
                                                               }
                                                 }
                                             ],
                                   "xAxes":  [

                                             ]
                               },
                    "title":  {
                                  "display":  true,
                                  "text":  "Test Title"
                              }
                }
}
);

'@
                $Is | should be $Should
            }

            


        } -tag "Chart"

}