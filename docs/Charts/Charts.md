# Creating charts

Charts are supported starting from version v0.7.0. This documentation explains how to use them.

> Charts in PSHTML are supported through [Charts.js](https://chartjs.org).

# Basics

In order to create a graph in pshtml, a few key things needs to be respected.

1. A script tag with a reference to Chartjs library
2. A canvas with a specific ID
3. A dataset
4. A chart which contains the dataset(s), and which is assigned the CanvasID.

## Reference to Chart.js

A script tag must point to the chart.js / chart.min.js file.

example:

```powershell
script -src "https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.3/Chart.min.js" -type "text/javascript"
```
## Canvas

You must create a canvas on your page, using the `canvas` tag and it **must** have an id.

```powershell
canvas -Height 400px -Width 400px -Id $LineCanvasID {
    
}
```

## Dataset

A dataset need to be created using the New-PSHTMLData* cmdlet.

```powershell


$Data1 = @(34,7,11,19)

#Bar
$dsb1 = New-PSHTMLChartBarDataSet -Data $data1 -label "March" -BackgroundColor ([Color]::Orange)

#Line
$dsl1 = New-PSHTMLChartLineDataSet -lineColor "cyan" -Data $data1 -label "March" 

#pie
$colors = @("yellow","red","green","orange")
$dsp1 = New-PSHTMLChartPieDataSet -Data $data1 -label "March" -BackgroundColor $colors

#Doughnut
$colors = @("yellow","red","green","orange")
$dsd1 = New-PSHTMLChartDoughnutDataSet -Data $data1 -label "March" -backgroundcolor $colors -hoverbackgroundColor $Colors

```

## The Chart 

The actual chart, needs to be created in a script tag.

```powershell
 script -content {

    $Data3 = @(4,1,6,12,17,25,18,17,22,30,35,44)

    $Labels = @("January","February","Mars","April","Mai","June","July","August","September","October","November","december")

    $dsb3 = New-PSHTMLChartBarDataSet -Data $data3 -label "2018" -BackgroundColor ([Color]::blue )

    New-PSHTMLChart -type bar -DataSet $dsb3 -title "Bar Chart Example" -Labels $Labels -CanvasID $BarCanvasID
}

```

## Full code

The full code:

```powershell

import-module PSHTML


$BarCanvasID = "barcanvas"
$HTMLPage = html { 
    head {
        title 'Bar Chart'
        
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
```

## Result

![Chart](../PSHTML/Examples/Charts/Chart01/BarChartExample.png)