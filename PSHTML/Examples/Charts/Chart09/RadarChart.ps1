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
                "This is a radar graph"
            }
            canvas -Height 400px -Width 400px -Id $BarCanvasID {
    
            }

        }

        script -src "https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.3/Chart.min.js" -type "text/javascript"

        script -content {

            $Labels = @("January","February","Mars","April","Mai","June","July","August","September","October","November","december")
            $dsb1 = @() 

            $Data1 = @(17,25,18,17,22,30,35,44,4,1,6,12)
            $dsb1 += New-PSHTMLChartBarDataSet -Data $data1 -label "2018" -borderColor ( [Color]::blue ) -backgroundColor "transparent" -hoverBackgroundColor ( [Color]::green )
            $Data2 = @(4,1,6,12,17,25,18,17,22,30,35,44)
            $dsb1 += New-PSHTMLChartBarDataSet -Data $data2 -label "2019" -borderColor ([Color]::red ) -backgroundColor "transparent" -hoverBackgroundColor ( [Color]::yellow )

            New-PSHTMLChart -type radar -DataSet $dsb1 -title "Radar Chart Example" -Labels $Labels -CanvasID $BarCanvasID

        }

            
    }
}


$OutPath = "$Home\BarChart1.html"
$HTMLPage | out-file -FilePath $OutPath -Encoding utf8
start $outpath