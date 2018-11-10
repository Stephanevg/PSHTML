

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
    [System.Collections.ArrayList] $data = @()
    [String]$label
    [String] $xAxisID
    [String] $yAxisID
    [System.Collections.ArrayList]  $backgroundColor = @()
    [System.Collections.ArrayList]  $borderColor = @()
    [int]    $borderWidth
    [String] $borderSkipped
    [Color]  $hoverBackgroundColor
    [Color]  $hoverBorderColor
    [int]    $hoverBorderWidth
}
Class ChartData {
    [System.Collections.ArrayList] $labels = @()
    [ChartDataSets[]] $datasets = [ChartDataSets]::New()
}

Class BarData : ChartData {
    
    
}

Class scales {
    [System.Collections.ArrayList]$yAxes = @()
    [System.Collections.ArrayList]$xAxes = @()

    scales(){

        $this.yAxes.Add(@{"ticks"=@{"beginAtZero"=$true}})
    }
}

Class BarOptions : ChartOption {
    [int]$barPercentage = 0.9
    [Int]$categoryPercentage = 0.8
    [bool]$responsive = $false
    [String]$barThickness
    [Int]$maxBarThickness
    [Bool] $offsetGridLines = $true
    [scales]$scales = [scales]::New()
}



Class BaseChart {
    [ChartType]$type
    [ChartData]$data
    [ChartOption]$options
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



Class BarChart : BaseChart{

    [ChartType] $type = [ChartType]::bar
    
    BarChart(){
        #$Type = [ChartType]::bar

    }

    BarChart([ChartData]$Data,[ChartOption]$Options){
        $this.data = $Data
        $This.options = $Options
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

    $type = [ChartType]::Pie

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
$BarChart.Data.DataSets[0].Data.add(4)
$BarChart.Data.DataSets[0].Data.add(23)
$BarChart.Data.DataSets[0].Data.add(32)
$BarChart.Data.datasets[0].Data.add(24)
$BarChart.Data.datasets[0].Data.add(78)
$BarChart.Data.DataSets[0].Label = "Salutaions, this is my graph!"

$BarChart.Data.DataSets[0].BackgroundColor.Add([Color]::Orange)
$BarChart.Data.DataSets[0].BackgroundColor.Add([Color]::Red)
$BarChart.Data.DataSets[0].BackgroundColor.Add([Color]::Green)
$BarChart.Data.DataSets[0].BackgroundColor.Add([Color]::Yellow)
$BarChart.Data.DataSets[0].BackgroundColor.Add([Color]::blue)

$BarChart.Data.DataSets[0].Bordercolor.Add([Color]::blue)
$BarChart.Data.DataSets[0].Bordercolor.Add([Color]::Yellow)
$BarChart.Data.DataSets[0].Bordercolor.Add([Color]::Red)
$BarChart.Data.DataSets[0].Bordercolor.Add([Color]::blue)
$BarChart.Data.DataSets[0].Bordercolor.Add([Color]::Yellow)
$BarChart.Data.DataSets[0].BorderWidth = 1

$BarChart.Data.Labels.Add("Label1")
$BarChart.Data.Labels.Add("Label2")
$BarChart.Data.Labels.Add("Label3")
$BarChart.Data.Labels.Add("Label4")
$BarChart.Data.Labels.Add("Label5")

$CanvasID = "CanvasPlop"
$HTMLPage = html { 
    head {
        title 'Chart JS Demonstration'
        
    }
    body {
        
         canvas -Height 400px -Width 400px -Id $CanvasID {

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