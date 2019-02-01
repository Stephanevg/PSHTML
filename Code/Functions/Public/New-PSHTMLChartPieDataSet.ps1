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