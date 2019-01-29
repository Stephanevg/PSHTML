$PieCanvasID = "piecanvas"
$Html = html {
    head {
        title 'Integrating BootStrap JQuery and ChartJS.'
        Write-PSHTMLAsset -Name Jquery
        Write-PSHTMLAsset -Name BootStrap
        Write-PSHTMLAsset -Name Chartjs
    }
    body {
        div -Class "Container"{

            h1 -Class "text-uppercase" 'Implementing BootStrap example.'
            P  {
                "This is a very simple example to demonstrate how Bootstrap integrated with PSHTML"
            }

            canvas -Height 400px -Width 400px -Id $PieCanvasID {
    
            }

            
        }
        Script -content {

            $Data1 = @(34,7,11,19)
            $Labels = @("Closed","Unresolved","Pending","Open")
            $colors = @("Lightgreen","red","Blue","Yellow")
            $dsp1 = New-PSHTMLChartPieDataSet -Data $data1 -label "March" -BackgroundColor $colors
            New-PSHTMLChart -type pie -DataSet $dsp1 -title "Pie Chart v2" -Labels $Labels -CanvasID $PieCanvasID
        }
    }
}

$Html | Out-File -FilePath ".\Export.html" -Encoding utf8
start .\Export.html