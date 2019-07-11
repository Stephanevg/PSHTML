function New-PSHTMLChartPolarAreaDataSet {
    <#
    .SYNOPSIS
        Create a dataset object for a PolarArea chart
    .DESCRIPTION
        Use this function to generate a Dataset for a PolarArea chart. 
        It allows to specify options such as, the label name, Background / border / hover colors etc..
    .EXAMPLE
       
    .PARAMETER Data
        Specify an array of values.
        ex: @(3,5,42,69)

    .PARAMETER Label
        this String Array defines the labels

    .PARAMETER BackgroundColor
        The background colors of the PolarArea chart values.
        
        Use either: [Color] to generate a color,
        Or specify directly one of the following formats:
        RGB(120,240,50)
        RGBA(120,240,50,0.4)

    .PARAMETER BorderColor
        The border colors of the PolarArea chart values.

        Use either: [Color] to generate a color,
        Or specify directly one of the following formats:
        RGB(120,240,50)
        RGBA(120,240,50,0.4)

    .PARAMETER BorderWidth
        expressed in px's

    .PARAMETER BorderSkipped
        border is skipped

    .PARAMETER HoverBorderColor
        The HoverBorder color of the PolarArea chart values.
        Use either: 
        [Color] to generate a color,
        Or specify directly one of the following formats:
        RGB(120,240,50)
        RGBA(120,240,50,0.4)

    .EXAMPLE
            $Labels = @('red', 'green', 'yellow', 'grey', 'blue')
            $BackgroundColor = @('red', 'green', 'yellow', 'grey', 'blue')
            $Data1 = @(34,7,11,19,12)
            $dsb1 = New-PSHTMLChartPolarAreaDataSet -Data $data1 -label $Labels -BackgroundColor $BackgroundColor

            
    .OUTPUTS
        DataSetPolarArea

    .NOTES
        Made with love by Stephanevg

    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [CmdletBinding()]
    [OutputType([datasetPolarArea])]
    param (
        [Array]  $Data,
        [Array]  $label,
        [Array]  $backgroundColor,
        [Array]  $borderColor,
        [int]    $borderWidth = 1,
        [String] $borderSkipped,
        [Array]  $hoverBackgroundColor,
        [Array]  $hoverBorderColor,
        [int]    $hoverBorderWidth
        

    )
    
    $Datachart = [datasetPolarArea]::New()
    
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
    else {
        $Datachart.borderColor = ''
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
    else {
        $Datachart.hoverBackgroundColor = ''
    }
    
    If($HoverBorderColor){
        $Datachart.hoverBorderColor = $HoverBorderColor
    }
    else {
        $Datachart.hoverBorderColor = ''
    }
    if($HoverBorderWidth){
        $Datachart.HoverBorderWidth = $HoverBorderWidth
    }

    return $Datachart
}