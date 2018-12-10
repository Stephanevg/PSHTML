$TestsPath = Split-Path $MyInvocation.MyCommand.Path

#$FunctionsPath = join-Path -Path (get-item $TestsPath).Parent -ChildPath "Functions"

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\PSHTML -Force

InModuleScope PSHTML {

    Context "Testing Charts"{
 
        Describe "PieChart"{
            it "[Constructor][Parameterless] Should not throw"{
                {[PieChart]::New()} | should not throw
            }

            it "[Constructor][Parameterless] Should be of correct type"{
                $Bc = [PieChart]::New()
                $Bc.type | Should be "pie"
           
            }

            $cd = New-MockObject -Type ChartData
            $co = New-MockObject -Type ChartOptions
            it "[Constructor][ChartData][ChartOptions] Should not throw"{
                {[PieChart]::New($cd,$co)} | should not throw

            }

            it '[Method][SetData] Adding DataSet object Should not throw'{

                $Bc = [PieChart]::New()
                {$bc.SetData($cd)} | should not throw
            }

            it '[Method][SetOptions] Adding options object Should not throw'{
                $Bc = [PieChart]::New()
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
                $Body = $Bc.GetDefinitionBody()
                $ShouldString = @"
{
    "type":  "bar",
    "data":  null,
    "options":  null
}
"@
                $Body | should be $ShouldString
            }



            it '[Method][GetDefinition][String] Should return Chart.JS Javascript code'{
                $ShouldStringFull = @"
var ctx = document.getElementById("CanvasID01").getContext('2d');
var myChart = new Chart(ctx, 
"@
                $ShouldStringFull += @"
{
    "type":  "bar",
    "data":  null,
    "options":  null
}
);

"@


                $Is = $Bc.GetDefinition($CanvasID)

                $is | should be $ShouldStringFull

            }

        } -tag "Chart","Pie"

    }
}