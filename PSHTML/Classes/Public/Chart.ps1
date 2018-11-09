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
Class ChartData {

}

Class ChartOption {

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

    Hidden [String]GetDefinitionStart(){
        Return @"
        var ctx = document.getElementById("myChart").getContext('2d');
        var myChart = new Chart(ctx, {
"@
    }

    Hidden [String]GetDefinitionEnd(){
        Return @"
    });
"@
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
        
        $Body = @"
"@
        Return $Body
    }

    [String] GetDefinition(){
        $this.CalculateDefinition
        Return $this.Definition | convertto-Json
    }
}


Class PieProperties : ChartData {
    [Color]$BackGroundColor
    [Color]$BorderColor
    [int]$BorderWidth
    [Color]$HoverBackGroundColor
    [Color]$hoverBorderColor
    [int]$hoverBorderWidth
}

Class PieChart : Basechart{

    $Type = [ChartType]::Pie

    PieChart([ChartData]$Data,[ChartOption]$Options){
        $this.Data = $Data
        $This.Options = $Options
    }

    
}

Class BarData : ChartData {
    [System.Collections.ArrayList] $Label = @()
    [String] $xAxisID
    [String] $yAxisID
    [Color]  $BackgroundColor
    [Color]  $bordercolor
    [int]    $BorderWidth
    [String] $BorderSkipped
    [Color]  $HoverBackGroundColor
    [Color]  $hoverBorderColor
    [int]    $hoverBorderWidth
}

Class BarOptions : ChartOption {
    [int]$BarPercentage = 0.9
    [Int]$CategoryPercentage = 0.8
    [String]$BarThickness
    [Int]$MaxBarThickness
    [Bool] $OffSetGridLines = $true
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
$BarChart.Data.Label.add("eee")