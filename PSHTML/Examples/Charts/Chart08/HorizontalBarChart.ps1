import-module PSHTML
$BarCanvasID = "barcanvas"
$htmlDocument = html { 
    head {
        title 'Chart JS Demonstration'
        
    }
    body {
        
        h1 "PSHTML Graph"

        div {
            
            p {
                "This is a horizontal bar graph"
            }
            canvas -Height 400px -Width 400px -Id $BarCanvasID {
    
            }

        }

        script -src "https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.3/Chart.min.js" -type "text/javascript"

        script -content {

            $Labels = @("January","February","Mars","April","Mai","June","July","August","September","October","November","december")
            $dsb1 = @() 

            $Data1 = @(17,25,18,17,22,30,35,44,4,1,6,12)

            $dsb1 += New-PSHTMLChartBarDataSet -Data $data1 -label "2018" -BackgroundColor (get-pshtmlColor -color blue) -hoverBackgroundColor (get-pshtmlColor -color green)
            $Data2 = @(4,1,6,12,17,25,18,17,22,30,35,44)
            $dsb1 += New-PSHTMLChartBarDataSet -Data $data2 -label "2019" -BackgroundColor (get-pshtmlColor -color red) -hoverBackgroundColor (get-pshtmlColor -color yellow)

            New-PSHTMLChart -type horizontalBar -DataSet $dsb1 -title "Horizontal Bar Chart Example" -Labels $Labels -CanvasID $BarCanvasID

        }

            
    }
}


$OutPath = "$Home/BarChart2.html"
Out-PSHTMLDocument -HTMLDocument $htmlDocument -OutPath $outpath -Show