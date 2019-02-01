
#From Jakub Jares (Thanks!)
function Clear-WhiteSpace ($Text) {
    "$($Text -replace "(`t|`n|`r)"," " -replace "\s+"," ")".Trim()
}

Enum ChartType {
    bar
    line
    doughnut
    pie
}

Class Color {
    [int]$r
    [int]$g
    [int]$b
    [double]$a

    color([int]$r,[int]$g,[int]$b){
        $this.r = $r
        $this.g = $g
        $this.b = $b
    }

    color([int]$r,[int]$g,[int]$b,[double]$a){
        $this.r = $r
        $this.g = $g
        $this.b = $b
        $this.a = $a
    }

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

Class datasetDoughnut : dataset {

    [System.Collections.ArrayList]$backgroundColor
    [String]$borderColor = "white"
    [int]$borderWidth = 1
    [System.Collections.ArrayList]$hoverBackgroundColor
    [Color]$HoverBorderColor
    [int]$HoverBorderWidth

    datasetDoughnut(){

    }

    datasetDoughnut([Array]$Data,[String]$ChartLabel){
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

#endregion


#region Configuration&Options

Class scales {
    [System.Collections.ArrayList]$yAxes = @()
    [System.Collections.ArrayList]$xAxes = @("")

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
            throw("Class $($Currenttype) must be inherited")
        }
    }

    SetData([ChartData]$Data){
        $this.Data = $Data
    }

    SetOptions([ChartOptions]$Options){
        $this.Options = $Options
    }

    #Is this actually used? Could be removed?
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
                            
        $Body = $this | select @{N='type';E={$_.type.ToString()}},Data,Options  | convertto-Json -Depth 6 -Compress
        $BodyCleaned =  Clear-WhiteSpace $Body
        Return $BodyCleaned
    }

    [String] GetDefinition([String]$CanvasID){
        
        $FullDefintion = [System.Text.StringBuilder]::new()
        $FullDefintion.Append($this.GetDefinitionStart([String]$CanvasID))
        $FullDefintion.AppendLine($this.GetDefinitionBody())
        $FullDefintion.AppendLine($this.GetDefinitionEnd())
        $FullDefintionCleaned = Clear-WhiteSpace $FullDefintion
        return $FullDefintionCleaned
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




#endregion


