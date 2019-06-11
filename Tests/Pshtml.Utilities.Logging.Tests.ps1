$TestsPath = Split-Path $MyInvocation.MyCommand.Path

#$FunctionsPath = join-Path -Path (get-item $TestsPath).Parent -ChildPath "Functions"

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\PSHTML -Force

InModuleScope PSHTML {

    Describe "plop"{
        it '[New-Logfile] Should throw when no path is specified' {
            {New-Logfile} | should throw
        }

        it '[New-Logfile] -Path Should return object of type [LogSettings] ' {
            $Logdocument = New-Logfile -Path $TestDrive
            $Logdocument.GetType().FullName | Should be "LogSettings"
        }
        $Var = Get-pshtmlConfiguration
       
        it '[GetDefaultLogFilePath()]Should return LogfilePath'{
            $Var.GetDefaultLogFilePath() | Should not be Nullorempty
            if($global:IsLinux){
                $p = "/tmp/pshtml/"
            }Else{
                $p = Join-Path $Env:Temp -ChildPath "pshtml"
            }
            $fullLogfilePath = Join-Path -Path $p -ChildPath "Pshtml.log"
            $Var.GetDefaultLogFilePath() | Should be $fullLogfilePath
        }
        It 'Log file should have default Name: pshtml.log'{
            Split-Path -Path $Var.GetDefaultLogFilePath().ToLower() -Leaf | Should be "pshtml.log"
        }


        It 'Get-LogfilePath | With default value'{
            
            if($IsLinux){
                $DefaultPath = "/tmp/pshtml/"
            }else{
                $DefaultPath = Join-Path $env:TEMP -ChildPath 'pshtml'
            }
            $DefaultPath = Join-Path $DefaultPath -ChildPath "pshtml.log"
            Get-LogFilePath | Should be $DefaultPath
        }

        <#
            If still here after end of March/2019 Please remove as it is not needed anymore
        
        It 'SetLogdocument'{
            if($IsLinux){
                $LogDocument = New-Logfile -Path ([system.io.DirectoryInfo]"/tmp/woop/")
                $var.SetLogConfig($Logdocument)
                $Var.GetLogfilePath() | Should be "/tmp/woop/pshtml.log"
            }else{

                $LogDocument = New-Logfile -Path ([system.io.DirectoryInfo]"C:\temp\pshtml")
                $var.SetLogConfig($Logdocument)
                $Var.GetLogfilePath() | Should be "C:\Temp\pshtml\pshtml.log"
            }
        }
        #>
    }

}