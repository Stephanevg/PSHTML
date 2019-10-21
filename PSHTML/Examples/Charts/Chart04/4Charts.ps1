﻿
<#
    Example combineing different types of charts one the same page.
#>

import-module PSHTML

$BarCanvasID = "barcanvas"
$PieCanvasID = "piecanvas"
$lineCanvasID = "linecanvas"
$DoughnutCanvasID = "doughnutcanvas"
$HTMLPage = html { 
    head {
        title 'Chart JS Demonstration'
        
    }
    body {
        
        h1 "PSHTML Graph"

        div {
            
           p {
               "This is a bar graph"
           }
           canvas -Height 400px -Width 400px -Id $BarCanvasID {
    
           }

           p {
            "This is a Pie graph"
            }
            canvas -Height 400px -Width 400px -Id $PieCanvasID {
    
            }

            p {
                "This is a Line graph"
            }
            canvas -Height 400px -Width 400px -Id $LineCanvasID {
    
            }
            p {
                "This is a Doughnut graph"
            }
            canvas -Height 400px -Width 400px -Id $DoughnutCanvasID {
    
            }
       }

         script -src "https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.3/Chart.min.js" -type "text/javascript"


        script -content {

            $Data1 = @(34,7,11,19)
            $Data2 = @(40,2,13,17)
            $Data3 = @(53,0,0,4)
            $Labels = @("Closed","Unresolved","Pending","Open")

        
            $dsb1 = New-PSHTMLChartBarDataSet -Data $data1 -label "March" -BackgroundColor "Orange"
            $dsb2 = New-PSHTMLChartBarDataSet -Data $data2 -label "April" -BackgroundColor "red"
            $dsb3 = New-PSHTMLChartBarDataSet -Data $data3 -label "Mai" -BackgroundColor "Green"

            New-PSHTMLChart -type bar -DataSet $dsb1,$dsb2,$dsb3 -title "Bar Chart v2" -Labels $Labels -CanvasID $BarCanvasID -tobase64
      
            $dsl1 = New-PSHTMLChartLineDataSet -lineColor "cyan" -Data $data1 -label "March" 

            $dsl2 = New-PSHTMLChartLineDataSet -Data $data2 -label "April" -LineColor "Orange"
            $dsl3 = New-PSHTMLChartLineDataSet -Data $data3 -label "Mai" -LineColor "Green"

            
            New-PSHTMLChart -type Line -DataSet @($dsl1,$dsl2,$dsl3) -title "Line Chart v2" -Labels $Labels -CanvasID $lineCanvasID -tobase64

            $colors = @("yellow","red","green","orange")
            $dsp1 = New-PSHTMLChartPieDataSet -Data $data1 -label "March" -BackgroundColor $colors

            New-PSHTMLChart -type pie -DataSet $dsp1 -title "Pie Chart v2" -Labels $Labels -CanvasID $PieCanvasID -tobase64

           

            $colors = @("yellow","red","green","orange")
            $dsd1 = New-PSHTMLChartDoughnutDataSet -Data $data1 -label "March" -backgroundcolor $colors -hoverbackgroundColor $Colors
            $dsd2 = New-PSHTMLChartDoughnutDataSet -Data $data2 -label "April" -BackgroundColor "red"
            $dsd3 = New-PSHTMLChartDoughnutDataSet -Data $data3 -label "Mai" -BackgroundColor "green"


            New-PSHTMLChart -type doughnut -DataSet @($dsd1) -title "Doughnut Chart v2" -Labels $Labels -CanvasID $DoughnutCanvasID -tobase64
 
            
        }

         
    }
}


$OutPath = "c:\temp\4graphs_test4.html"
$HTMLPage | out-file -FilePath $OutPath -Encoding utf8
start $outpath