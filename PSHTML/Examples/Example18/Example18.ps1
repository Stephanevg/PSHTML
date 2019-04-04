import-module C:\Users\taavast3\OneDrive\Repo\Projects\OpenSource\PSHTML\PSHTML\PSHTML.psd1

Class PesterDocument{
    [System.IO.FileInfo]$Path
    $Data

    PesterDocument([String]$Path){
        $this.Path = $Path
        $This.Data =$this.GetData()
    }

    [Object]GetData(){
        $Item = Get-Item $this.Path.FullName
        If($Item -is [System.IO.FileInfo]){
            If ($Item.Extension -eq '.xml'){
                [xml]$x = gc -Path $Item.FullName
                Return $x.'test-results' | ConvertTo-Json -Depth 8
            }ElseIf($Item.Extension -eq '.Json'){
                Return gc $Item.FullName | ConvertFrom-json
            }
        }

        Throw 'Folder type is currently not supported'
        
    }
}
$FilePath = "C:\Users\taavast3\OneDrive\Repo\Projects\OpenSource\PsNunit\output.json"
<#>
Function Get-PesterRawData {
    [Parameter(Mandatory=$true)]
    Param(
        $Path
    )
    $Item = Get-Item $Path
    If($Item -is [System.IO.FileInfo]){
        If ($Item.Extension -eq '.xml'){
            [xml]$x = gc -Path $Item.FullName
            $Data = $x.'test-results' | ConvertTo-Json -Depth 8
        }ElseIf($Item.Extension -eq '.Json'){
            $Data = gc $Item.FullName | ConvertFrom-json
        }
    }
    
    return $data
}
#>

$PesterDoc = [PesterDocument]::new($FilePath)


$Html = html -Attributes @{lang="en"} -Content {
    head {
        meta -charset 'UTF-8'
        meta -name 'author' -content "Stephane van Gulick"
        Title -Content "Pester REport"
        Write-PSHTMLAsset -Name JQuery 
        Write-PSHTMLAsset -Name Bootstrap 
        Write-PSHTMLAsset -Name ChartJs

        Style {
$chartColors = @{
    red= 'rgb(255, 99, 132)'
    orange = 'rgb(255, 159, 64)'
    yellow = 'rgb(255, 205, 86)'
    green= 'rgb(75, 192, 192)'
    blue= 'rgb(54, 162, 235)'
    purple= 'rgb(153, 102, 255)'
    grey= 'rgb(231,233,237)'
  }
@"
.theadfailed {
              color: #401500;
              background-color: #FFDDCC;
              border-color: #792700;
            }
"@
}
    }
    $TableClasses = "table table-bordered table-hover"
            $TableHeaders = "thead-dark"
    body {
     div -Class 'container' {

        div -Class 'Summary'{
            H1 {
                "Pester Reults Summary"
            }

            p {
                "Source File - $($PEsterDoc.Path.FullName)"
            }
            
            ConvertTo-PSHTMLTable -Object $PesterDoc.Data -Properties TotalCount,PassedCount,FailedCount,SkippedCount,PendingCount,InconclusiveCount -TableClass $TableClasses -TheadClass $TableHeaders
            $CanvasId = "Chart_Summary"
            Canvas -Id $CanvasId -Height 400px -Width 400px -Content {

            }
            
        }

        div -Class 'Time'{

            P{
                "Pester Run took {0} days {1} hours {2} minutes {3} seconds to execute" -f $PesterDoc.Data.Time.Days,$PesterDoc.Data.Time.hours,$PesterDoc.Data.minutes,$PesterDoc.Data.time.Seconds
            }
            
        }

        $GroupedResults = $PesterDoc.Data.TestResult | group Result
        $Failed =$GroupedResults | ? {$_.Name -eq 'Failed'}

        $Passed =$GroupedResults | ? {$_.Name -eq 'Passed'}
        Div -Class 'FailedTests' -Content {
            H2 {
                "Failed tests"
            }
            P {
                "Total failed tests: {0}" -f $Failed.Count
            }

            Foreach($ftest in $Failed.Group){

                ConvertTo-PSHTMLTable -Object $ftest -Properties Name,Describe,Parameters,FailureMessage,Time,StackTrace -TableClass $TableClasses -TheadClass $TableHeaders
            }
        }

        Div -Class 'PassedTests' -Content {
            H2 {
                "Passed tests"
            }
            P {
                "Total Passed tests: {0}" -f $Passed.Count
            }

            Foreach($ptest in $Passed.Group){

                ConvertTo-PSHTMLTable -Object $ptest -Properties Name,Describe,Parameters,FailureMessage,Time,StackTrace -TableClass $TableHeaders -TheadClass $TableHeaders
            }
        }
        Script -content {
            $PieData = @($PesterDoc.Data.PassedCount,$PesterDoc.Data.FailedCount,$PesterDoc.Data.SkippedCount,$PesterDoc.Data.InconclusiveCount)
            $Labels = @("Passed","Failed","Skipped","Inconclusive")
            $colors = @("LightGreen",$chartColors.red,$chartColors.yellow,"LightOrange")
            $BarDataSet = New-PSHTMLChartPieDataSet -Data $PieData -label "Pester Data" -backgroundColor $Colors
            New-PSHTMLChart -Type Pie -DataSet $BarDataSet -Labels $Labels -CanvasID "Chart_Summary" -Title "Pester run summary"
        }
}
        footer {

        }
    }
} 

$FilePath ='.\PesterReport.html'
$html  | out-file -FilePath $FilePAth -Encoding utf8 -Force
start $FilePath
#Out-PSHTMLDocument -HTMLDocument $Html  -OutPath .\PesterReport.html -Show