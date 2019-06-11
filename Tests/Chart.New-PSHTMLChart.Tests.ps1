$TestsPath = Split-Path $MyInvocation.MyCommand.Path

#$FunctionsPath = join-Path -Path (get-item $TestsPath).Parent -ChildPath "Functions"

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\PSHTML -Force

InModuleScope PSHTML {

    Describe "Testing New-PSHTMLChart | General options" {

        it '[New-PSHTMLChart][Parameterless] Should throw' {
            {New-PSHTMLChart} | should throw
        }
    }

    Describe "Testing New-PSHTMLChart -Type Bar" {


        $Labels = @("january", "february")
        $Data = @(3, 5)
        $Title = "Test Title"
        $CanvasID = "TestCanvasID"
        #$bds = 
        <# mock -CommandName New-PSHTMLChartBarDataSet -MockWith {
                New-MockObject -Type "datasetbar"
            } #>
        $bds = New-PSHTMLChartBarDataSet -Data $Data
            
        it '[New-PSHTMLChart][-Type Bar][-DataSet BarDataSet][Label][Title][CanvasId] Should not throw' {
            {New-PSHTMLChart -Type bar -DataSet $bds -Labels $Labels -Title $Title -CanvasID $CanvasID} | should not throw
        }

        it '[New-PSHTMLChart][-Type Bar][-DataSet BarDataSet][Label][Title][CanvasId] Should create ChartJS javascript Code' {
            $Is = New-PSHTMLChart -Type bar -DataSet $bds -Labels $Labels -Title $Title -CanvasID $CanvasID
            #don't touche this part, as the regex is very 'fragile'
<#
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
#>

$Should = @'
var ctx = document.getElementById("TestCanvasID").getContext('2d'); var myChart = new Chart(ctx, {"type":"bar","data":{"labels":["january","february"],"datasets":[{"borderWidth":1,"xAxisID":null,"yAxisID":null,"backgroundColor":null,"borderColor":null,"borderSkipped":null,"hoverBackgroundColor":null,"hoverBorderColor":null,"hoverBorderWidth":0,"data":[3,5],"label":null}]},"options":{"barPercentage":1,"categoryPercentage":1,"responsive":false,"barThickness":null,"maxBarThickness":0,"offsetGridLines":true,"scales":{"yAxes":[{"ticks":{"beginAtZero":true}}],"xAxes":[""]},"title":{"display":true,"text":"Test Title"}}} );
'@

            #$Is | should be $Should
            
            $Is | should be $Should
        }

            


    } -tag "Chart", "Bar"


    Describe "Testing New-PSHTMLChart -Type Pie" {

        $Labels = @("january", "february")
        $Data = @(3, 5)
        $Title = "Test Title"
        $CanvasID = "TestCanvasID"
        #$bds = 
        <# mock -CommandName New-PSHTMLChartBarDataSet -MockWith {
            New-MockObject -Type "datasetbar"
        } #>
        $TestData = New-PSHTMLChartPieDataSet -Data $Data
        
        it '[New-PSHTMLChart][-Type Pie][-DataSet PieDataSet][Label][Title][CanvasId] Should not throw' {
            {New-PSHTMLChart -Type Pie -DataSet $TestData -Labels $Labels -Title $Title -CanvasID $CanvasID} | should not throw
        }

        it '[New-PSHTMLChart][-Type Bar][-DataSet PieDataSet][Label][Title][CanvasId] Should create ChartJS javascript Code' {
            $IsTemp = New-PSHTMLChart -Type Pie -DataSet $TestData -Labels $Labels -Title $Title -CanvasID $CanvasID
            #$Is = $IsTemp.Trim()
            <#
            $Should =@'
var ctx = document.getElementById("TestCanvasID").getContext('2d');
var myChart = new Chart(ctx, {
    "type":  "pie",
    "data":  {
                 "labels":  [
                                "january",
                                "february"
                            ],
                 "datasets":  [
                                  {
                                      "borderColor":  "white",
                                      "borderWidth":  1,
                                      "backgroundColor":  null,
                                      "hoverBackgroundColor":  [
                                                                   null
                                                               ],
                                      "HoverBorderColor":  null,
                                      "HoverBorderWidth":  0,
                                      "data":  [
                                                   3,
                                                   5
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

#>
$Should = @'
var ctx = document.getElementById("TestCanvasID").getContext('2d'); var myChart = new Chart(ctx, {"type":"pie","data":{"labels":["january","february"],"datasets":[{"borderColor":"white","borderWidth":1,"backgroundColor":null,"hoverBackgroundColor":[null],"HoverBorderColor":null,"HoverBorderWidth":0,"data":[3,5],"label":null}]},"options":{"barPercentage":1,"categoryPercentage":1,"responsive":false,"barThickness":null,"maxBarThickness":0,"offsetGridLines":true,"scales":{"yAxes":[{"ticks":{"beginAtZero":true}}],"xAxes":[""]},"title":{"display":true,"text":"Test Title"}}} );
'@

            $IsTemp | should be $Should
        }
    } -Tag "Chart","Pie"

    Describe "Testing New-PSHTMLChart -Type Doughnut" {


        $Title = "Test Title"
        $CanvasID = "TestCanvasID"
        $Data1 = @(34,7,11,19)

        $Labels = @("Closed","Unresolved","Pending","Open")
        $colors = @("LightGreen","Red","LightBlue","LightYellow")
        #$bds = 
        <# mock -CommandName New-PSHTMLChartBarDataSet -MockWith {
            New-MockObject -Type "datasetbar"
        } #>
        
        $TestData = New-PSHTMLChartDoughnutDataSet -Data $data1 -label "March" -backgroundcolor $colors

        it '[New-PSHTMLChart][-Type Doughnut][-DataSet PieDataSet][Label][Title][CanvasId] Should not throw' {
            {New-PSHTMLChart -Type Doughnut -DataSet $TestData -Labels $Labels -Title $Title -CanvasID $CanvasID} | should not throw
        }

        it '[New-PSHTMLChart][-Type Doughnut][-DataSet PieDataSet][Label][Title][CanvasId] Should create ChartJS javascript Code' {
            $Is = New-PSHTMLChart -Type Doughnut -DataSet $TestData -Labels $Labels -Title $Title -CanvasID $CanvasID

            #$Is = $Is.Trim()
            <#
$Should =@'
var ctx = document.getElementById("TestCanvasID").getContext('2d');
var myChart = new Chart(ctx, {
    "type":  "doughnut",
    "data":  {
                 "labels":  [
                                "Closed",
                                "Unresolved",
                                "Pending",
                                "Open"
                            ],
                 "datasets":  [
                                  {
                                      "borderColor":  "white",
                                      "borderWidth":  1,
                                      "backgroundColor":  [
                                                              "LightGreen",
                                                              "Red",
                                                              "LightBlue",
                                                              "LightYellow"
                                                          ],
                                      "hoverBackgroundColor":  [
                                                                   "LightGreen",
                                                                   "Red",
                                                                   "LightBlue",
                                                                   "LightYellow"
                                                               ],
                                      "HoverBorderColor":  null,
                                      "HoverBorderWidth":  0,
                                      "data":  [
                                                   34,
                                                   7,
                                                   11,
                                                   19
                                               ],
                                      "label":  "March"
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
#>
$Should = @'
var ctx = document.getElementById("TestCanvasID").getContext('2d'); var myChart = new Chart(ctx, {"type":"doughnut","data":{"labels":["Closed","Unresolved","Pending","Open"],"datasets":[{"borderColor":"white","borderWidth":1,"backgroundColor":["LightGreen","Red","LightBlue","LightYellow"],"hoverBackgroundColor":["LightGreen","Red","LightBlue","LightYellow"],"HoverBorderColor":null,"HoverBorderWidth":0,"data":[34,7,11,19],"label":"March"}]},"options":{"barPercentage":1,"categoryPercentage":1,"responsive":false,"barThickness":null,"maxBarThickness":0,"offsetGridLines":true,"scales":{"yAxes":[{"ticks":{"beginAtZero":true}}],"xAxes":[""]},"title":{"display":true,"text":"Test Title"}}} );
'@
            $Is | should be $Should
        }
    } -Tag "Chart","Doughnut"
    
    Describe "Testing New-PSHTMLChart -Type Line" {


        $Labels = @("january", "february")
        $Data = @(3, 5)
        $Title = "Test Title"
        $CanvasID = "TestCanvasID"
        #$bds = 
        <# mock -CommandName New-PSHTMLChartBarDataSet -MockWith {
                New-MockObject -Type "datasetbar"
            } #>
        $bds = New-PSHTMLChartLineDataSet -Data $Data
            
        it '[New-PSHTMLChart][-Type Line][-DataSet LineDataSet][Label][Title][CanvasId] Should not throw' {
            {New-PSHTMLChart -Type Line -DataSet $bds -Labels $Labels -Title $Title -CanvasID $CanvasID} | should not throw
        }

        it '[New-PSHTMLChart][-Type Line][-DataSet LineDataSet][Label][Title][CanvasId] Should create ChartJS javascript Code' {
            $Is = New-PSHTMLChart -Type Line -DataSet $bds -Labels $Labels -Title $Title -CanvasID $CanvasID
            #don't touche this part, as the regex is very 'fragile'
<#
$Should = @'
var ctx = document.getElementById("TestCanvasID").getContext('2d');
var myChart = new Chart(ctx, {
    "type":  "line",
    "data":  {
                 "labels":  [
                                "january",
                                "february"
                            ],
                 "datasets":  [
                                  {
                                      "borderWidth":  1,
                                      "borderDash":  [
                                                         0
                                                     ],
                                      "borderDashOffSet":  0,
                                      "cubicInterpolationMode":  "default",
                                      "fill":  false,
                                      "lineTension":  0.5,
                                      "pointBackgroundColor":  "rgb(255,255,255)",
                                      "pointBorderColor":  "rgb(0,0,0)",
                                      "pointBorderWidth":  [
                                                               1
                                                           ],
                                      "pointRadius":  4,
                                      "pointStyle":  "circle",
                                      "showLine":  true,
                                      "backgroundColor":  null,
                                      "borderColor":  null,
                                      "borderCapStyle":  null,
                                      "borderJoinStyle":  null,
                                      "pointRotation":  null,
                                      "pointHitRadius":  null,
                                      "PointHoverBackgroundColor":  null,
                                      "pointHoverBorderColor":  null,
                                      "pointHoverBorderWidth":  0,
                                      "pointHoverRadius":  0,
                                      "spanGaps":  false,
                                      "data":  [

                                               ],
                                      "label":  null
                                  }
                              ]
             },
    "options":  {
                    "showLines":  true,
                    "spanGaps":  false,
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
#>

        $Should = @'
var ctx = document.getElementById("TestCanvasID").getContext('2d'); var myChart = new Chart(ctx, {"type":"line","data":{"labels":["january","february"],"datasets":[{"borderWidth":1,"borderDash":[0],"borderDashOffSet":0,"cubicInterpolationMode":"default","fill":false,"lineTension":0.5,"pointBackgroundColor":"rgb(255,255,255)","pointBorderColor":"rgb(0,0,0)","pointBorderWidth":[1],"pointRadius":4,"pointStyle":"circle","showLine":true,"backgroundColor":null,"borderColor":null,"borderCapStyle":null,"borderJoinStyle":null,"pointRotation":null,"pointHitRadius":null,"PointHoverBackgroundColor":null,"pointHoverBorderColor":null,"pointHoverBorderWidth":0,"pointHoverRadius":0,"spanGaps":false,"data":[3,5],"label":null}]},"options":{"showLines":true,"spanGaps":false,"barPercentage":1,"categoryPercentage":1,"responsive":false,"barThickness":null,"maxBarThickness":0,"offsetGridLines":true,"scales":{"yAxes":[{"ticks":{"beginAtZero":true}}],"xAxes":[""]},"title":{"display":true,"text":"Test Title"}}} );
'@

        $Is | should be $Should
        }

            


    } -tag "Chart", "Line"
}