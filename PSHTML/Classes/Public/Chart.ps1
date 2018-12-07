<#
Class PieData : ChartData {
    [Color]$BackGroundColor
    [Color]$BorderColor
    [int]$BorderWidth
    [Color]$HoverBackGroundColor
    [Color]$hoverBorderColor
    [int]$hoverBorderWidth
}

Class PieChart : Chart{

    $type = [ChartType]::Pie

    PieChart([ChartData]$Data,[ChartOption]$Options){
        $this.Data = $Data
        $This.Options = $Options
    }

    
}
#>

##end of pie

import-module C:\Users\taavast3\OneDrive\Repo\Projects\OpenSource\PSHTML\PSHTML\PSHTML.psd1

Enum ChartType {
    bar
    line
    doughnut
    pie
}

Class Color {
    static [String] $blue = "rgb(30,144,255)"
    static [String] $red = "rgb(220,20,60)"
    static [string] $Yellow = "rgb(255,255,0)"
    static [string] $Green = "rgb(173,255,47)"
    static [string] $Orange = "rgb(255,165,0)"
    static [string] $Black = "rgb(0,0,0)"
    static [string] $White = "rgb(255,255,255)"

    static [string] rgb([int]$r,[int]$g,[int]$b){
        return "rgb({0},{1},{2})" -f $r,$g,$b
    }
    static [string] rgba([int]$r,[int]$g,[int]$b,[double]$a){
        return "rgba({0},{1},{2},{3})" -f $r,$g,$b,$a
    }
}

#region dataSet
Class dataSet {
    [System.Collections.ArrayList] $data = @()
    [String]$label

    dataSet(){
       
    }

    dataset([Array]$Data,[String]$Label){
        
        $this.SetLabel($Label)
        foreach($d in $data){
            $this.AddData($d)
        }
        
        
    }

    [void]SetLabel([String]$Label){
        $this.label = $Label
    }

    [void]AddData([Array]$Data){
        foreach($D in $Data){
            $null = $this.data.Add($d)
        }
    }
}

Class datasetbar : dataset {
    [String] $xAxisID
    [String] $yAxisID
    [String]  $backgroundColor
    [String]  $borderColor
    [int]    $borderWidth = 1
    [String] $borderSkipped
    [String]  $hoverBackgroundColor
    [String]  $hoverBorderColor
    [int]    $hoverBorderWidth

    datasetbar(){
       
    }

    datasetbar([Array]$Data,[String]$Label){
        
        $this.SetLabel($Label)
        $this.AddData($Data)
        
    }
}

function New-PSHTMLChartBarDataSet {
    <#
    .SYNOPSIS
        Create a dataset object for a Bar chart
    .DESCRIPTION
        Create a dataset object for a Bar chart
    .EXAMPLE
       
    .INPUTS
        Inputs (if any)
    .OUTPUTS
        DataSetLine
    .NOTES
    
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [CmdletBinding()]
    param (
        [Array]$Data,
        [String]$label,
        [String] $xAxisID,
        [String] $yAxisID,
        [String]  $backgroundColor,
        [String]  $borderColor,
        [int]    $borderWidth = 1,
        [String] $borderSkipped,
        [String]  $hoverBackgroundColor,
        [String]  $hoverBorderColor,
        [int]    $hoverBorderWidth
        

    )
    
    $Datachart = [datasetBar]::New()

    if($Data){
        $null = $Datachart.AddData($Data)
    }

    If($Label){
        $Datachart.label = $label
    }

    if($xAxisID){
        $Datachart.xAxisID = $xAxisID
    }

    if($yAxisID){
        $Datachart.yAxisID = $yAxisID
    }

    if($backgroundColor){
        $Datachart.backgroundColor = $backgroundColor
    }

    If($borderColor){
        $Datachart.borderColor = $borderColor
    }
    if ($borderWidth){
        $Datachart.borderWidth = $borderWidth
    }

    if($borderSkipped){
        $Datachart.borderSkipped = $borderSkipped
    }

    If($hoverBackgroundColor){
        $Datachart.hoverBackgroundColor = $hoverBackgroundColor
    }
    
    If($HoverBorderColor){
        $Datachart.hoverBorderColor = $HoverBorderColor
    }
    if($HoverBorderWidth){
        $Datachart.HoverBorderWidth = $HoverBorderWidth
    }

    return $Datachart
}

Class datasetline : dataset{
    #See https://www.chartjs.org/docs/latest/charts/line.html
    #[String] $xAxisID
    #[String] $yAxisID

    [String]  $backgroundColor
    [String]  $borderColor
    [int]    $borderWidth = 1
    [int[]]    $borderDash = 0
    [int]    $borderDashOffSet = 0

    [ValidateSet("butt","round","square")]
    [String]    $borderCapStyle

    [ValidateSet("bevel","round","miter")]
    [String]    $borderJoinStyle

    [ValidateSet("default","monotone")]
    [String] $cubicInterpolationMode = "default"
    [Bool] $fill = $false
    [double]$lineTension = 0.5 #Stepped line should not be present, for this one to work.
    
    $pointBackgroundColor = "rgb(255,255,255)"
    $pointBorderColor = "rgb(0,0,0)"
    [Int[]]$pointBorderWidth = 1
    [Int]$pointRadius = 4
    [ValidateSet("circle","cross","crossRot","dash","line","rect","rectRounded","rectRot","star","triangle")]
    $pointStyle = "circle"

    [int[]]$pointRotation
    [int[]]$pointHitRadius

    [String]  $PointHoverBackgroundColor
    [String]  $pointHoverBorderColor
    [int]    $pointHoverBorderWidth
    [int] $pointHoverRadius
    [bool]$showLine = $true
    [bool]$spanGaps

    #[ValidateSet("true","false","before","after")]
    #[String] $steppedLine = 'false' #Had to remove it, otherwise lines could not be rounded. It would ignore the $LineTension settings, even when set to false

    datasetline(){

    }

    datasetline([Array]$Data,[String]$Label){
        Write-verbose "[DatasetLine][Instanciation]Start"
        $this.SetLabel($Label)
        $this.AddData($Data)
        Write-verbose "[DatasetLine][Instanciation]End"
    }

    SetLineColor([String]$Color,[Bool]$Fill){
        Write-verbose "[DatasetLine][SetLineColor] Start"
        $this.borderColor = $Color
        $this.backgroundColor = $Color
        if($Fill){
           $this.SetLineBackGroundColor($Color)
        }
        Write-verbose "[DatasetLine][SetLineColor] End"
    }

    SetLineBackGroundColor(){
        Write-verbose "[DatasetLine][SetLineBackGroundColor] Start"
        #Without any color parameter, this will take the existing line color, and simply add 0.4 of alpha to it for the background color
        if(!($this.borderColor)){
            $t = $this.borderColor
            $this.fill = $true
            $t = $t.replace("rgb","rgba")
            $backgroundC = $t.replace(")",",0.4)")
            $this.backgroundColor = $backgroundC
        }
        Write-verbose "[DatasetLine][SetLineBackGroundColor] End"
    }

    SetLineBackGroundColor([String]$Color){
        #this will take the color, and add 0.4 of alpha to it for the background color
        Write-verbose "[DatasetLine][SetLineBackGroundColor] Start"
        $this.fill = $true
        $t = $Color
        $t = $t.replace("rgb","rgba")
        $backgroundC = $t.replace(")",",0.4)")
        $this.backgroundColor = $backgroundC
        Write-verbose "[DatasetLine][SetLineBackGroundColor] End"
    }
}

function New-PSHTMLChartLineDataSet {
    <#
    .SYNOPSIS
        Create a dataset object for a Line chart
    .DESCRIPTION
        Create a dataset object for a Line chart
     .PARAMETER FillbackgroundColor
        Allows to specify the background color between the line and the X axis.
        This should not be used in conjunction with FillBackGround 
    .PARAMETER Fillbackground
        fillBackground allows to specify that color should be added between the line and the X Axis.
        The color will be the Line color, whi
    .EXAMPLE
       
    .NOTES
    
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [CmdletBinding()]
    param (
        [String]$LineColor,
        [String]$label,
        [Color]  $FillbackgroundColor,
        [int]    $LineWidth = 1,
        [int[]]    $LineDash = 0,
        [int]    $LineDashOffSet = 0,
        [Array]$Data,
        [Switch]$FillBackground,
        
        [ValidateSet("rounded","Straight")]
        $LineChartType = "rounded",

        [ValidateSet("Full","Dashed")]
        $LineType = "Full"

    )
    
    $Datachart = [datasetline]::New()
    
    
    if($Data){
        $Null = $Datachart.AddData($Data)
    }


    if($lineType -eq "Dashed"){
        $datachart.borderDash = 10
    }

    if($Label){
        $Datachart.label = $label
    }

    if($LineWidth){
        $Datachart.borderWidth = $LineWidth
    }

    if($LineDash){
        $Datachart.borderDash = $LineDash
    }

    if($LineDashOffSet){
        $Datachart.borderDashOffSet = $LineDashOffSet
    }

    if($LineColor){
        $DataChart.SetLineColor($LineColor,$false)
        $Datachart.PointHoverBackgroundColor = $LineColor
        
    }





    if($FillBackground){
        $Datachart.SetLineBackGroundColor()
    }
    if($FillbackgroundColor){
        $Datachart.SetLineBackGroundColor($FillbackgroundColor)
    }

    if($LineChartType){
        switch($LineChartType){
            "rounded"{
                $Datachart.lineTension = 0.5
                ;Break
            }
            "Straight"{
                $Datachart.lineTension = 0
                ;break
            }
        }
    }

    Return $Datachart
}

Class datasetpie : dataset {


    [System.Collections.ArrayList]$backgroundColor
    [String]$borderColor = "white"
    [int]$borderWidth = 1
    [System.Collections.ArrayList]$hoverBackgroundColor
    [Color]$HoverBorderColor
    [int]$HoverBorderWidth

    datasetpie(){

    }

    datasetpie([Array]$Data,[String]$ChartLabel){
        Write-verbose "[DatasetPie][Instanciation]Start"
        $this.SetLabel($ChartLabel)
        $this.AddData($Data)
        Write-verbose "[DatasetPie][Instanciation]End"
    }

    AddBackGroundColor($Color){
        if($null -eq $this.backgroundColor){
            $this.backgroundColor = @()
        }
        $this.backgroundColor.Add($Color)
    }

    AddBackGroundColor([Array]$Colors){
        
        foreach($c in $Colors){
            $this.AddBackGroundColor($c)
        }
        
    }

    AddHoverBackGroundColor($Color){
        if($null -eq $this.HoverbackgroundColor){
            $this.HoverbackgroundColor = @()
        }
        $this.HoverbackgroundColor.Add($Color)
    }

    AddHoverBackGroundColor([Array]$Colors){
        foreach($c in $Colors){
            $this.AddHoverBackGroundColor($c)
        }
        
    }

}

function New-PSHTMLChartPieDataSet {
    <#
    .SYNOPSIS
        Create a dataset object for a Pie chart
    .DESCRIPTION
        Create a dataset object for a Line chart
    .EXAMPLE
       
    .INPUTS
        Inputs (if any)
    .OUTPUTS
        DataSetLine
    .NOTES
    
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [CmdletBinding()]
    param (
        [Array]$Data,
        [String]$label,
        [array]$backgroundColor,
        [String]$borderColor,
        [int]$borderWidth = 1,
        [array]$hoverBackgroundColor,
        [string]$HoverBorderColor,
        [int]$HoverBorderWidth
        

    )
    
    $Datachart = [datasetPie]::New()

    if($Data){
        $null = $Datachart.AddData($Data)
    }

    If($Label){
        $Datachart.label = $label
    }

    if($backgroundColor){
        $Datachart.AddBackGroundColor($backgroundColor)
        #$Datachart.backgroundColor = $backgroundColor
    }

    If($borderColor){
        $Datachart.borderColor = $borderColor
    }
    if ($borderWidth){
        $Datachart.borderWidth = $borderWidth
    }

    If($hoverBackgroundColor){
        $Datachart.AddHoverBackGroundColor($hoverBackgroundColor)
        #$Datachart.hoverBackgroundColor = $hoverBackgroundColor
    }else{
        $Datachart.AddHoverBackGroundColor($backgroundColor)
    }

    if($HoverBorderColor){
        $Datachart.HoverBorderColor = $HoverBorderColor
    }

    if ($HoverborderWidth){
        $Datachart.HoverBorderWidth = $HoverborderWidth
    }

    return $Datachart
}

Class datasetDoughnut : dataset {

    [System.Collections.ArrayList]$backgroundColor
    [String]$borderColor = "white"
    [int]$borderWidth = 1
    [System.Collections.ArrayList]$hoverBackgroundColor
    [Color]$HoverBorderColor
    [int]$HoverBorderWidth

    datasetpie(){

    }

    datasetpie([Array]$Data,[String]$ChartLabel){
        Write-verbose "[DatasetDoughnut][Instanciation]Start"
        $this.SetLabel($ChartLabel)
        $this.AddData($Data)
        Write-verbose "[DatasetDoughnut][Instanciation]End"
    }

    AddBackGroundColor($Color){
        if($null -eq $this.backgroundColor){
            $this.backgroundColor = @()
        }
        $this.backgroundColor.Add($Color)
    }

    AddBackGroundColor([Array]$Colors){
        
        foreach($c in $Colors){
            $this.AddBackGroundColor($c)
        }
        
    }

    AddHoverBackGroundColor($Color){
        if($null -eq $this.HoverbackgroundColor){
            $this.HoverbackgroundColor = @()
        }
        $this.HoverbackgroundColor.Add($Color)
    }

    AddHoverBackGroundColor([Array]$Colors){
        foreach($c in $Colors){
            $this.AddHoverBackGroundColor($c)
        }
        
    }

}

function New-PSHTMLChartDoughnutDataSet {
    <#
    .SYNOPSIS
        Create a dataset object for a dougnut chart
    .DESCRIPTION
        Create a dataset object for a dougnut chart

    .PARAMETER HoverBordercolor
        Accepts RGB values:
        Examples: RGB(255,255,0)

        Accepts RGBA values:
        Examples: RGBA(255,255,0,0.4)

        Accept color names:

        (Must be a lower case values)
        
        Examples:
        white,black,orange,red,blue,green,gray,cyan


    .EXAMPLE
       
    .INPUTS
        Inputs (if any)
    .OUTPUTS
        DataSetLine
    .NOTES
    
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [CmdletBinding()]
    param (
        [Array]$Data,
        [String]$label,
        [Array]$backgroundColor,
        [String]$borderColor,
        [int]$borderWidth = 1,
        [Array]$hoverBackgroundColor,
        [Array]$HoverBorderColor,
        [int]$HoverBorderWidth
        

    )
    
    $Datachart = [datasetdoughnut]::New()

    if($Data){
        $Null =$Datachart.AddData($Data)
    }

    If($Label){
        $Datachart.label = $label
    }

    if($backgroundColor){
        $Datachart.AddBackGroundColor($backgroundColor)
        #$Datachart.backgroundColor = $backgroundColor
    }

    If($borderColor){
        $Datachart.borderColor = $borderColor
    }
    if ($borderWidth){
        $Datachart.borderWidth = $borderWidth
    }

    If($hoverBackgroundColor){
        $Datachart.AddHoverBackGroundColor($hoverBackgroundColor)
        #$Datachart.hoverBackgroundColor = $hoverBackgroundColor
    }else{
        $Datachart.AddHoverBackGroundColor($backgroundColor)
    }
    
    If($HoverBorderColor){
        $Datachart.hoverBorderColor = $HoverBorderColor
    }
    if($HoverBorderWidth){
        $Datachart.HoverBorderWidth = $HoverBorderWidth
    }

    return $Datachart
}

#endregion


#region Configuration&Options

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

#endregion

#region Charts

Class BarChartOptions : ChartOptions {

}

Class PieChartOptions : ChartOptions {

}

Class LineChartOptions : ChartOptions {
    [Bool] $showLines = $True
    [Bool] $spanGaps = $False
}

Class DoughnutChartOptions : ChartOptions {
    
}

Class ChartData {
    [System.Collections.ArrayList] $labels = @()
    [System.Collections.ArrayList] $datasets = @()
    #[DataSet[]] $datasets = [dataSet]::New()

    ChartData(){
        #$this.datasets = [dataSet]::New()
        $this.datasets.add([dataSet]::New())
    }

    AddDataSet([DataSet]$Dataset){
        #$this.datasets += $Dataset
        $this.datasets.Add($Dataset)
    }

    SetLabels([Array]$Labels){
        Foreach($l in $Labels){

            $Null = $this.labels.Add($l)
        }
    }

}

Class BarData : ChartData {
    
    
}

Class Chart {
    [ChartType]$type
    [ChartData]$data
    [ChartOptions]$options
    Hidden [String]$definition

    Chart(){
        $Currenttype = $this.GetType()

        if ($Currenttype -eq [Chart])
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

Class BarChart : Chart{

    [ChartType] $type = [ChartType]::bar
    
    BarChart(){
        #$Type = [ChartType]::bar

    }

    BarChart([ChartData]$Data,[ChartOptions]$Options){
        $this.data = $Data
        $This.options = $Options
    }

}

Class LineChart : Chart{

    [ChartType] $type = [ChartType]::line
    
    LineChart(){
        #$Type = [ChartType]::bar

    }

    LineChart([ChartData]$Data,[ChartOptions]$Options){
        $this.data = $Data
        $This.options = $Options
    }

}

Class PieChart : Chart{

    [ChartType] $type = [ChartType]::pie
    
    PieChart(){
        

    }

    PieChart([ChartData]$Data,[ChartOptions]$Options){
        $this.data = $Data
        $This.options = $Options
    }

}

Class doughnutChart : Chart {
    [ChartType] $type = [ChartType]::doughnut
    
    DoughnutChart(){
        
    }

    DoughnutChart([ChartData]$Data,[ChartOptions]$Options){
        $this.data = $Data
        $This.options = $Options
    }
}


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
        [ChartType]$Type,

        [Parameter(Mandatory=$true)]
        [dataSet[]]$DataSet,

        [Parameter(Mandatory=$true)]
        [String[]]
        $Labels,


        [Parameter(Mandatory=$true)]
        [String]$CanvasID,

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
        $ChartOptions = [ChartOptions]::New()
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


#endregion


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
       

