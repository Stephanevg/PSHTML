<# $Searcher = New-Object -ComObject Microsoft.Update.Searcher;                                      
        $Searcher.GetTotalHistoryCount()                                            
        $AllUpdatesInstalled = $Searcher.GetTotalHistoryCount()                     
        $Updates = $Searcher.QueryHistory(0,$AllUpdatesInstalled)
        #>
import-module PSHTML


$BarCanvasID = "barcanvas"
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

       }

        script -src "https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.3/Chart.min.js" -type "text/javascript"

        script -content {


            $Data3 = @(4,1,6,12,17,25,18,17,22,30,35,44)
            $Labels = @("January","February","Mars","April","Mai","June","July","August","September","October","November","december")

            $dsb3 = New-PSHTMLChartBarDataSet -Data $data3 -label "2018" -BackgroundColor ([Color]::blue )

            New-PSHTMLChart -type bar -DataSet $dsb3 -title "Bar Chart Example" -Labels $Labels -CanvasID $BarCanvasID

 
            
        }

         
    }
}


$OutPath = "$Home\BarChart1.html"
$HTMLPage | out-file -FilePath $OutPath -Encoding utf8
start $outpath