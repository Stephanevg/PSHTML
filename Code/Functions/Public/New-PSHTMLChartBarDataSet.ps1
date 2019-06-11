function New-PSHTMLChartBarDataSet {
    <#
    .SYNOPSIS
        Create a dataset object for a Bar chart
    .DESCRIPTION
        Use this function to generate a Dataset for a bar chart. 
        It allows to specify options such as, the label name, Background / border / hover colors etc..
    .EXAMPLE
       
    .PARAMETER Data
        Specify an array of values.
        ex: @(3,5,42,69)
    .PARAMETER Label
        Name of the dataset
    .PARAMETER xAxisID
        X axis ID 
    .PARAMETER yAxisID
        Y axis ID 
    .PARAMETER BackgroundColor
        The background color of the bar chart values.
        Use either: [Color] to generate a color,
        Or specify directly one of the following formats:
        RGB(120,240,50)
        RGBA(120,240,50,0.4)
    .PARAMETER BorderColor
        The border color of the bar chart values.
        Use either: [Color] to generate a color,
        Or specify directly one of the following formats:
        RGB(120,240,50)
        RGBA(120,240,50,0.4)
    .PARAMETER BorderWidth
        expressed in px's
    .PARAMETER BorderSkipped
        border is skipped

    .PARAMETER HoverBorderColor
        The HoverBorder color of the bar chart values.
        Use either: 
        [Color] to generate a color,
        Or specify directly one of the following formats:
        RGB(120,240,50)
        RGBA(120,240,50,0.4)
    .EXAMPLE
            $Data1 = @(34,7,11,19)
            $dsb1 = New-PSHTMLChartBarDataSet -Data $data1 -label "March" -BackgroundColor ([Color]::Orange)

            #Dataset containg data from 'March'
            
    .EXAMPLE

            $Data2 = @(40,2,13,17)
            $dsb2 = New-PSHTMLChartBarDataSet -Data $data2 -label "April" -BackgroundColor ([Color]::red)

            #DataSet Containg data from 'April'
    
    .OUTPUTS
        DataSetBar
    .NOTES
        Made with love by Stephanevg
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [CmdletBinding()]
    [OutputType([datasetBar])]
    param (
        [Array]$Data,
        [String]$label,
        [String] $xAxisID,
        [String] $yAxisID,
        [String]  $backgroundColor,
        [String]  $borderColor,
        [int]    $borderWidth = 1,
        [String] $borderSkipped,
        [String]  $hoverBackgroundColor,
        [String]  $hoverBorderColor,
        [int]    $hoverBorderWidth
        

    )
    
    $Datachart = [datasetBar]::New()

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
    if ($borderWidth){
        $Datachart.borderWidth = $borderWidth
    }

    if($borderSkipped){
        $Datachart.borderSkipped = $borderSkipped
    }

    If($hoverBackgroundColor){
        $Datachart.hoverBackgroundColor = $hoverBackgroundColor
    }
    
    If($HoverBorderColor){
        $Datachart.hoverBorderColor = $HoverBorderColor
    }
    if($HoverBorderWidth){
        $Datachart.HoverBorderWidth = $HoverBorderWidth
    }

    return $Datachart
}