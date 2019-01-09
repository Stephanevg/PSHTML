
import-module PSHTML.psd1 -force

$BarCanvasID = "barcanvas"
$HTMLPage = html { 
    head {
        title 'PSHTML Chart Demonstration'
        
    }
    body {
        
        h1 "PSHTML Graph"

        div {
            
           p {
               "This is a bar graph"
           }
           canvas -Height 400px -Width 400px -Id $BarCanvasID {
    
           }


       }

     script -src "https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.3/Chart.min.js" -type "text/javascript"


        script -content {

            $Data1 = @(34,7,11,19)

            $Labels = @("Closed","Unresolved","Pending","Open")

        
            $dsb1 = New-PSHTMLChartBarDataSet -Data $data1 -label "March" -BackgroundColor ([Color]::blue)

            New-PSHTMLChart -type bar -DataSet $dsb1 -title "Ticket Statistics" -Labels $Labels -CanvasID $BarCanvasID

        }

         
    }
}


$OutPath = "$Home\BarChart.html"
$HTMLPage | out-file -FilePath $OutPath -Encoding utf8
start $outpath