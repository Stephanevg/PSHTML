Function New-PSHTMLChart {
    <#
    
        .SYNOPSIS
            Creates a PSHMTL Chart.
    
        .DESCRIPTION
            Will render a Graph in Javascript using Chart.JS
    
        .PARAMETER Type
    
        Specifies the type of chart to generate.
    
        .EXAMPLE
    
            This example creates 3 different doughnut charts.
            In the oposite of a bar or line chart, mixing different datasets on the same doughnut chart won't be as much value as with the other types of charts.
            It is recommended to create a doughnut chart per dataset.
    
            $Data1 = @(34,7,11,19)
            $Data2 = @(40,2,13,17)
            $Data3 = @(53,0,0,4)
    
            $Labels = @("Closed","Unresolved","Pending","Open")
            $colors = @("Yellow","red","Green","Orange")
            $dsd1 = New-PSHTMLChartDoughnutDataSet -Data $data1 -label "March" -backgroundcolor $colors
            $dsd2 = New-PSHTMLChartDoughnutDataSet -Data $data2 -label "April" -BackgroundColor $colors
            $dsd3 = New-PSHTMLChartDoughnutDataSet -Data $data3 -label "Mai" -BackgroundColor $Colors
    
            New-PSHTMLChart -type doughnut -DataSet @($dsd1) -title "Doughnut Chart v1" -Labels $Labels -CanvasID $DoughnutCanvasID
            New-PSHTMLChart -type doughnut -DataSet @($dsd2) -title "Doughnut Chart v2" -Labels $Labels -CanvasID $DoughnutCanvasID
            New-PSHTMLChart -type doughnut -DataSet @($dsd3) -title "Doughnut Chart v3" -Labels $Labels -CanvasID $DoughnutCanvasID
    #>
        [CmdletBinding()]
        Param(
            #[ValidateSet("Bar","Line","Pie","doughnut")]
            [ChartType]$Type = $(Throw '-Type is required'),
    
            [dataSet[]]$DataSet = $(Throw '-DataSet is required'),
    
            [String[]]
            $Labels = $(Throw '-Labels is required'),
    
            [String]$CanvasID = $(Throw '-CanvasID is required'),
    
            [Parameter(Mandatory=$False)]
            [String]$Title,
    
            [ChartOptions]$Options
        )
    
    
    
    #Chart -> BarChart (?)
    switch($Type){
        "doughnut" {
            $Chart = [DoughnutChart]::New()
            $ChartOptions = [DoughnutChartOptions]::New()
            ;Break
        }
        "Pie" {
            $Chart = [PieChart]::New()
            $ChartOptions = [PieChartOptions]::New()
            ;Break
        }
        "Bar"{
            $Chart = [BarChart]::New()
            $ChartOptions = [BarChartOptions]::New()
            ;Break
        }
        "Line"{
            $Chart = [LineChart]::New()
            $ChartOptions = [LineChartOptions]::New()
            
            ;Break
        }
        default{
            Throw "Graph type not supported. Please use a valid value from Enum [ChartType]"
        }
    }
    
    if($Responsive){
    
    }
    
        #Type [String]
            #[ENUM]ChartType
        #Data [ChartData]
            #Labels
            #DataSets
        $ChartData = [ChartData]::New()
        #Hack to avoid to have a 'null' value displayed in the graph 
        #This could be fixed by not creating a new empty DataSet on construction.(Just in case, if you have time ;)
            #$ChartData.datasets = $null 
            $Chartdata.datasets.RemoveAt(0) #Removing null one.
    
                #$DataSet1.backgroundColor = [Color]::blue
                foreach($ds in $dataSet){
    
                    $ChartData.AddDataSet($ds)
                }
                
                $ChartData.SetLabels($Labels)
                $Chart.SetData($ChartData)
        #Options [ChartOptions]
           
            
            if($Title){
    
                $ChartOptions.Title.Display = $true
                $ChartOptions.Title.text = $Title
            }
            $Chart.SetOptions($ChartOptions)
        
    
    
    
    
        return $Chart.GetDefinition($CanvasID)
        
    
    }
    