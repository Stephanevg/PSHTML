$TestsPath = Split-Path $MyInvocation.MyCommand.Path

#$FunctionsPath = join-Path -Path (get-item $TestsPath).Parent -ChildPath "Functions"

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\PSHTML -Force

InModuleScope "PSHTML"{
    Describe "Write-PSHTMLInclude (default - no include files)" {
        it 'Write-PSHTMLInclude should not throw when no include file present'{
            {Write-PSHTMLInclude} | should not throw
        }

        it 'write-pshtmlInclude should have alias: include'{
            (Get-Alias Include).Definition | should be "Write-PSHTMLInclude"
        }

        #set-location -Path $RootFolder.FullName
    }

    
    Describe "Write-PSHTMLInclude with existing include files." {
        $includesFolderPath = Join-Path .\PSHTML\ -ChildPath "Includes"

        $head = @"
        head -content {
            Write-PSHTMLAsset -Name Jquery -Type Script
            write-pshtmlAsset -Name BootStrap
    }
"@

        $FilePath = "$includesFolderPath\head.ps1"
        Set-Content -Path $FilePath -Value $head -Force
        (Get-PSHTMLConfiguration).Load()
        it 'Write-PSHTMLInclude -Name Head should not be null or empty'{
            Write-PSHTMLInclude -Name head | should not beNullOrEmpty
        }

        it 'Write-PSHTMLInclude -Name Head should write correct html statements'{
            $Head = Write-PSHTMLInclude -Name Head
            $head -match '^<head ><Scipt.*</head>'
        }



        #Cleaning up
        #set-location -Path $RootFolder.FullName
        remove-item $FilePath -Force
    }

    
    Describe "Write-pshtmlInclude Validating Location working" {

        $includesModuleFolderPath = Join-Path .\PSHTML\ -ChildPath "Includes"
        

        $footer = @"
p "This is footer from Module"
"@

        $FooterModuleFilePath = "$includesModuleFolderPath\footer.ps1"
        Set-Content -Path $FooterModuleFilePath -Value $footer -Force

        Context '[Location]Module' {
            (Get-PSHTMLConfiguration).Load()
            It 'Include files should be discovered' {
                Write-PSHTMLInclude -Name footer | should not beNullOrEmpty
            }

            It 'Include files should be added to the HTML Document'{
                Write-PSHTMLInclude -Name footer | should match '.*This is footer from Module.*'
            }
        }

        #Cleanup 
        #Remove-item $FooterModuleFilePath -force

        $ScriptFolder = Join-Path $testdrive -ChildPath 'PlopScript'
        $Null = Mkdir $Scriptfolder
        #Set-Location $TestDrive
        $includesScriptFolderPath = Join-Path $ScriptFolder -ChildPath "Includes"
        $null = mkdir $includesScriptFolderPath

        $footer = @"
p "This is footer from script"
"@

$head = @"
p "This is head from script"
"@
        set-location $ScriptFolder
        $FilePathHead = "$includesScriptFolderPath\head.ps1"
        Set-Content -Path $FilePathHead -Value $head -Force

        $FilePathFooter = "$includesScriptFolderPath\footer.ps1"
        Set-Content -Path $FilePathFooter -Value $footer -Force

        (Get-PSHTMLConfiguration).Load()
        Context '[Location]Script' {

            It 'Include files should be discovered' {
                Write-PSHTMLInclude -Name footer | should not beNullOrEmpty
            }

            It 'Include files should be added to the HTML Document' {
                Write-PSHTMLInclude -Name head | should match '.*<p >This is head from script</p>.*'
            }

            It 'When Collision with an existing Module Include, Script should overwrite' {
                Write-PSHTMLInclude -Name footer | should Match '.*<p >This is footer from script</p>.*'
            }
        }

        set-location -Path $home
    }

    
}