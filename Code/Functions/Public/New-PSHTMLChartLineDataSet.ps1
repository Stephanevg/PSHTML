
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