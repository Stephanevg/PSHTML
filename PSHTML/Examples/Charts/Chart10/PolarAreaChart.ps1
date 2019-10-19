
import-module PSHTML


$PolarCanvasID = "Polarcanvas"
$HTMLDocument = html { 
    head {
        title 'Chart JS Demonstration'
        
    }
    body {
        
        h1 "PSHTML Graph"

        div {
            
            p {
                "This is a polarArea graph"
            }
            canvas -Height 400px -Width 400px -Id $PolarCanvasID {
    
            }

        }

        script -src "https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.3/Chart.min.js" -type "text/javascript"

        script -content {

            $Labels      = @('January',   'February', 'Mars',     'April', 'Mai',       'June',   'July',    'August',      'September', 'October', 'November', 'december')
            $Colors      = @('red',       'Cyan',     'DarkCyan', 'green', 'DarkGreen', 'yellow', 'Orange',  'grey',        'DarkGrey',  'blue',    'Magenta',  'DarkMagenta')
            $HoverColors = @('DarkGreen', 'yellow',   'Orange',   'grey',  'DarkGrey',  'blue',   'Magenta', 'DarkMagenta', 'red',       'Cyan',    'DarkCyan', 'green' )
            $Data1       = @(17,          25,         18,         17,      10,           28,      35,         50,           44,          10,        32,         72)
            
            $dsb1 = New-PSHTMLChartPolarAreaDataSet -Data $data1 -BackgroundColor $Colors -hoverBackgroundColor $HoverColors -PointRadius

            New-PSHTMLChart -type polarArea -DataSet $dsb1 -title  'PolarArea Chart Example' -Labels $Labels -CanvasID $PolarCanvasID
        }
    }
}


$OutPath = "$Home/PolarChart1.html"
Out-PSHtmlDocument -HTMLDocument $HTMLDocument -OutPath $OutPath -Show