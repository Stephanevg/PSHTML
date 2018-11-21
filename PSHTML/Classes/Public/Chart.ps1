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
    [Color]  $hoverBackgroundColor
    [Color]  $hoverBorderColor
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


Class scales {
    [System.Collections.ArrayList]$yAxes = @()
    [System.Collections.ArrayList]$xAxes = @()

    scales(){

        $this.yAxes.Add(@{"ticks"=@{"beginAtZero"=$true}})
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
    

        $Searcher = New-Object -ComObject Microsoft.Update.Searcher;                                      
        $Searcher.GetTotalHistoryCount()                                            
        $AllUpdatesInstalled = $Searcher.GetTotalHistoryCount()                     
        $Updates = $Searcher.QueryHistory(0,$AllUpdatesInstalled)


    <# foreach($Cdata in $BarChartdata){

        
        if($Count -ge 1){

            $Null = $BarChart.data.Datasets +=([DataSet]::new())
        }
        $BarChart.Data.DataSets[$count].Label =$Cdata.Label
        $null = $BarChart.Data.DataSets[$Count].BackgroundColor.Add($Cdata.BackGroundColor)
        $null = $BarChart.Data.DataSets[$Count].borderColor.Add($Cdata.BorderColor)

        $null = $BarChart.Data.DataSets[$Count].Data.add($Cdata.data)
        foreach($d in $Cdata.data){
            
        }
        $count++
    } #>

    return $BarChart.GetDefinition($CanvasID)
    
}


#New-PSHTMLBarChart -DataSet $DataSet -Labels $Labels -canvasID $CanvasID
#see for inspiration: https://codepen.io/Shokeen/pen/NpgbKg?editors=1010


#BarChart
    #DataSet
    #Labels
    #ChartData
    
<# 
$Data +=[BarChartData]::New(5,'January',"Dataset1",[Color]::Yellow,[Color]::red)
$Data +=[BarChartData]::New(8,'January',"Dataset2",[Color]::Blue,[Color]::red)
$Data +=[BarChartData]::New(7,'march',"Dataset2",[Color]::Green,[Color]::red)
$Data +=[BarChartData]::New(14,'march',"Dataset1",[Color]::Orange,[Color]::blue) #>
<#
#Vert beau 'rgba(99, 132, 0, 0.6)'
#Blue beau 'rgba(0, 99, 132, 0.6)'
$Data +=[BarChartData]::New(2,"two")
$Data +=[BarChartData]::New(3,"three")
$Data +=[BarChartData]::New(4,"Four")

$Data2 = @()
$Data2 +=[BarChartData]::New(5,"five")
$Data2 +=[BarChartData]::New(6,"six")
$Data2 +=[BarChartData]::New(7,"seven")
$Data2 +=[BarChartData]::New(8,"eight") #>
#$d = $Data + $Data2

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

<# $Baroptions = [ChartOptions]::New()
$BarData = [BarData]::New()

$BarChart = [BarChart]::New($BarData,$Baroptions)
$ar = @(1,3,4,2,5,9)
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
$BarChart.Data.Labels.Add("Label5") #>


$HTMLPage = html { 
    head {
        title 'Chart JS Demonstration'
        
    }
    body {
        
        h1 "PSHTML Graph"

        div {

           p {
               "This is my graph"
           }
           canvas -Height 400px -Width 400px -Id $CanvasID {
    
           }
       }

         script -src "https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.3/Chart.min.js" -type "text/javascript"


        script -content {
            $Data1 = @("4","7","11","21")
            $Data2 = @("7","2","13","17")
            $dataSet1 = [dataSet]::New($Data1,"Dataset1")
            $dataSet1.backgroundColor = [Color]::blue
            $dataSet2 = [dataSet]::New($Data2,"Dataset2")
            $dataSet2.backgroundColor = [Color]::red
            $Labels = @("Wins","Looses","Draws","Give ups")
            $CanvasID = "CanvasPlop"
            New-PSHTMLBarChart -DataSet @($DataSet1,$dataSet2) -title "New graph yes" -Labels $Labels -canvasID $CanvasID
        }

         
    }
}


$OutPath = "C:\Users\taavast3\OneDrive\Repo\Projects\OpenSource\PSHTML\PSHTML\Assets\Charts\GraphCode.html"
$HTMLPage | out-file -FilePath $OutPath -Encoding utf8
start $outpath