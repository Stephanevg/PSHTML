$TestsPath = Split-Path $MyInvocation.MyCommand.Path

#$FunctionsPath = join-Path -Path (get-item $TestsPath).Parent -ChildPath "Functions"

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\PSHTML -Force

InModuleScope PSHTML {

        Describe "DoughnutChart"{
            it "[Constructor][Parameterless] Should not throw"{
                {[DoughnutChart]::New()} | should not throw
            }

            it "[Constructor][Parameterless] Should be of correct type"{
                $Bc = [DoughnutChart]::New()
                $Bc.type | Should be "Doughnut"
           
            }

            <#
            #For some obscure reason, mocking doesn't seem to work with powershell classes
            # Tracking this here --> https://github.com/Stephanevg/PSHTML/issues/158
            $cd = New-MockObject -Type "ChartData"
            $co = New-MockObject -Type "ChartOptions"
            
            #>
            $cd = [ChartData]::new()
            $Co = [ChartOptions]::New()
            it "[Constructor][ChartData][ChartOptions] Should not throw"{
                {[DoughnutChart]::New($cd,$co)} | should not throw

            }

            $Bc = [DoughnutChart]::New()
            it '[Method][SetData] Adding DataSet object Should not throw'{

                {$bc.SetData($cd)} | should not throw
            }

            it '[Method][SetOptions] Adding options object Should not throw'{
                $Bc = [DoughnutChart]::New()
                {$bc.SetOptions($co)} | should not throw
            }

            $CanvasID = "CanvasID01"
            it '[Method][(Hidden)GetDefinitionStart] should return correct value'{
                $Start = $Bc.GetDefinitionStart($CanvasID)
                $ShouldString = @"
var ctx = document.getElementById("CanvasID01").getContext('2d');
var myChart = new Chart(ctx, 
"@
                $Start | Should be $ShouldString
            }

            it '[Method][(Hidden)GetDefinitionEnd] Should return correct value'{
                $End = $Bc.GetDefinitionEnd()
                $ShouldString =");"
                $End | Should be $ShouldString
            }

            it '[Method][(Hidden)GetDefinitionBody] Should JSON formated string'{
                $Bc = [DoughnutChart]::New()
                $Body = $Bc.GetDefinitionBody()
                $ShouldString = @"
{"type":"doughnut","data":null,"options":null}
"@
                #$Body | should be $ShouldString
                #$ShouldStringCleaned = Clear-WhiteSpace $ShouldString
                $Body | should be $ShouldString
            }



            it '[Method][GetDefinition][String] Should return Chart.JS Javascript code'{
                $Bc = [DoughnutChart]::New()
                $ShouldStringFull = @"
var ctx = document.getElementById("CanvasID01").getContext('2d');
var myChart = new Chart(ctx, 
"@
                $ShouldStringFull += @"
{
    "type":  "Doughnut",
    "data":  null,
    "options":  null
}
);

"@

$Should = @'
var ctx = document.getElementById("CanvasID01").getContext('2d'); var myChart = new Chart(ctx, {"type":"doughnut","data":null,"options":null} );
'@
                $Is = $Bc.GetDefinition($CanvasID)

                #$is | should be $ShouldStringFull
                #$ShouldStringFullCleaned = Clear-WhiteSpace $ShouldStringFull
                $Is | should be $Should

            }

        } -tag "Chart","Doughnut"

    
}