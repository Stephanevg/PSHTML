Function New-PSHTMLChartDataSet {
    <#
    .SYNOPSIS
        Creates a data set for any type of chart
    .DESCRIPTION
        This cmdlet must be used to format the data set to get data in correct fromat for any of the New-PSHTMLChart* cmdlets.

    .PARAMETER Name
        Name of the dataset.
    
    .PARAMETER Data
        Array of values 

    .EXAMPLE
        #Creating a simple dataset
         $Data = @("4","7","11","21")

         New-PSHTMLChartDataSet -Data $Data -Name "Grades"

    .EXAMPLE
         New-PSHTMLChartDataSet -Data @(1,2,3) -Name plop -BackgroundColor Blue -BorderColor Green -HoverBackgroundColor Red -hoverBorderColor Green -BorderWidth 3 -HoverBorderWidth 1 -xAxisID 0 -yAxisID 22 -borderSkipped bottom

        data                 : {1, 2, 3}
        label                : plop
        xAxisID              : 0
        yAxisID              : 22
        backgroundColor      : rgb(30,144,255)
        borderColor          : rgb(173,255,47)
        borderWidth          : 0
        borderSkipped        : bottom
        hoverBackgroundColor : rgb(220,20,60)
        hoverBorderColor     : rgb(173,255,47)
        hoverBorderWidth     : 0

    .EXAMPLE
        #Creating a simple dataset and creating a chart
        $Data = @("4","7","11","21")

        $DataSet = New-PSHTMLChartDataSet -Data $Data -Name "Grades"

        $Labels = @("Math","History","Sport","French")
        New-PSHTMLBarChart -DataSet $DataSet -Labels $Labels -CanvasID "Canvas01" -Title "Schoold grades"
    .INPUTS
        Inputs (if any)
    .OUTPUTS
        [DataSet]
    .NOTES
        Author: Stéphane van Gulick
    #>
    [CmdletBInding()]
    Param(
        [Parameter(Mandatory=$true)]
        [Array]$Data,

        [Parameter(Mandatory=$true)]
        [String]$Name,

        [Parameter(Mandatory=$false)]
        [Parameter(ParameterSetName="Line")]
        [Parameter(ParameterSetName="Bar")]
        [Parameter(ParameterSetName="Pie")]
        [Parameter(ParameterSetName="Doughnut")]
        [ValidateSet("Blue","Red","Yellow","Green")]
        $BackgroundColor,

        [Parameter(Mandatory=$false)]
        [Parameter(ParameterSetName="Line")]
        [Parameter(ParameterSetName="Bar")]
        [Parameter(ParameterSetName="Pie")]
        [Parameter(ParameterSetName="Doughnut")]
        [ValidateSet("Blue","Red","Yellow","Green")]
        $BorderColor,

        [Parameter(Mandatory=$false)]
        [ValidateSet("Blue","Red","Yellow","Green")]
        [Parameter(ParameterSetName="Bar")]
        [Parameter(ParameterSetName="Pie")]
        [Parameter(ParameterSetName="Doughnut")]
        #Not line
        $HoverBackgroundColor,

        [Parameter(Mandatory=$false)]
        [ValidateSet("Blue","Red","Yellow","Green")]
        [Parameter(ParameterSetName="Bar")]
        [Parameter(ParameterSetName="Pie")]
        [Parameter(ParameterSetName="Doughnut")]
        #Not line 
        $hoverBorderColor,

        [Parameter(Mandatory=$false)]
        [Parameter(ParameterSetName="Line")]
        [Parameter(ParameterSetName="Bar")]
        [Parameter(ParameterSetName="Pie")]
        [Parameter(ParameterSetName="Doughnut")]
        [int]
        $BorderWidth,

        [Parameter(Mandatory=$false)]
        [Parameter(ParameterSetName="Bar")]
        [Parameter(ParameterSetName="Pie")]
        [Parameter(ParameterSetName="Doughnut")]
        #Not Line 
        [int]
        $HoverBorderWidth,

        [Parameter(Mandatory=$false)]
        [Parameter(ParameterSetName="Line")]
        #Not in Bar,Pie & Doughnut
        [String]
        $xAxisID,

        [Parameter(Mandatory=$false)]
        [Parameter(ParameterSetName="Line")]
        #Not in Bar,Pie & Doughnut
        [String]
        $yAxisID,

        [ValidateSet("top","bottom","Left","right")]
        [Parameter(ParameterSetName="Bar")]
        #Not Line,Pie & Doughnut
        [String]
        $borderSkipped
    )

        $dataSet = [dataSet]::New($Data,$Name)
        if($BackgroundColor){

            $dataSet.backgroundColor = [Color]::$BackgroundColor
        }

        if($HoverBackgroundColor){

            $dataSet.HoverBackgroundColor = [Color]::$HoverBackgroundColor
        }

        if($hoverBorderColor){

            $dataSet.hoverBorderColor = [Color]::$hoverBorderColor
        }

        if($BorderColor){

            $dataSet.BorderColor = [Color]::$BorderColor
        }

        if($yAxisID){

            $dataSet.yAxisID = $yAxisID
        }

        if($xAxisID){

            $dataSet.XAxisID = $xAxisID
        }

        if($borderSkipped){

            $dataSet.borderSkipped = $borderSkipped
        }

        return $dataset
    
}