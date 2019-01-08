$TestsPath = Split-Path $MyInvocation.MyCommand.Path

#$FunctionsPath = join-Path -Path (get-item $TestsPath).Parent -ChildPath "Functions"

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\PSHTML -Force

InModuleScope PSHTML {

        Describe "LineChart"{
            it "[Constructor][Parameterless] Should not throw"{
                {[LineChart]::New()} | should not throw
            }

            it "[Constructor][Parameterless] Should be of correct type"{
                $Bc = [LineChart]::New()
                $Bc.type | Should be "Line"
           
            }

            <#
            #For some obscure reason, mocking doesn't seem to work with powershell classes
            # Tracking this here --> https://github.com/Stephanevg/PSHTML/issues/158
            $cd = New-MockObject -Type "ChartData"
            $co = New-MockObject -Type "ChartOptions"
            
            #>
           
            $cd = [ChartData]::New()
           
            $co = [ChartOptions]::New()
            it "[Constructor][ChartData][ChartOptions] Should not throw"{
                {[LineChart]::New($cd,$co)} | should not throw

            }

            it '[Method][SetData] Adding DataSet object Should not throw'{

                $Bc = [LineChart]::New()
                {$bc.SetData($cd)} | should not throw
            }

            it '[Method][SetOptions] Adding options object Should not throw'{
                $Bc = [LineChart]::New()
                {$bc.SetOptions($co)} | should not throw
            }

            $CanvasID = "CanvasID01"
            it '[Method][(Hidden)GetDefinitionStart] should return correct value'{
                $Bc = [LineChart]::New()
                $Start = $Bc.GetDefinitionStart($CanvasID)
                $ShouldString = @"
var ctx = document.getElementById("CanvasID01").getContext('2d');
var myChart = new Chart(ctx, 
"@
                $Start | Should be $ShouldString
            }

            it '[Method][(Hidden)GetDefinitionEnd] Should return correct value'{
                $Bc = [LineChart]::New()
                $End = $Bc.GetDefinitionEnd()
                $ShouldString =");"
                $End | Should be $ShouldString
            }

            it '[Method][(Hidden)GetDefinitionBody] Should JSON formated string'{
                $Bc = [LineChart]::New()
                $Body = $Bc.GetDefinitionBody()
                $ShouldString = @"
{"type":"line","data":null,"options":null}
"@

                $Body | should be $ShouldString
            }



            it '[Method][GetDefinition][String] Should return Chart.JS Javascript code'{
                $Bc = [LineChart]::New()

$Should = @'
var ctx = document.getElementById("CanvasID01").getContext('2d'); var myChart = new Chart(ctx, {"type":"line","data":null,"options":null} );
'@



                $Is = $Bc.GetDefinition($CanvasID)


                $Is | should be $Should
            }
        } -tag "Chart","Line"

}