
# Bar charts

> Before reading this documentation, it is recommended to read the general chart documentation first [here](./Charts.md).

This page will highlight the steps to follow to create **Bar** charts in  ```PSHTML```

# Creating a simple bar chart

A simple bar chart, is nothing more then a barchart with a ```Dataset``` of type ```DatasetBar```

> As a reminder, a dataset is what will allow to specify the looks of the graph. Things like the color, hover over color, thickness etc.. are all set via a dataset. Each chart type comes with a set of specific dataset properties (for example, how big should the emtpy space in a doughnut graph be - is an options that cannot apply to a line chart).

In order to create a barchart, we need to follow these steps:
0. Preparing a spot, for your chart, and linking to the library.
1. Create a datasetBar
2. Create a chart
3. Add the dataset to the chart
4. Display the chart

> In reality, step **1 & 2** and **3 & 4** are combined into a comon step .


## Preparing a spot for your chart 

A chart **will** find place on a [canvas](https://www.w3schools.com/tags/tag_canvas.asp) somewhere in your HTML page. 
Add your ```canvas``` somewhere in your ```body``` section of your page, like this:

```powershell
$BarCanvasID = "barcanvas001"
canvas -Height 400px -Width 400px -Id $BarCanvasID {
    
}
```

> It is a good idea to set the __id__ of the canvas in a variable, as it will be needed in a later step to indicate to the chart where it should be created.

## Linking to the Chart Library

For the moment, one must add the following section at the end of the body section.

```powershell
script -src "https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.3/Chart.min.js" -type "text/javascript"
```

## Creating a dataset

The first step in creating a graph is the creation of a Dataset.

For this, you will use the function ```New-PSHTMLChartBarDataSet``` to save the dataset in a variable as in this example:

```powershell
    $Data = @(34,7,11,19) #Get your data using any type of powershell cmdlet / function
    $dataset = New-PSHTMLChartBarDataSet -Data $Data -label "March" -BackgroundColor ([Color]::Orange)

```

> The ```$Data``` variable would contais integers, which would represents 'some' data over time for example.

### Creating and assigning the chart


Now that we have the our information located in the ```$DataSet``` variable we will be able to create the chart.

In order to create a chart in ```PSHTML``` you need to use the following cmdlet:

```powershell
New-PSHTMLChart
```

> The ```New-PSHTMLChart```cmdlet is your only entry point needed in order create charts.

```powershell
$Labels = @("Closed","Unresolved","Pending","Open") #description of each row from data
New-PSHTMLChart -Type bar -DataSet $Dataset -Title "March Data" -Labels $Labels -CanvasID $BarCanvasID
```

To recall, this was the data we provided:

```powershell
$Data = @(34,7,11,19)
$Labels = @("Closed","Unresolved","Pending","Open")


```

Which, actually represented from a ticketing system example, the following data:

|Closed|Unresolved|Pending|open|
|---|---|---|---|
|34|7|11|19|

This would result in the following graph:

![BasicBarChar](./Images/BarChart_basic_01.png)

> Nota: The function must be called within a '-content' block of a 'script' section (See script listing below)

The full script listing is availble here under:

```powershell

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
```
