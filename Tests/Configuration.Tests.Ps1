$TestsPath = Split-Path $MyInvocation.MyCommand.Path

#$FunctionsPath = join-Path -Path (get-item $TestsPath).Parent -ChildPath "Functions"

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\PSHTML -Force

Describe "Testing Configuration" {

    it 'Should load variable: PSHTML_Configuration'{
        Get-Variable PSHTML_Configuration | should not be nullOrEmpty
    }
    it 'Variable Should of type: [ConfigurationFile]'{
        $PSHTML_Configuration.GetType().FullName | should -Be "ConfigurationFile"
    }
    Context 'Correct data:'{

        it 'Should load variable: PSHTML_Configuration: AssetConfig'{
            $PSHTML_Configuration.GetAssetsConfig() | should not be nullOrEmpty
        }
        it 'Should load variable: PSHTML_Configuration: GeneralConfig'{
            $PSHTML_Configuration.GetGeneralConfig() | should not be nullOrEmpty
        }
        it 'Should load variable: PSHTML_Configuration: LogConfig'{
            $PSHTML_Configuration.GetLogConfig() | should not be nullOrEmpty
        }
    }

    Context 'Assets'{
        it 'Should return list of assets'{
            $PSHTML_Configuration.GetAsset() | should not be nullOrEmpty
        }
        it 'Should return specific asset (chart)'{
            $PSHTML_Configuration.GetAsset('Chart') | should not be nullOrEmpty
        }
    }
}