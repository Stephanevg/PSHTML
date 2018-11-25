<#
Class PieData : ChartData {
    [Color]$BackGroundColor
    [Color]$BorderColor
    [int]$BorderWidth
    [Color]$HoverBackGroundColor
    [Color]$hoverBorderColor
    [int]$hoverBorderWidth
}

Class PieChart : BaseChart{

    $type = [ChartType]::Pie

    PieChart([ChartData]$Data,[ChartOption]$Options){
        $this.Data = $Data
        $This.Options = $Options
    }

    
}
#>

##end of pie

Enum ChartType {
    bar
    line
    doughnut
    pie
    polararea
    bubble
    scatter
    area
    mixed
}

Class Color {
    static [String] $blue = "rgb(30,144,255)"
    static [String] $red = "rgb(220,20,60)"
    static [string] $Yellow = "rgb(255,255,0)"
    static [string] $Green = "rgb(173,255,47)"
    static [string] $Orange = "rgb(255,165,0)"
}


Class dataSet {
    [System.Collections.ArrayList] $data = @()
    [String]$label
    [String] $xAxisID
    [String] $yAxisID
    [String]  $backgroundColor
    [String]  $borderColor
    [int]    $borderWidth
    [String] $borderSkipped
    [String]  $hoverBackgroundColor
    [String]  $hoverBorderColor
    [int]    $hoverBorderWidth

    dataSet(){

    }

    dataset([Array]$Data,[String]$Label){
        $this.label = $Label
        foreach($D in $Data){
            $null = $this.data.Add($d)
        }
    }
}

Class datasetbar : dataset {

}


Class datasetline : dataset{

}

Class datasetpie : dataset {

}



Class scales {
    [System.Collections.ArrayList]$yAxes = @()
    [System.Collections.ArrayList]$xAxes = @()

    scales(){

        $null =$this.yAxes.Add(@{"ticks"=@{"beginAtZero"=$true}})
    }
}

Class ChartTitle {
    [Bool]$display=$false
    [String]$text
}

Class ChartOptions  {
    [int]$barPercentage = 0.9
    [Int]$categoryPercentage = 0.8
    [bool]$responsive = $false
    [String]$barThickness
    [Int]$maxBarThickness
    [Bool] $offsetGridLines = $true
    [scales]$scales = [scales]::New()
    [ChartTitle]$title = [ChartTitle]::New() 

    <#
        elements: {
						rectangle: {
							borderWidth: 2,
						}
					},
					responsive: true,
					legend: {
						position: 'right',
					},
					title: {
						display: true,
						text: 'Chart.js Horizontal Bar Chart'
					}
    #>
}

Class ChartData {
    [System.Collections.ArrayList] $labels = @()
    [DataSet[]] $datasets = @()

    ChartData(){
        $this.datasets = [dataSet]::New()
    }

    AddDataSet([DataSet]$Dataset){
        $this.datasets += $Dataset
    }

    SetLabels([Array]$Labels){
        Foreach($l in $Labels){

            $Null = $this.labels.Add($l)
        }
    }

}

Class BarData : ChartData {
    
    
}


Class BaseChart {
    [ChartType]$type
    [ChartData]$data
    [ChartOptions]$options
    Hidden [String]$definition

    BaseChart(){
        $Currenttype = $this.GetType()

        if ($Currenttype -eq [BaseChart])
        {
            throw("Class $Currenttype must be inherited")
        }
    }

    SetData([ChartData]$Data){
        $this.Data = $Data
    }

    SetOptions([ChartOptions]$Options){
        $this.Options = $Options
    }

    hidden [void] BuildDefinition(){
        $This.GetDefinitionStart()
        $This.GetDefinitionBody()
        $This.GetDefinitionEnd()
        #Do stuff with $DEfinition
    }

    Hidden [String]GetDefinitionStart([String]$CanvasID){
        $Start = @"
var ctx = document.getElementById("$($CanvasID)").getContext('2d');
var myChart = new Chart(ctx, 
"@
    return $Start
    }

    Hidden [String]GetDefinitionEnd(){
        Return ");"
    }

    Hidden [String]GetDefinitionBody(){
        
        ##Graph Structure
            #Type
            #Data
                #Labels[]
                #DataSets[]
                    #Label
                    #Data[]
                    #BackGroundColor[]
                    #BorderColor[]
                    #BorderWidth int
            #Options
                #Scales
                    #yAxes []
                        #Ticks
                            #beginAtZero [bool]
                            
        $Body = $this | select @{N='type';E={$_.type.ToString()}},Data,Options  | convertto-Json -Depth 6
        Return $Body
    }

    [String] GetDefinition([String]$CanvasID){
        
        $FullDefintion = [System.Text.StringBuilder]::new()
        $FullDefintion.Append($this.GetDefinitionStart([String]$CanvasID))
        $FullDefintion.AppendLine($this.GetDefinitionBody())
        $FullDefintion.AppendLine($this.GetDefinitionEnd())
        return $FullDefintion
    }
}




#Main class (Inherits from BaseChart)
Class BarChart : BaseChart{

    [ChartType] $type = [ChartType]::bar
    
    BarChart(){
        #$Type = [ChartType]::bar

    }

    BarChart([ChartData]$Data,[ChartOptions]$Options){
        $this.data = $Data
        $This.options = $Options
    }

}

Class LineChart : BaseChart{

    [ChartType] $type = [ChartType]::line
    
    LineChart(){
        #$Type = [ChartType]::bar

    }

    BarChart([ChartData]$Data,[ChartOptions]$Options){
        $this.data = $Data
        $This.options = $Options
    }

}

Class PieChart : BaseChart{

    [ChartType] $type = [ChartType]::pie
    
    LineChart(){
        #$Type = [ChartType]::bar

    }

    BarChart([ChartData]$Data,[ChartOptions]$Options){
        $this.data = $Data
        $This.options = $Options
    }

}

<# 
Class BarChartData {
    [Int]$data
    [String]$Label
    $BackGroundColor
    $BorderColor
    [String]$DatasetName

    BarChartData(){

    }

    BarChartData([Int]$Data,[String]$Label){
        $this.Data = $Data
        $this.Label = $Label
        $this.SetDefaultValuesIfNoneSet()
    }

    BarChartData([Int]$Data,[String]$Label,[String]$DatasetName){
        $this.Data = $Data
        $this.Label = $Label
        $this.DatasetName = $DatasetName
        $this.SetDefaultValuesIfNoneSet()
    }

    BarChartData([Int]$Data,[String]$Label,[String]$DatasetName,$BackGroundColor){
        $this.Data = $Data
        $this.Label = $Label
        $this.BackGroundColor = $BackGroundColor
        $this.DatasetName = $DatasetName
        $this.SetDefaultValuesIfNoneSet()
    }

    BarChartData([Int]$Data,[String]$Label,[String]$DatasetName,$BackGroundColor,$borderColor){
        $this.Data = $Data
        $this.Label = $Label
        $this.DatasetName = $DatasetName
        $this.BackGroundColor = $BackGroundColor
        $this.BorderColor = $this.BorderColor
        $this.SetDefaultValuesIfNoneSet()
    }


    Hidden SetDefaultValuesIfNoneSet(){
        if(!($this.BackGroundColor)){

            $this.BackGroundColor = [Color]::blue
        }

        if(!($this.BorderColor)){

            $this.BorderColor = [Color]::Yellow
        }
    }
}
 #>
Function New-PSHTMLBarChart {
    [CmdletBInding()]
    Param(
        [Parameter(Mandatory=$true)]
        [dataSet[]]$DataSet,

        [Parameter(Mandatory=$true)]
        [String[]]
        $Labels,


        [Parameter(Mandatory=$true)]
        [String]$CanvasID,

        [Parameter(Mandatory=$False)]
        [String]$Title

        #[Switch]$Responsive
        
    )





    #Dataset
        #Label
        #Data[]
        #BackGroundColor
        #BorderWidth

   
        #Datasets []


    #$null = $BarChart.Data.Labels.Add($Title)


#Chart -> BarChart (?)
$BarChart = [BarChart]::New()
if($Responsive){

}
#$BarChart.options.responsive = $false
    #Type [String]
        #[ENUM]ChartType
    #Data [ChartData]
    $ChartData = [ChartData]::New()
    $ChartData.datasets = $null #Hack to avoid to have a 'null' value displayed in the graph
        #Labels
        #DataSets

            #$DataSet1.backgroundColor = [Color]::blue
            foreach($ds in $dataSet){

                $ChartData.AddDataSet($ds)
            }
            
            $ChartData.SetLabels($Labels)
            $BarChart.SetData($ChartData)
    #Options [ChartOptions]
       
        $ChartOptions = [ChartOptions]::New()
        if($Title){

            $ChartOptions.Title.Display = $true
            $ChartOptions.Title.text = $Title
        }
        $BarChart.SetOptions($ChartOptions)
    




    return $BarChart.GetDefinition($CanvasID)
    
}

Function New-PSHTMLChart {
    [CmldetBinding()]
    Param(
        [ValidateSet("Bar","Line","Pie")]
        [String]$Type
        [Parameter(Mandatory=$true)]
            [dataSet[]]$DataSet,
    
            [Parameter(Mandatory=$true)]
            [String[]]
            $Labels,
    
    
            [Parameter(Mandatory=$true)]
            [String]$CanvasID,
    
            [Parameter(Mandatory=$False)]
            [String]$Title
    )

}

Function New-PSHTMLPieChart {
    [CmdletBInding()]
    Param(
        [Parameter(Mandatory=$true)]
        [dataSet[]]$DataSet,

        [Parameter(Mandatory=$true)]
        [String[]]
        $Labels,


        [Parameter(Mandatory=$true)]
        [String]$CanvasID,

        [Parameter(Mandatory=$False)]
        [String]$Title

        #[Switch]$Responsive
        
    )





    #Dataset
        #Label
        #Data[]
        #BackGroundColor
        #BorderWidth

   
        #Datasets []


    #$null = $BarChart.Data.Labels.Add($Title)


#Chart -> BarChart (?)
$BarChart = [PieChart]::New()
if($Responsive){

}
#$BarChart.options.responsive = $false
    #Type [String]
        #[ENUM]ChartType
    #Data [ChartData]
    $ChartData = [ChartData]::New()
    $ChartData.datasets = $null #Hack to avoid to have a 'null' value displayed in the graph
        #Labels
        #DataSets

            #$DataSet1.backgroundColor = [Color]::blue
            foreach($ds in $dataSet){

                $ChartData.AddDataSet($ds)
            }
            
            $ChartData.SetLabels($Labels)
            $BarChart.SetData($ChartData)
    #Options [ChartOptions]
       
        $ChartOptions = [ChartOptions]::New()
        if($Title){

            $ChartOptions.Title.Display = $true
            $ChartOptions.Title.text = $Title
        }
        $BarChart.SetOptions($ChartOptions)
    




    return $BarChart.GetDefinition($CanvasID)
    
}

Function New-PSHTMLLineChart {
    [CmdletBInding()]
    Param(
        [Parameter(Mandatory=$true)]
        [dataSet[]]$DataSet,

        [Parameter(Mandatory=$true)]
        [String[]]
        $Labels,


        [Parameter(Mandatory=$true)]
        [String]$CanvasID,

        [Parameter(Mandatory=$False)]
        [String]$Title

        #[Switch]$Responsive
        
    )





    #Dataset
        #Label
        #Data[]
        #BackGroundColor
        #BorderWidth

   
        #Datasets []


    #$null = $BarChart.Data.Labels.Add($Title)


#Chart -> BarChart (?)
$BarChart = [LineChart]::New()
if($Responsive){

}
#$BarChart.options.responsive = $false
    #Type [String]
        #[ENUM]ChartType
    #Data [ChartData]
    $ChartData = [ChartData]::New()
    $ChartData.datasets = $null #Hack to avoid to have a 'null' value displayed in the graph
        #Labels
        #DataSets

            #$DataSet1.backgroundColor = [Color]::blue
            foreach($ds in $dataSet){

                $ChartData.AddDataSet($ds)
            }
            
            $ChartData.SetLabels($Labels)
            $BarChart.SetData($ChartData)
    #Options [ChartOptions]
       
        $ChartOptions = [ChartOptions]::New()
        if($Title){

            $ChartOptions.Title.Display = $true
            $ChartOptions.Title.text = $Title
        }
        $BarChart.SetOptions($ChartOptions)
    




    return $BarChart.GetDefinition($CanvasID)
    
}


Function New-PSHTMLChartDataSet {
    <#
    .SYNOPSIS
        Creates a data set for any type of chart
    .DESCRIPTION
        This cmdlet must be used to format the data set to get data in correct fromat for any of the New-PSHTMLChart* cmdlets.

    .PARAMETER Name
        Name of the dataset.
    
    .PARAMETER Data
        Array of values 

    .EXAMPLE
        #Creating a simple dataset
         $Data = @("4","7","11","21")

         New-PSHTMLChartDataSet -Data $Data -Name "Grades"

    .EXAMPLE
         New-PSHTMLChartDataSet -Data @(1,2,3) -Name plop -BackgroundColor Blue -BorderColor Green -HoverBackgroundColor Red -hoverBorderColor Green -BorderWidth 3 -HoverBorderWidth 1 -xAxisID 0 -yAxisID 22 -borderSkipped bottom

        data                 : {1, 2, 3}
        label                : plop
        xAxisID              : 0le dataset
        yAxisID              : 22","11","21")
        backgroundColor      : rgb(30,144,255)
        borderColor          : rgb(173,255,47)$Data -Name "Grades"
        borderWidth          : 0
        borderSkipped        : bottom
        hoverBackgroundColor : rgb(220,20,60)d creating a chart
        hoverBorderColor     : rgb(173,255,47)
        hoverBorderWidth     : 0

    .EXAMPLE
        #Creating a simple dataset and creating a chart
        $Data = @("4","7","11","21")

        $DataSet = New-PSHTMLChartDataSet -Data $Data -Name "Grades"

        $Labels = @("Math","History","Sport","French")
        New-PSHTMLBarChart -DataSet $DataSet -Labels $Labels -CanvasID "Canvas01" -Title "Schoold grades"
    .INPUTS
        Inputs (if any)
    .OUTPUTS
        [DataSet]
    .NOTES
        Author: Stéphane van Gulick
    #>
    [CmdletBInding()]
    Param(
        [Parameter(Mandatory=$true)]
        [Array]$Data,

        [Parameter(Mandatory=$true)]
        [String]$Name,

        [Parameter(Mandatory=$false)]
        [Parameter(ParameterSetName="Line")]
        [Parameter(ParameterSetName="Bar")]
        [Parameter(ParameterSetName="Pie")]
        [Parameter(ParameterSetName="Doughnut")]
        [ValidateSet("Blue","Red","Yellow","Green")]
        $BackgroundColor,

        [Parameter(Mandatory=$false)]
        [Parameter(ParameterSetName="Line")]
        [Parameter(ParameterSetName="Bar")]
        [Parameter(ParameterSetName="Pie")]
        [Parameter(ParameterSetName="Doughnut")]
        [ValidateSet("Blue","Red","Yellow","Green")]
        $BorderColor,

        [Parameter(Mandatory=$false)]
        [ValidateSet("Blue","Red","Yellow","Green")]
        [Parameter(ParameterSetName="Bar")]
        [Parameter(ParameterSetName="Pie")]
        [Parameter(ParameterSetName="Doughnut")]
        #Not line
        $HoverBackgroundColor,

        [Parameter(Mandatory=$false)]
        [ValidateSet("Blue","Red","Yellow","Green")]
        [Parameter(ParameterSetName="Bar")]
        [Parameter(ParameterSetName="Pie")]
        [Parameter(ParameterSetName="Doughnut")]
        #Not line 
        $hoverBorderColor,

        [Parameter(Mandatory=$false)]
        [Parameter(ParameterSetName="Line")]
        [Parameter(ParameterSetName="Bar")]
        [Parameter(ParameterSetName="Pie")]
        [Parameter(ParameterSetName="Doughnut")]
        [int]
        $BorderWidth,

        [Parameter(Mandatory=$false)]
        [Parameter(ParameterSetName="Bar")]
        [Parameter(ParameterSetName="Pie")]
        [Parameter(ParameterSetName="Doughnut")]
        #Not Line 
        [int]
        $HoverBorderWidth,

        [Parameter(Mandatory=$false)]
        [Parameter(ParameterSetName="Line")]
        #Not in Bar,Pie & Doughnut
        [String]
        $xAxisID,

        [Parameter(Mandatory=$false)]
        [Parameter(ParameterSetName="Line")]
        #Not in Bar,Pie & Doughnut
        [String]
        $yAxisID,

        [ValidateSet("top","bottom","Left","right")]
        [Parameter(ParameterSetName="Bar")]
        #Not Line,Pie & Doughnut
        [String]
        $borderSkipped
    )

        $dataSet = [dataSet]::New($Data,$Name)
        if($BackgroundColor){

            $dataSet.backgroundColor = [Color]::$BackgroundColor
        }

        if($HoverBackgroundColor){

            $dataSet.HoverBackgroundColor = [Color]::$HoverBackgroundColor
        }

        if($hoverBorderColor){

            $dataSet.hoverBorderColor = [Color]::$hoverBorderColor
        }

        if($BorderColor){

            $dataSet.BorderColor = [Color]::$BorderColor
        }

        if($yAxisID){

            $dataSet.yAxisID = $yAxisID
        }

        if($xAxisID){

            $dataSet.XAxisID = $xAxisID
        }

        if($borderSkipped){

            $dataSet.borderSkipped = $borderSkipped
        }

        return $dataset
    
}
       

<# $Searcher = New-Object -ComObject Microsoft.Update.Searcher;                                      
        $Searcher.GetTotalHistoryCount()                                            
        $AllUpdatesInstalled = $Searcher.GetTotalHistoryCount()                     
        $Updates = $Searcher.QueryHistory(0,$AllUpdatesInstalled)
        #>
#New-PSHTMLBarChart -DataSet $DataSet -Labels $Labels -canvasID $CanvasID
#see for inspiration: https://codepen.io/Shokeen/pen/NpgbKg?editors=1010


#BarChart
    #DataSet
    #Labels
    #ChartData
    


#New-PSHTMLBarChart -BarChartData $DataSet1 -title "New version" -canvasID $CanvasID


##Structure
    #Type
    #Data
        #Labels[]
        #DataSets[]
            #Label
            #Data[]
            #BackGroundColor[]
            #BorderColor[]
            #BorderWidth int
    #Options
        #Scales
            #yAxes []
                #Ticks
                    #BeginAtZero [bool]

$BarCanvasID = "barcanvas"
$PieCanvasID = "piecanvas"
$lineCanvasID = "linecanvas"
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

           p {
            "This is a Pie graph"
            }
            canvas -Height 400px -Width 400px -Id $PieCanvasID {
    
            }

            p {
                "This is a Line graph"
            }
            canvas -Height 400px -Width 400px -Id $LineCanvasID {
    
            }
       }

         script -src "https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.3/Chart.min.js" -type "text/javascript"


        script -content {
            $Data1 = @("34","7","11","19")
            $Data2 = @("40","2","13","17")
            $dataSet1 = [dataSet]::New($Data1,"April")
            $dataSet1.backgroundColor = [Color]::blue
            $dataSet2 = [dataSet]::New($Data2,"Mai")
            $dataSet2.backgroundColor = [Color]::red
            $Labels = @("Closed","Unresolved","Pending","Open")
            
            New-PSHTMLBarChart -DataSet @($DataSet1,$dataSet2) -title "Bar chart" -Labels $Labels -canvasID $BarCanvasID

            New-PSHTMLPieChart -DataSet @($DataSet1,$dataSet2) -title "Pie chart" -Labels $Labels -canvasID $PieCanvasID

            New-PSHTMLLineChart -DataSet @($DataSet1,$dataSet2) -title "Line chart" -Labels $Labels -canvasID $lineCanvasID
        }

         
    }
}


$OutPath = "C:\Users\taavast3\OneDrive\Repo\Projects\OpenSource\PSHTML\PSHTML\Assets\Charts\3graphs.html"
$HTMLPage | out-file -FilePath $OutPath -Encoding utf8
start $outpath