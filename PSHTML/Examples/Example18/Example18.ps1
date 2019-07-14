Import-Module C:\Users\taavast3\OneDrive\Repo\Projects\OpenSource\PSHTML\PSHTML\PSHTML.psd1

Class PesterDocument {
    [System.IO.FileInfo]$Path
    $Data

    PesterDocument([String]$Path) {
        $this.Path = $Path
        $This.Data = $this.GetData()
    }

    [Object]GetData() {
        $Item = Get-Item $this.Path.FullName
        If ($Item -is [System.IO.FileInfo]) {
            If ($Item.Extension -eq '.xml') {
                [xml]$x = Get-Content -Path $Item.FullName
                Return $x.'test-results' | ConvertTo-Json -Depth 8
            }
            ElseIf ($Item.Extension -eq '.Json') {
                Return Get-Content $Item.FullName | ConvertFrom-Json
            }
        }

        Throw 'Folder type is currently not supported'
        
    }
}
#$FilePath = "C:\Users\taavast3\OneDrive\Repo\Projects\OpenSource\PsNunit\output.json"
$FilePath = 'C:\Users\taavast3\OneDrive\Repo\Projects\OpenSource\PSHTML\PSHTML\Examples\Example18\TestREsults.Json'
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


$Html = html -Attributes @{lang = "en" } -Content {
    head {
        meta -charset 'UTF-8'
        meta -name 'author' -content "Stephane van Gulick"
        Title -Content "Pester REport"
        Write-PSHTMLAsset -Name JQuery 
        Write-PSHTMLAsset -Name Bootstrap 
        Write-PSHTMLAsset -Name ChartJs

        Style {
            $chartColors = @{
                red    = 'rgb(255, 99, 132)'
                orange = 'rgb(255, 159, 64)'
                yellow = 'rgb(255, 205, 86)'
                green  = 'rgb(75, 192, 192)'
                blue   = 'rgb(54, 162, 235)'
                purple = 'rgb(153, 102, 255)'
                grey   = 'rgb(231,233,237)'
            }
            @"
.theadfailed {
              color: #401500;
              background-color: #FFDDCC;
              border-color: #792700;
            }
            td{
                word-break: break-all;
            }
"@
        }
    }
    $TableClasses = "table table-bordered table-hover"
    $TableHeaders = "thead-dark"
    $CanvasFixturesId = 'Chart_FixtureID'
    Body {
        Div -Class 'container' {

            <#
        <div class="jumbotron">
  <h1 class="display-4">Hello, world!</h1>
  <p class="lead">This is a simple hero unit, a simple jumbotron-style component for calling extra attention to featured content or information.</p>
  <hr class="my-4">
  <p>It uses utility classes for typography and spacing to space content out within the larger container.</p>
  <p class="lead">
    <a class="btn btn-primary btn-lg" href="#" role="button">Learn more</a>
  </p>
</div>
        #>
            Div -Class 'Jumbotron' {
                H1 -Class "display-4" {
                    "Pester Report Summary"
                }
                p -Class 'lead' {
                    "Detail run statistics from last pester runs. "
                }
            }

            Div -Class 'Summary' {
                H1 {
                    "Overview"
                }

                Table -Class $TableClasses -content {
                    tr {
                        td {
                            'Source File'
                        }
                        td {
                            $($PEsterDoc.Path.FullName)
                        }
                    }
                }

                ConvertTo-PSHTMLTable -Object $PesterDoc.Data -Properties TotalCount, PassedCount, FailedCount, SkippedCount, PendingCount, InconclusiveCount -TableClass $TableClasses -TheadClass $TableHeaders
            
                Div -Class "row" -Content {
                    Div -Id 'ChartSum' -Class 'row' -content {

                        $CanvasId = "Chart_Summary"
                        canvas -Id $CanvasId -Height 400px -Width 400px -Content {
        
                        }
                    }
                    Div -id 'chartFixture' -Class 'row' -content {
        
                        canvas -Id $CanvasFixturesId -Height 400px -Width 400px -Content {
        
                        }

                    }
                }

            }

            Div -Class 'Time' {

                p {
                    "Pester Run took {0} days {1} hours {2} minutes {3} seconds to execute" -f $PesterDoc.Data.Time.Days, $PesterDoc.Data.Time.hours, $PesterDoc.Data.minutes, $PesterDoc.Data.time.Seconds
                }
            
            }

            $GroupedResults = $PesterDoc.Data.TestResult | Group-Object Result
            $Failed = $GroupedResults | Where-Object { $_.Name -eq 'Failed' }

            $Passed = $GroupedResults | Where-Object { $_.Name -eq 'Passed' }

            Div -id "accordion" -Content {
                Div -Class "card" -Content {
                    Div -Class 'card-header' -Id "heading_Failed" -Content {
                        h5 -Class "mb-0" -Content {
                            button -Class 'btn btn-link' -Attributes @{'data-toggle' = 'collapse'; 'data-target' = "#collapseFailed"; 'aria-expanded' = "true"; 'aria-controls' = "collapseOne" } -Content {
                                "Failed Tests"
                            }
                        }
                    }
                    Div -Id 'collapseFailed' -Class 'Collapse show' -Content {
                        Div -Class 'card-boddy' -Content {
                            Div -Class 'FailedTests' -Content {
                                h2 {
                                    "Failed tests"
                                }
                                p {
                                    "Total failed tests: {0}" -f $Failed.Count
                                }
                                $TableTop = @('Name', 'Result', 'Describe', 'Parameters', 'FailureMessage', 'Time', 'StackTrace')
                                Table -Class $TableClasses -Id 'table_failed_tests' {
                                    tr -Content {
                                        Foreach ($t in $TableTop) {
                
                                            td {
                                                $t
                                            }
                                        }
                                    }
                                    Foreach ($ftest in $Failed.Group) {
                    
                                        #ConvertTo-PSHTMLTable -Object $ftest -Properties Name,Result,Describe,Parameters,FailureMessage,Time,StackTrace -TableClass $TableClasses -TheadClass $TableHeaders
                                        #$ft | gm -MemberType Noteproperty | select Name
                
                                        tr {
                                            foreach ($ft in $ftest) {
                                                foreach ($th in $TableTop) {
                
                                                    if ($th -eq 'Result') {
                                                        $ResultType = $null
                                                        If ($ft.$th -eq 'Failed') {
                                                            $ResultType = 'badge badge-danger'
                                                        }
                                                        else {
                                                            $ResultType = 'badge badge-success'
                                                        }
                                                        td -Class $ResultType -Content {
                                                            $ft.$th
                                                        }
                                                    }
                                                    else {
                
                                                        td {
                                                            $ft.$th
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    
                                    }
                                }
                            }
                        }
                    } -Attributes @{'aria-labelledby' = "heading_Failed"; 'data-parent' = "#accordion" }
                }
                Div -Class "card" -Content {
                    Div -Class 'card-header' -Id "heading_Passed" -Content {
                        h5 -Class "mb-0" -Content {
                            button -Class 'btn btn-link' -Attributes @{'data-toggle' = 'collapse'; 'data-target' = "#collapsePassed"; 'aria-expanded' = "false"; 'aria-controls' = "heading_Passed" } -Content {
                                "Passed Tests"
                            }
                        }
                    }
                    Div -Id 'collapsePassed' -Class 'Collapse show' -Content {
                        Div -Class 'card-boddy' -Content {
                        
                            Div -Class 'PassedTests' -Content {
                                h2 {
                                    "Passed tests"
                                }
                                p {
                                    "Total Passed tests: {0}" -f $Passed.Count
                                }

                                Foreach ($ptest in $Passed.Group) {

                                    ConvertTo-PSHTMLTable -Object $ptest -Properties Name, Result, Describe, Parameters, FailureMessage, Time, StackTrace -TableClass $TableClasses -TheadClass $TableHeaders
                                }
                            }
                        }
                    } -Attributes @{'aria-labelledby' = "heading_Passed"; 'data-parent' = "#accordion" }
                }
            }



            script -content {
                $PieData = @($PesterDoc.Data.PassedCount, $PesterDoc.Data.FailedCount, $PesterDoc.Data.SkippedCount, $PesterDoc.Data.InconclusiveCount)
                $Labels = @("Passed", "Failed", "Skipped", "Inconclusive")
                $colors = @("LightGreen", "Red", "Yellow", "Orange")
                $BarDataSet = New-PSHTMLChartPieDataSet -Data $PieData -label "Pester Data" -backgroundColor $Colors
                New-PSHTMLChart -Type Pie -DataSet $BarDataSet -Labels $Labels -CanvasID "Chart_Summary" -Title "Pester run summary (Failed 'It' Blocks)"
            }


            script -content {
                $Fixtures = $PesterDoc.Data.TestResult | Group-Object Describe
                $FixtureSuccess = 0
                $FixtureFailed = 0
                Foreach ($Fixture in $Fixtures) {
                    If (($Fixture.Group | Where-Object { $_.Result -eq 'Failed' } | Measure-Object).Count -eq 0) {
                    
                        $FixtureFailed++
                    }
                    else {
                        $FixtureSuccess++
                    }
                }
            
                $PieData = @($FixtureSuccess, $FixtureFailed)
                $FixtureLabels = @("Passed", "Failed")
                $colors = @("LightGreen", "Red")
                $FixtureDAtaSet = New-PSHTMLChartPieDataSet -Data $PieData -label "Pester Data" -backgroundColor $Colors
                New-PSHTMLChart -Type Pie -DataSet $FixtureDAtaSet -Labels $FixtureLabels -CanvasID $CanvasFixturesId -Title "Failed Fixtures (Failed 'Describe' blocks)"
            }

        }
        Footer {

        }
    }
} 

$FilePath = '.\PesterReport.html'
$html | Out-File -FilePath $FilePAth -Encoding utf8 -Force
Start-Process $FilePath
#Out-PSHTMLDocument -HTMLDocument $Html  -OutPath .\PesterReport.html -Show