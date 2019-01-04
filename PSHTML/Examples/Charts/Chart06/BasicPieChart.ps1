
import-module PSHTML -force

$PieCanvasID = "piecanvas"

$HTMLPage = html { 
    head {
        title 'Basic Pie Chart Demo'
        
    }
    body {
        
        h1 "PSHTML Charts"

        div {

            p {
                "This is a Pie Chart"
            }
            canvas -Height 400px -Width 400px -Id $PieCanvasID {
    
            }
 
        }

        script -src "https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.3/Chart.min.js" -type "text/javascript"


        script -content {

            $Data1 = @(34,7,11,19)
            $Labels = @("Closed","Unresolved","Pending","Open")


            $colors = @("Lightgreen","red","Blue","Yellow")
            $dsp1 = New-PSHTMLChartPieDataSet -Data $data1 -label "March" -BackgroundColor $colors

            New-PSHTMLChart -type pie -DataSet $dsp1 -title "Pie Chart v2" -Labels $Labels -CanvasID $PieCanvasID 

            
        }

            
    }
}


$OutPath = $Home\BasicPieChart.html"
$HTMLPage | out-file -FilePath $OutPath -Encoding utf8
start $outpath