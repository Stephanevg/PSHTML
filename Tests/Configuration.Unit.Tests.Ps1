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
    Context 'High Level object data:'{

        it 'Should load variable: Var: ConfigurationAssets'{
            $Var.GetAssetsConfig() | should not be nullOrEmpty
        }
        it 'Should load variable: Var: ConfigurationGeneral'{
            $Var.GetGeneralConfig() | should not be nullOrEmpty
        }
        it 'Should load variable: Var: ConfigurationLog'{
            $Var.GetConfigurationLog() | should not be nullOrEmpty
        }
    }

    Context 'Assets Settings'{
        it 'Should return list of assets'{
            $Var.GetAsset() | should not be nullOrEmpty
        }
        it 'Should return specific asset (chart)'{
            $Var.GetAsset('Chart') | should not be nullOrEmpty
        }
    }

    Context 'Logging Settings'{

        it '[New-Logfile] Should throw when no path is specified' {
            {New-Logfile} | should throw
        }

        it '[New-Logfile] -Path Should return object of type [ConfigurationLog] ' {
            $Logdocument = New-Logfile -Path $TestDrive
            $Logdocument.GetType().FullName | Should be "ConfigurationLog"
        }

        it 'Should add a [ConfigurationLog] document'{
            
            $Logdocument = New-Logfile -Path $TestDrive #[ConfigurationLog]::New($TestDrive)
            $var.Data.SetConfigurationLog($Logdocument)
            $Var.Data.GetConfigurationLog().Path.Directory.FullName | Should be $TestDrive.FullName

        }

        It 'Log file should have default Name: pshtml.log'{
            $Var.Data.GetConfigurationLog().Path.Name | Should be "pshtml.log"
        }

        it '[GetLogfilePath()]Should return LogfilePath'{
            $Var.GetLogfilePath() | Should not be Nullorempty
            $fullLogfilePath = Join-Path -Path $TestDrive.FullName -ChildPath "Pshtml.log"
            $Var.GetLogfilePath() | Should be $fullLogfilePath
        }

        It 'Get-LogfilePath | With default value'{
            
            if($IsLinux){
                $DefaultPath = "/var/log/pshtml/"
            }else{
                $DefaultPath = Join-Path $env:ProgramData -ChildPath 'pshtml'
            }
            $DefaultPath = Join-Path $DefaultPath -ChildPath "pshtml.log"
            Get-LogFilePath | Should be $DefaultPath
        }

        It 'SetLogdocument'{

            $LogDocument = New-Logfile -Path ([system.io.DirectoryInfo]"C:\temp\pshtml")
            $var.SetLogConfig($Logdocument)
            $Var.GetLogfilePath() | Should be "C:\Temp\pshtml\pshtml.log"
        }
        
    }

    Context "General settings"{
        it 'Should not Throw'{
            {$Var.GetGeneralConfig()} | should not Throw
        }
        it 'Should not be null or empty'{
            $Var.GetGeneralConfig() | should not be nullOrEmpty
        }
    }
}