
import-module PSHTML -force

$DoughnutCanvasID = "doughnutcanvas"
$HTMLPage = html { 
    head {
        title 'Chart JS Demonstration'
        
    }
    body {
        
        h1 "PSHTML Chart"

        div {
            

            p {
                "This is a Doughnut graph"
            }
            canvas -Height 400px -Width 400px -Id $DoughnutCanvasID {
    
            }
       }

         script -src "https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.3/Chart.min.js" -type "text/javascript"


        script -content {

            $Data1 = @(34,7,11,19)

            $Labels = @("Closed","Unresolved","Pending","Open")
            $colors = @("LightGreen","Red","LightBlue","LightYellow")
            $dsd1 = New-PSHTMLChartDoughnutDataSet -Data $data1 -label "March" -backgroundcolor $colors -hoverbackgroundColor $Colors

            New-PSHTMLChart -type doughnut -DataSet @($dsd1) -title "Doughnut Chart v2" -Labels $Labels -CanvasID $DoughnutCanvasID
 
            
        }

         
    }
}


$OutPath = "$Home\BasicDoughnutChart.html"
$HTMLPage | out-file -FilePath $OutPath -Encoding utf8
start $outpath