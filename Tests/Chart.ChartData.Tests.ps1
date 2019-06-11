$TestsPath = Split-Path $MyInvocation.MyCommand.Path

#$FunctionsPath = join-Path -Path (get-item $TestsPath).Parent -ChildPath "Functions"

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\PSHTML -Force

InModuleScope PSHTML {

    Context "Testing Charts"{
 
        Describe "ChartData"{
            it "[Constructor][Parameterless] Should not throw"{
                {[ChartData]::New()} | should not throw
            }

            it "[Constructor][Parameterless] Should have right properties"{
                $cd = [ChartData]::New()
                $Properties = $cd | gm | ? {$_.MemberType -eq 'Property'}
                $Properties.Name | should contain 'datasets'
                $Properties.Name | should contain 'Labels'
           
            }

            $LabelValue = "MyLabel"
            it "[Methods][SetLabels] Should not throw"{
                $co = [ChartData]::New()
                {$co.SetLabels($LabelValue)} | should not throw
                
            }

            it "[Methods][SetLabels] Should add correct value"{
                $co = [ChartData]::New()
                $co.SetLabels($LabelValue)
                $co.labels | should contain $LabelValue
                
            }

            <#
                Mocking doesn't work for custom classes.
                https://github.com/Stephanevg/PSHTML/issues/158
            #>
           #DataSet = New-MockObject -Type "DataSet" 
            $DataSet = [DataSet]::new()
            it "[Methods][AddDataset] Should not throw"{
                $co = [ChartData]::New()
                {$co.AddDataset($DataSet)} | should not throw
                
            }

        }

    }
}