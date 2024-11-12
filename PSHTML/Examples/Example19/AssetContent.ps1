# This example highlight how to write assets directly as content.
# This is useful when you want to write the asset content directly in the HTML document so that they can be shared with all the dynamic content.
import-module pshtml -Force

$html = html {
    head {
        title "Asset Content"
        #Use -AsContent to write the asset content directly in the HTML document
        Write-PSHTMLAsset -AsContent
    }
    body {
        h1 "Asset Content"
        p "This is the asset content"
        $PieCanvasID = "piecanvas"
        canvas -Height 400px -Width 400px -Id $PieCanvasID {
        
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
 
Out-PSHTMLDocument  -HTMLDocument $html  -OutPath "C:\Users\Stephane\Code\PSHTML\PSHTML\Examples\Example19\AssetContent.html" -Show