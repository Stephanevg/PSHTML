
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
