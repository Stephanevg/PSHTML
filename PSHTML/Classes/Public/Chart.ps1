
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

Class ChartOption {

}

Class ChartDataSets {
    [System.Collections.ArrayList] $Data = @()
    [String]$Label
    [String] $xAxisID
    [String] $yAxisID
    [String[]]  $BackgroundColor = @()
    [String[]]  $Bordercolor = @()
    [int]    $BorderWidth
    [String] $BorderSkipped
    [Color]  $HoverBackGroundColor
    [Color]  $hoverBorderColor
    [int]    $hoverBorderWidth
}
Class ChartData {
    [System.Collections.ArrayList] $Labels = @()
    [ChartDataSets] $DataSets = [ChartDataSets]::New()
}

Class BarData : ChartData {
    
    
}

Class BarOptions : ChartOption {
    [int]$BarPercentage = 0.9
    [Int]$CategoryPercentage = 0.8
    [String]$BarThickness
    [Int]$MaxBarThickness
    [Bool] $OffSetGridLines = $true
}

Class BaseChart {
    [ChartType]$Type
    [ChartData]$Data
    [ChartOption]$Options
    Hidden [String]$Definition

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

    SetOptions([ChartOption]$Options){
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
                            #BeginAtZero [bool]
                            
        $Body = $this | select @{N='Type';E={$_.Type.ToString()}},Data,Options  | convertto-Json -Depth 4
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



Class BarChart : BaseChart{

    [ChartType] $Type = [ChartType]::bar
    
    BarChart(){
        #$Type = [ChartType]::bar

    }

    BarChart([ChartData]$Data,[ChartOption]$Options){
        $this.Data = $Data
        $This.Options = $Options
    }

}

Class PieData : ChartData {
    [Color]$BackGroundColor
    [Color]$BorderColor
    [int]$BorderWidth
    [Color]$HoverBackGroundColor
    [Color]$hoverBorderColor
    [int]$hoverBorderWidth
}

Class PieChart : BaseChart{

    $Type = [ChartType]::Pie

    PieChart([ChartData]$Data,[ChartOption]$Options){
        $this.Data = $Data
        $This.Options = $Options
    }

    
}



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

$Baroptions = [BarOptions]::New()
$BarData = [BarData]::New()

$BarChart = [BarChart]::New($BarData,$Baroptions)
$BarChart.Data.DataSets.Data.add(1)
$BarChart.Data.DataSets.Data.add(32)
$BarChart.Data.datasets.Data.add(24)
$BarChart.Data.DataSets.Label = "Salutions, this is my graph!"

$BarChart.Data.DataSets.BackgroundColor += [Color]::Orange
$BarChart.Data.DataSets.BackgroundColor += [Color]::Green
$BarChart.Data.DataSets.BackgroundColor += [Color]::blue

$BarChart.Data.DataSets.Bordercolor += [Color]::blue
$BarChart.Data.DataSets.Bordercolor += [Color]::Yellow
$BarChart.Data.DataSets.Bordercolor += [Color]::Red
$BarChart.Data.DataSets.BorderWidth = 1

$BarChart.Data.Labels.Add("Label1")
$BarChart.Data.Labels.Add("Label2")
$BarChart.Data.Labels.Add("Label3")

$CanvasID = "CanvasPlop"
$HTMLPage = html {
    head {
        title 'Chart JS Demonstration'
        
    }
    body {
        
         canvas -Height 500px -Width 500px -Id $CanvasID {

         }
         script -src "https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.3/Chart.min.js" -type "text/javascript"
         script -content {
            $BarChart.GetDefinition($CanvasID)
         }
         
    }
}


$OutPath = "C:\Users\taavast3\OneDrive\Repo\Projects\OpenSource\PSHTML\PSHTML\Assets\Charts\GraphCode.html"
$HTMLPage | out-file -FilePath $OutPath -Encoding utf8
start $outpath