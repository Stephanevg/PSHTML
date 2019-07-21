$TestsPath = Split-Path $MyInvocation.MyCommand.Path

#$FunctionsPath = join-Path -Path (get-item $TestsPath).Parent -ChildPath "Functions"

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\PSHTML -Force

InModuleScope PSHTML {

    Describe "Testing LogSettings" {
       
        it 'Get-PSHTMLConfiguration Should not Throw'{
            {Get-pshtmlConfiguration} | should not throw
            Get-pshtmlConfiguration | Should Not be NullOrEmpty
        }

        $Var = Get-pshtmlConfiguration
    
    
        it 'Should load variable: Var'{
            $Var | should not be nullOrEmpty
        }
        it 'Variable Should of type: [ConfigurationDocument]'{
            $Var.GetType().FullName | should -Be "ConfigurationDocument"
        }
    
        Context 'Assets Settings'{
            it 'Should return list of assets'{
                $Var.GetAsset() | should not be nullOrEmpty
            }
            it 'Should return specific asset'{
                $Var.GetAsset('Script') | should not be nullOrEmpty
            }
        }
        Context "Settings Operations"{
            it 'Should Not throw'{
                {$Var.GetSetting()} | should not Throw
            }
            it 'Should not be null or empty'{
                $Var.GetSetting() | should not be nullOrEmpty
            }
            It 'Shoul return specific setting'{
                $Log = $var.GetSetting('log')
                $Log[0].GetType().FullName | Should be "LogSettings"
            }
        }
    }
}