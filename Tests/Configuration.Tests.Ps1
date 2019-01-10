$TestsPath = Split-Path $MyInvocation.MyCommand.Path

#$FunctionsPath = join-Path -Path (get-item $TestsPath).Parent -ChildPath "Functions"

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\PSHTML -Force

Describe "Testing Configuration" {
    $Var = Get-pshtmlConfiguration

    it 'Get-PSHTMLConfiguration Should not Throw'{
        {Get-pshtmlConfiguration} | should not throw
        Get-pshtmlConfiguration | Should Not be NullOrEmpty
    }

    it 'Should load variable: Var'{
        $Var | should not be nullOrEmpty
    }
    it 'Variable Should of type: [ConfigurationFile]'{
        $Var.GetType().FullName | should -Be "ConfigurationFile"
    }
    Context 'Correct data:'{

        it 'Should load variable: Var: AssetConfig'{
            $Var.GetAssetsConfig() | should not be nullOrEmpty
        }
        it 'Should load variable: Var: GeneralConfig'{
            $Var.GetGeneralConfig() | should not be nullOrEmpty
        }
        it 'Should load variable: Var: LogConfig'{
            $Var.GetLogConfig() | should not be nullOrEmpty
        }
    }

    Context 'Assets'{
        it 'Should return list of assets'{
            $Var.GetAsset() | should not be nullOrEmpty
        }
        it 'Should return specific asset (chart)'{
            $Var.GetAsset('Chart') | should not be nullOrEmpty
        }
    }
}