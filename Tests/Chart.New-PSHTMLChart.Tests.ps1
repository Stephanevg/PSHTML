$TestsPath = Split-Path $MyInvocation.MyCommand.Path

#$FunctionsPath = join-Path -Path (get-item $TestsPath).Parent -ChildPath "Functions"

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

#import-module .\PSHTML -Force

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
        $bds = New-PSHTMLChartBarDataSet -Data $Data
            
        it '[New-PSHTMLChart][-Type Bar][-DataSet BarDataSet][Label][Title][CanvasId] Should not throw' {
            {New-PSHTMLChart -Type bar -DataSet $bds -Labels $Labels -Title $Title -CanvasID $CanvasID} | should not throw
        }

        it '[New-PSHTMLChart][-Type Bar][-DataSet BarDataSet][Label][Title][CanvasId] Should create ChartJS javascript Code' {
            $Is = New-PSHTMLChart -Type bar -DataSet $bds -Labels $Labels -Title $Title -CanvasID $CanvasID
            #don't touche this part, as the regex is very 'fragile'

            $Should = @'
var ctx = document.getElementById("TestCanvasID").getContext('2d'); var myChart = new Chart(ctx, {"type":"bar","data":{"labels":["january","february"],"datasets":[{"borderWidth":1,"xAxisID":null,"yAxisID":null,"backgroundColor":null,"borderColor":"","borderSkipped":null,"hoverBackgroundColor":null,"hoverBorderColor":null,"hoverBorderWidth":0,"data":[3,5],"label":null}]},"options":{"barPercentage":1,"barThickness":null,"maxBarThickness":0,"categoryPercentage":1,"responsive":false,"offsetGridLines":true,"scales":{"yAxes":[{"ticks":{"beginAtZero":true}}],"xAxes":[""]},"title":{"display":true,"text":"Test Title"},"animation":{"onComplete":null}}} );
'@

            $Is | should be $Should
        }

    } -tag "Chart", "Bar"

    Describe "Testing New-PSHTMLChart -Type horizontalBar" {

        $Labels = @("january", "february")
        $Data = @(3, 5)
        $Title = "Test Title"
        $CanvasID = "TestCanvasID"

        $bds = New-PSHTMLChartBarDataSet -Data $Data
            
        it '[New-PSHTMLChart][-Type horizontalBar][-DataSet BarDataSet][Label][Title][CanvasId] Should not throw' {
            {New-PSHTMLChart -Type horizontalBar -DataSet $bds -Labels $Labels -Title $Title -CanvasID $CanvasID} | should not throw
        }

        it '[New-PSHTMLChart][-Type horizontalBar][-DataSet BarDataSet][Label][Title][CanvasId] Should create ChartJS javascript Code' {
            $Is = New-PSHTMLChart -Type horizontalBar -DataSet $bds -Labels $Labels -Title $Title -CanvasID $CanvasID

            $Should = @'
var ctx = document.getElementById("TestCanvasID").getContext('2d'); var myChart = new Chart(ctx, {"type":"horizontalBar","data":{"labels":["january","february"],"datasets":[{"borderWidth":1,"xAxisID":null,"yAxisID":null,"backgroundColor":null,"borderColor":"","borderSkipped":null,"hoverBackgroundColor":null,"hoverBorderColor":null,"hoverBorderWidth":0,"data":[3,5],"label":null}]},"options":{"categoryPercentage":1,"responsive":false,"offsetGridLines":true,"scales":{"yAxes":[{"ticks":{"beginAtZero":true}}],"xAxes":[""]},"title":{"display":true,"text":"Test Title"},"animation":{"onComplete":null}}} );
'@
                        
            $Is | should be $Should
        }
    } -tag "Chart", "horizontalBar"

    Describe "Testing New-PSHTMLChart -Type Radar" {
        $Labels = @("january", "february")
        $Title = "Test Title"
        $CanvasID = "TestCanvasID"
        $Data1 = @(17,25,18,17,22,30,35,44,4,1,6,12)
        
        #Hack to load the [System.Drawing.Color] ahead of time needed for Get-PSHTMLColor
        #read more here -> https://github.com/PowerShell/vscode-powershell/issues/219
        #Microsoft.PowerShell.Management\Get-Clipboard | Out-Null
        Add-Type -Assembly System.Drawing
        $bds = New-PSHTMLChartRadarDataSet -Data $data1 -label "2018" -borderColor (get-pshtmlColor -color blue) -backgroundColor "transparent" -hoverBackgroundColor (get-pshtmlColor -color green) -PointRadius 2 
            
        it '[New-PSHTMLChart][-Type Radar][-DataSet BarDataSet][Label][Title][CanvasId] Should not throw' {
            {New-PSHTMLChart -Type Radar -DataSet $bds -Labels $Labels -Title $Title -CanvasID $CanvasID} | should not throw
        }

        it '[New-PSHTMLChart][-Type Radar][-DataSet BarDataSet][Label][Title][CanvasId] Should create ChartJS javascript Code' {
            $Is = New-PSHTMLChart -Type radar -DataSet $bds -Labels $Labels -Title $Title -CanvasID $CanvasID

            If($PSVersionTable.PsEdition -eq 'Core'){
                $Should = @'
var ctx = document.getElementById("TestCanvasID").getContext('2d'); var myChart = new Chart(ctx, {"type":"radar","data":{"labels":["january","february"],"datasets":[{"borderWidth":1,"pointBackgroundColor":"rgba(0, 0, 0, 0.1)","pointBorderColor":"rgba(0, 0, 0, 0.1)","pointBorderWidth":[1],"pointRadius":2.0,"pointStyle":"circle","xAxisID":null,"yAxisID":null,"backgroundColor":"transparent","borderColor":"rgb(0,0,255)","borderSkipped":null,"hoverBackgroundColor":"rgb(0,128,0)","hoverBorderColor":null,"hoverBorderWidth":0,"pointRotation":null,"pointHitRadius":0.0,"PointHoverBackgroundColor":null,"pointHoverBorderColor":null,"pointHoverBorderWidth":0,"pointHoverRadius":0.0,"data":[17,25,18,17,22,30,35,44,4,1,6,12],"label":["2018"]}]},"options":{"scales":null,"categoryPercentage":1,"responsive":false,"offsetGridLines":true,"title":{"display":true,"text":"Test Title"},"animation":{"onComplete":null}}} );
'@
            }
            else {
                $Should = @'
var ctx = document.getElementById("TestCanvasID").getContext('2d'); var myChart = new Chart(ctx, {"type":"radar","data":{"labels":["january","february"],"datasets":[{"borderWidth":1,"pointBackgroundColor":"rgba(0, 0, 0, 0.1)","pointBorderColor":"rgba(0, 0, 0, 0.1)","pointBorderWidth":[1],"pointRadius":2,"pointStyle":"circle","xAxisID":null,"yAxisID":null,"backgroundColor":"transparent","borderColor":"rgb(0,0,255)","borderSkipped":null,"hoverBackgroundColor":"rgb(0,128,0)","hoverBorderColor":null,"hoverBorderWidth":0,"pointRotation":null,"pointHitRadius":0,"PointHoverBackgroundColor":null,"pointHoverBorderColor":null,"pointHoverBorderWidth":0,"pointHoverRadius":0,"data":[17,25,18,17,22,30,35,44,4,1,6,12],"label":["2018"]}]},"options":{"scales":null,"categoryPercentage":1,"responsive":false,"offsetGridLines":true,"title":{"display":true,"text":"Test Title"},"animation":{"onComplete":null}}} );
'@
            }

            $Is | should be $Should
        }
            


    } -tag "Chart", "Radar"

    Describe "Testing New-PSHTMLChart -Type polarArea" {


        $Labels = @('red', 'green', 'yellow', 'grey', 'blue')
        $Data = @(3, 5,7,2,9)
        $Title = "Test Title"
        $CanvasID = "TestCanvasID"
        $BackgroundColor = @('red', 'green', 'yellow', 'grey', 'blue')

        it '[New-PSHTMLChartPolarAreaDataSet][-Data $Data][-BackgroundColor $BackgroundColor][-label $Labels] Should not throw' {
            { New-PSHTMLChartPolarAreaDataSet -Data $Data -BackgroundColor $BackgroundColor -label $Labels } | should not throw
        }
        $bds = New-PSHTMLChartPolarAreaDataSet -Data $Data -BackgroundColor $BackgroundColor -label $Labels

        it '[New-PSHTMLChart][-Type polarArea][-DataSet BarDataSet][Label][Title][CanvasId] Should not throw' {
            {New-PSHTMLChart -Type polarArea -DataSet $bds -Labels $Labels -Title $Title -CanvasID $CanvasID} | should not throw
        }

        it '[New-PSHTMLChart][-Type polarArea][-DataSet BarDataSet][Label][Title][CanvasId] Should create ChartJS javascript Code' {
            $Is = New-PSHTMLChart -Type polarArea -DataSet $bds -Labels $Labels -Title $Title -CanvasID $CanvasID

            $Should = @'
var ctx = document.getElementById("TestCanvasID").getContext('2d'); var myChart = new Chart(ctx, {"type":"polarArea","data":{"labels":["red","green","yellow","grey","blue"],"datasets":[{"borderWidth":1,"backgroundColor":["red","green","yellow","grey","blue"],"borderColor":[""],"borderSkipped":null,"hoverBackgroundColor":[""],"hoverBorderColor":[""],"hoverBorderWidth":0,"data":[3,5,7,2,9],"label":["red","green","yellow","grey","blue"]}]},"options":{"scales":null,"categoryPercentage":1,"responsive":false,"offsetGridLines":true,"title":{"display":true,"text":"Test Title"},"animation":{"onComplete":null}}} );
'@
            
            $Is | should be $Should
        }
            


    } -tag "Chart", "polarArea"


    Describe "Testing New-PSHTMLChart -Type Pie" {

        $Labels = @("january", "february")
        $Data = @(3, 5)
        $Title = "Test Title"
        $CanvasID = "TestCanvasID"

        $TestData = New-PSHTMLChartPieDataSet -Data $Data
        
        it '[New-PSHTMLChart][-Type Pie][-DataSet PieDataSet][Label][Title][CanvasId] Should not throw' {
            {New-PSHTMLChart -Type Pie -DataSet $TestData -Labels $Labels -Title $Title -CanvasID $CanvasID} | should not throw
        }

        it '[New-PSHTMLChart][-Type Bar][-DataSet PieDataSet][Label][Title][CanvasId] Should create ChartJS javascript Code' {
            $Is = New-PSHTMLChart -Type Pie -DataSet $TestData -Labels $Labels -Title $Title -CanvasID $CanvasID

            $Should = @'
var ctx = document.getElementById("TestCanvasID").getContext('2d'); var myChart = new Chart(ctx, {"type":"pie","data":{"labels":["january","february"],"datasets":[{"borderColor":"white","borderWidth":1,"backgroundColor":null,"hoverBackgroundColor":[null],"HoverBorderColor":null,"HoverBorderWidth":0,"data":[3,5],"label":null}]},"options":{"categoryPercentage":1,"responsive":false,"offsetGridLines":true,"scales":{"yAxes":[{"ticks":{"beginAtZero":true}}],"xAxes":[""]},"title":{"display":true,"text":"Test Title"},"animation":{"onComplete":null}}} );
'@

            $Is | should be $Should
        }
    } -Tag "Chart","Pie"

    Describe "Testing New-PSHTMLChart -Type Doughnut" {
        $Title = "Test Title"
        $CanvasID = "TestCanvasID"
        $Data1 = @(34,7,11,19)

        $Labels = @("Closed","Unresolved","Pending","Open")
        $colors = @("LightGreen","Red","LightBlue","LightYellow")
        
        $TestData = New-PSHTMLChartDoughnutDataSet -Data $data1 -label "March" -backgroundcolor $colors

        it '[New-PSHTMLChart][-Type Doughnut][-DataSet PieDataSet][Label][Title][CanvasId] Should not throw' {
            {New-PSHTMLChart -Type Doughnut -DataSet $TestData -Labels $Labels -Title $Title -CanvasID $CanvasID} | should not throw
        }

        it '[New-PSHTMLChart][-Type Doughnut][-DataSet PieDataSet][Label][Title][CanvasId] Should create ChartJS javascript Code' {
            $Is = New-PSHTMLChart -Type Doughnut -DataSet $TestData -Labels $Labels -Title $Title -CanvasID $CanvasID

            $Should = @'
var ctx = document.getElementById("TestCanvasID").getContext('2d'); var myChart = new Chart(ctx, {"type":"doughnut","data":{"labels":["Closed","Unresolved","Pending","Open"],"datasets":[{"borderColor":"white","borderWidth":1,"backgroundColor":["LightGreen","Red","LightBlue","LightYellow"],"hoverBackgroundColor":["LightGreen","Red","LightBlue","LightYellow"],"HoverBorderColor":null,"HoverBorderWidth":0,"data":[34,7,11,19],"label":["March"]}]},"options":{"categoryPercentage":1,"responsive":false,"offsetGridLines":true,"scales":{"yAxes":[{"ticks":{"beginAtZero":true}}],"xAxes":[""]},"title":{"display":true,"text":"Test Title"},"animation":{"onComplete":null}}} );
'@
            $Is | should be $Should
        }
    } -Tag "Chart","Doughnut"
    
    Describe "Testing New-PSHTMLChart -Type Line" {
        $Labels = @("january", "february")
        $Data = @(3, 5)
        $Data2 = @(12, 15)
        $Title = "Test Title"
        $CanvasID = "TestCanvasID"
        $bds = New-PSHTMLChartLineDataSet -Data $Data
        $bds2 = New-PSHTMLChartLineDataSet -Data $Data2
            
        it '[New-PSHTMLChart][-Type Line][-DataSet LineDataSet][Label][Title][CanvasId] Should not throw' {
            {New-PSHTMLChart -Type Line -DataSet $bds -Labels $Labels -Title $Title -CanvasID $CanvasID} | should not throw
        }

        it '[New-PSHTMLChart][-Type Line][-DataSet LineDataSet][Label][Title][CanvasId] Should create ChartJS javascript Code' {
            $Is = New-PSHTMLChart -Type Line -DataSet $bds -Labels $Labels -Title $Title -CanvasID $CanvasID

            If($PSVersionTable.PsEdition -eq 'Core'){
                $Should = @'
var ctx = document.getElementById("TestCanvasID").getContext('2d'); var myChart = new Chart(ctx, {"type":"line","data":{"labels":["january","february"],"datasets":[{"borderWidth":1,"borderDash":[0],"borderDashOffSet":0,"cubicInterpolationMode":"default","fill":false,"lineTension":0.5,"pointBackgroundColor":"rgb(255,255,255)","pointBorderColor":"rgb(0,0,0)","pointBorderWidth":[1],"pointRadius":4.0,"pointStyle":"circle","showLine":true,"backgroundColor":null,"borderColor":null,"borderCapStyle":null,"borderJoinStyle":null,"pointRotation":null,"pointHitRadius":0.0,"PointHoverBackgroundColor":null,"pointHoverBorderColor":null,"pointHoverBorderWidth":0,"pointHoverRadius":0.0,"spanGaps":false,"data":[3,5],"label":null}]},"options":{"showLines":true,"spanGaps":false,"categoryPercentage":1,"responsive":false,"offsetGridLines":true,"scales":{"yAxes":[{"ticks":{"beginAtZero":true}}],"xAxes":[""]},"title":{"display":true,"text":"Test Title"},"animation":{"onComplete":null}}} );
'@
            }
            else{
                $Should = @'
var ctx = document.getElementById("TestCanvasID").getContext('2d'); var myChart = new Chart(ctx, {"type":"line","data":{"labels":["january","february"],"datasets":[{"borderWidth":1,"borderDash":[0],"borderDashOffSet":0,"cubicInterpolationMode":"default","fill":false,"lineTension":0.5,"pointBackgroundColor":"rgb(255,255,255)","pointBorderColor":"rgb(0,0,0)","pointBorderWidth":[1],"pointRadius":4,"pointStyle":"circle","showLine":true,"backgroundColor":null,"borderColor":null,"borderCapStyle":null,"borderJoinStyle":null,"pointRotation":null,"pointHitRadius":0,"PointHoverBackgroundColor":null,"pointHoverBorderColor":null,"pointHoverBorderWidth":0,"pointHoverRadius":0,"spanGaps":false,"data":[3,5],"label":null}]},"options":{"showLines":true,"spanGaps":false,"categoryPercentage":1,"responsive":false,"offsetGridLines":true,"scales":{"yAxes":[{"ticks":{"beginAtZero":true}}],"xAxes":[""]},"title":{"display":true,"text":"Test Title"},"animation":{"onComplete":null}}} );
'@
            }

            $Is | should be $Should
        }

        it '[New-PSHTMLChart][-Type Line][-DataSet Multiple LineDataSet][Label][Title][CanvasId] Should create ChartJS javascript Code' {
            $Is = New-PSHTMLChart -Type Line -DataSet $bds,$bds2 -Labels $Labels -Title $Title -CanvasID $CanvasID
           If($PSVersionTable.PsEdition -eq 'Core'){
               $Should =@'
var ctx = document.getElementById("TestCanvasID").getContext('2d'); var myChart = new Chart(ctx, {"type":"line","data":{"labels":["january","february"],"datasets":[{"borderWidth":1,"borderDash":[0],"borderDashOffSet":0,"cubicInterpolationMode":"default","fill":false,"lineTension":0.5,"pointBackgroundColor":"rgb(255,255,255)","pointBorderColor":"rgb(0,0,0)","pointBorderWidth":[1],"pointRadius":4.0,"pointStyle":"circle","showLine":true,"backgroundColor":null,"borderColor":null,"borderCapStyle":null,"borderJoinStyle":null,"pointRotation":null,"pointHitRadius":0.0,"PointHoverBackgroundColor":null,"pointHoverBorderColor":null,"pointHoverBorderWidth":0,"pointHoverRadius":0.0,"spanGaps":false,"data":[3,5],"label":null},{"borderWidth":1,"borderDash":[0],"borderDashOffSet":0,"cubicInterpolationMode":"default","fill":false,"lineTension":0.5,"pointBackgroundColor":"rgb(255,255,255)","pointBorderColor":"rgb(0,0,0)","pointBorderWidth":[1],"pointRadius":4.0,"pointStyle":"circle","showLine":true,"backgroundColor":null,"borderColor":null,"borderCapStyle":null,"borderJoinStyle":null,"pointRotation":null,"pointHitRadius":0.0,"PointHoverBackgroundColor":null,"pointHoverBorderColor":null,"pointHoverBorderWidth":0,"pointHoverRadius":0.0,"spanGaps":false,"data":[12,15],"label":null}]},"options":{"showLines":true,"spanGaps":false,"categoryPercentage":1,"responsive":false,"offsetGridLines":true,"scales":{"yAxes":[{"ticks":{"beginAtZero":true}}],"xAxes":[""]},"title":{"display":true,"text":"Test Title"},"animation":{"onComplete":null}}} );
'@
            }Else{
                $Should =@'
var ctx = document.getElementById("TestCanvasID").getContext('2d'); var myChart = new Chart(ctx, {"type":"line","data":{"labels":["january","february"],"datasets":[{"borderWidth":1,"borderDash":[0],"borderDashOffSet":0,"cubicInterpolationMode":"default","fill":false,"lineTension":0.5,"pointBackgroundColor":"rgb(255,255,255)","pointBorderColor":"rgb(0,0,0)","pointBorderWidth":[1],"pointRadius":4,"pointStyle":"circle","showLine":true,"backgroundColor":null,"borderColor":null,"borderCapStyle":null,"borderJoinStyle":null,"pointRotation":null,"pointHitRadius":0,"PointHoverBackgroundColor":null,"pointHoverBorderColor":null,"pointHoverBorderWidth":0,"pointHoverRadius":0,"spanGaps":false,"data":[3,5],"label":null},{"borderWidth":1,"borderDash":[0],"borderDashOffSet":0,"cubicInterpolationMode":"default","fill":false,"lineTension":0.5,"pointBackgroundColor":"rgb(255,255,255)","pointBorderColor":"rgb(0,0,0)","pointBorderWidth":[1],"pointRadius":4,"pointStyle":"circle","showLine":true,"backgroundColor":null,"borderColor":null,"borderCapStyle":null,"borderJoinStyle":null,"pointRotation":null,"pointHitRadius":0,"PointHoverBackgroundColor":null,"pointHoverBorderColor":null,"pointHoverBorderWidth":0,"pointHoverRadius":0,"spanGaps":false,"data":[12,15],"label":null}]},"options":{"showLines":true,"spanGaps":false,"categoryPercentage":1,"responsive":false,"offsetGridLines":true,"scales":{"yAxes":[{"ticks":{"beginAtZero":true}}],"xAxes":[""]},"title":{"display":true,"text":"Test Title"},"animation":{"onComplete":null}}} );
'@
            }
            $Is | should be $Should
        }
    } -tag "Chart", "Line"
}
