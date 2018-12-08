$TestsPath = Split-Path $MyInvocation.MyCommand.Path

#$FunctionsPath = join-Path -Path (get-item $TestsPath).Parent -ChildPath "Functions"

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\PSHTML -Force

InModuleScope PSHTML {

    Context "Testing Charts"{
        Describe "ChartType" {
            
            it "Should contain chart types" {
                [ChartType]::GetNames('ChartType') | should not benullOrEmpty
            }
    
            it "Should contain chart types: [bar]" {
                [ChartType]::GetNames('ChartType') | should contain 'bar'
            }
    
            it "Should contain chart types: [line]" {
                [ChartType]::GetNames('ChartType') | should contain 'line'
            }
    
            it "Should contain chart types: [doughnut]" {
                [ChartType]::GetNames('ChartType') | should contain 'doughnut'
            }
    
            it "Should contain chart types: [pie]" {
                [ChartType]::GetNames('ChartType') | should contain 'pie'
            }
        }
    }
}