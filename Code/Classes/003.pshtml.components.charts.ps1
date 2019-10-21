
#From Jakub Jares (Thanks!)
function Clear-WhiteSpace ($Text) {
    "$($Text -replace "(`t|`n|`r)"," " -replace "\s+"," ")".Trim()
}

Enum ChartType {
    bar
    horizontalBar
    line
    doughnut
    pie
    radar
    polarArea
}


#region dataSet
Class dataSet {
    [System.Collections.ArrayList] $data = @()
    [Array]$label

    dataSet(){
       
    }

    dataset([Array]$Data,[Array]$Label){
        
        if ( @( $Label ).Count -eq 1 ) {
            $this.SetLabel($Label)
        }
        else {
            foreach($l in $Label){
                $this.AddLabel($l)
            }
        }
        foreach($d in $data){
            $this.AddData($d)
        }
        
        
    }

    [void]AddLabel([Array]$Label){
        foreach($L in $Label){
            $null = $this.Label.Add($L)
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
    [string]  $backgroundColor
    [string]  $borderColor
    [int]    $borderWidth = 1
    [String] $borderSkipped
    [string]  $hoverBackgroundColor
    [string]  $hoverBorderColor
    [int]    $hoverBorderWidth

    datasetbar(){
       
    }

    datasetbar([Array]$Data,[Array]$Label){
        
        $this.SetLabel($Label)
        $this.AddData($Data)
        
    }
}

Class datasetRadar : dataset {
    [String] $xAxisID
    [String] $yAxisID
    [string]  $backgroundColor
    [string]  $borderColor
    [int]    $borderWidth = 1
    [String] $borderSkipped
    [string]  $hoverBackgroundColor
    [string]  $hoverBorderColor
    [int]    $hoverBorderWidth

    [String]$pointBackgroundColor = "rgba(0, 0, 0, 0.1)"
    [String]$pointBorderColor = "rgba(0, 0, 0, 0.1)"
    [Int[]]$pointBorderWidth = 1
    [float]$pointRadius = 4
    [ValidateSet("circle","cross","crossRot","dash","line","rect","rectRounded","rectRot","star","triangle")]
    $pointStyle = "circle"

    [int[]]$pointRotation
    [float]$pointHitRadius

    [String]  $PointHoverBackgroundColor
    [String]  $pointHoverBorderColor
    [int]    $pointHoverBorderWidth
    [float] $pointHoverRadius

    datasetRadar(){
       
    }

    datasetRadar([Array]$Data,[Array]$Label){
        
        $this.SetLabel($Label)
        $this.AddData($Data)
        
    }

    SetPointSettings([float]$pointRadius,[float]$pointHitRadius,[float]$pointHoverRadius,[string]$pointBackgroundColor,[string]$pointBorderColor){
        Write-Verbose "[DatasetLine][SetPointSettings] Start"
        $this.pointRadius = $pointRadius
        $this.pointHitRadius = $pointHitRadius
        $this.pointHoverRadius = $pointHoverRadius
        $this.pointBackgroundColor = $pointBackgroundColor
        $this.pointBorderColor = $pointBorderColor
        Write-Verbose "[DatasetLine][SetPointSettings] End"
    }

    [hashtable]GetPointSettings(){
        Write-Verbose "[DatasetLine][GetPointSettings] Start"
        return @{
            PointRadius = $this.pointRadius
            PointHitRadius = $this.pointHitRadius
            PointHoverRadius = $this.pointHoverRadius
            pointBackgroundColor = $this.pointBackgroundColor
            pointBorderColor = $this.pointBorderColor
        }
        Write-Verbose "[DatasetLine][GetPointSettings] End"
    }
}

Class datasetPolarArea : dataset {
    [Array]  $backgroundColor
    [Array]  $borderColor
    [int]    $borderWidth = 1
    [String] $borderSkipped
    [Array]  $hoverBackgroundColor
    [Array]  $hoverBorderColor
    [int]    $hoverBorderWidth

    datasetPolarArea(){
    
    }

    datasetPolarArea([Array]$Data,[Array]$Label){
        if ( @( $Label ).Count -gt 1 ) {
            $this.AddLabel($Label)
        }
        else {
            $this.SetLabel( @( $Label)[0] )
        }
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
    [float]$pointRadius = 4
    [ValidateSet("circle","cross","crossRot","dash","line","rect","rectRounded","rectRot","star","triangle")]
    $pointStyle = "circle"

    [int[]]$pointRotation
    [float]$pointHitRadius

    [String]  $PointHoverBackgroundColor
    [String]  $pointHoverBorderColor
    [int]    $pointHoverBorderWidth
    [float] $pointHoverRadius
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

    SetPointSettings([float]$pointRadius,[float]$pointHitRadius,[float]$pointHoverRadius){
        Write-Verbose "[DatasetLine][SetPointSettings] Start"
        $this.pointRadius = $pointRadius
        $this.pointHitRadius = $pointHitRadius
        $this.pointHoverRadius = $pointHoverRadius
        Write-Verbose "[DatasetLine][SetPointSettings] End"
    }

    [hashtable]GetPointSettings(){
        Write-Verbose "[DatasetLine][GetPointSettings] Start"
        return @{
            PointRadius = $this.pointRadius
            PointHitRadius = $this.pointHitRadius
            PointHoverRadius = $this.pointHoverRadius
        }
        Write-Verbose "[DatasetLine][GetPointSettings] End"
    }
}


Class datasetpie : dataset {


    [System.Collections.ArrayList]$backgroundColor
    [String]$borderColor = "white"
    [int]$borderWidth = 1
    [System.Collections.ArrayList]$hoverBackgroundColor
    $HoverBorderColor
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
    $HoverBorderColor
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

Class ChartAnimation {
    $onComplete = $null
}

Class ChartOptions  {
    [Int]$categoryPercentage = 0.8
    [bool]$responsive = $false
    [Bool] $offsetGridLines = $true
    [scales]$scales = [scales]::New()
    [ChartTitle]$title = [ChartTitle]::New()
    [ChartAnimation]$animation = [ChartAnimation]::New()

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
    [int]$barPercentage = 0.9
    [String]$barThickness
    [Int]$maxBarThickness
}

Class horizontalBarChartOptions : ChartOptions {

}

Class PieChartOptions : ChartOptions {

}

Class LineChartOptions : ChartOptions {
    [Bool] $showLines = $True
    [Bool] $spanGaps = $False
}

Class DoughnutChartOptions : ChartOptions {
    
}

Class RadarChartOptions : ChartOptions {
    [scales]$scales = $null
}

Class polarAreaChartOptions : ChartOptions {
    [scales]$scales = $null
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
<#

$Start = @"
var ctx = document.getElementById("$($CanvasID)").getContext('2d');
var myChart = new Chart(ctx, 
"@
#>
$Start = "var ctx = document.getElementById(`"$($CanvasID)`").getContext('2d');"
$Start = $Start + [Environment]::NewLine
$Start = $Start + "var myChart = new Chart(ctx, "
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

    [String] GetDefinition([String]$CanvasID,[Bool]$ToBase64){
        
        $FullDefintion = [System.Text.StringBuilder]::new()
        $FullDefintion.Append($this.GetDefinitionStart([String]$CanvasID))
        $FullDefintion.AppendLine($this.GetDefinitionBody())
        $FullDefintion.AppendLine($this.GetDefinitionEnd())
        $FullDefintion.AppendLine("function RemoveCanvasAndCreateBase64Image (){")
        $FullDefintion.AppendLine("var base64 = this.toBase64Image();")
        $FullDefintion.AppendLine("var element = this.canvas;")
        $FullDefintion.AppendLine("var parent = element.parentNode;")
        $FullDefintion.AppendLine("var img = document.createElement('img');")
        $FullDefintion.AppendLine("img.src = base64;")
        $FullDefintion.AppendLine("img.name = element.id;")
        $FullDefintion.AppendLine("element.before(img);")
        $FullDefintion.AppendLine("parent.removeChild(element);")
        $FullDefintion.AppendLine("document.getElementById('pshtml_script_chart_$canvasid').parentNode.removeChild(document.getElementById('pshtml_script_chart_$canvasid'))")
        $FullDefintion.AppendLine("};")
        $FullDefintion.replace('"RemoveCanvasAndCreateBase64Image"','RemoveCanvasAndCreateBase64Image')
        
        <# somewhere along the line, we will need to remove script tags associated to the charts creation ... in order to send it to mail
        //var scripttags = document.getElementsByTagName('script');
        //var scripttags = document.getElementsByTagName('script');
        //for (i=0;i<scripttags.length;){
        //    var parent = scripttags[i].parentNode;
        //    parent.removeChild(scripttags[i]);
        //}
        };
        #>
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

Class horizontalBarChart : Chart{

    [ChartType] $type = [ChartType]::horizontalBar
    
    horizontalBarChart(){
        #$Type = [ChartType]::bar

    }

    horizontalBarChart([ChartData]$Data,[ChartOptions]$Options){
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

Class RadarChart : Chart{

    [ChartType] $type = [ChartType]::radar
    
    RadarChart(){
        #$Type = [ChartType]::bar

    }

    RadarChart([ChartData]$Data,[ChartOptions]$Options){
        $this.data = $Data
        $This.options = $Options
    }

}

Class polarAreaChart : Chart{

    [ChartType] $type = [ChartType]::polarArea
    
    polarAreaChart(){
        #$Type = [ChartType]::bar

    }

    polarAreaChart([ChartData]$Data,[ChartOptions]$Options){
        $this.data = $Data
        $This.options = $Options
    }

}




#endregion


