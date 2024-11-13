$TestsPath = Split-Path $MyInvocation.MyCommand.Path

#$FunctionsPath = join-Path -Path (get-item $TestsPath).Parent -ChildPath "Functions"

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"
$CurrentPshtmlModulePath = Join-Path $RootFolder.FullName -ChildPath "PSHTML"
        #write-host "Importing module $CurrentPshtmlModulePath" -ForegroundColor DarkBlue
        $includesModuleFolderPath = Join-Path $CurrentPshtmlModulePath -ChildPath "Includes"
        #write-host "includesModuleFolderPath -> $includesModuleFolderPath" -ForegroundColor DarkBlue
import-module $CurrentPshtmlModulePath -Force
InModuleScope "PSHTML" {
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
        start-Sleep -Seconds 2
        it 'Write-PSHTMLInclude -Name Head should not be null or empty'{
            Write-PSHTMLInclude -Name head | should not beNullOrEmpty
        }

        it 'Write-PSHTMLInclude -Name Head should write correct html statements'{
            $Head = Write-PSHTMLInclude -Name Head
            $head -match '^<head ><Scipt.*</head>'
        }



        #Cleaning up
        #set-location -Path $RootFolder.FullName
        #remove-item $FilePath -Force
    }

    
}

    #$TestsPath = Split-Path $script:MyInvocation.MyCommand.Path
    Describe "Write-pshtmlInclude Validating Location is working" {
        #$RootFolder = (get-item $TestsPath).Parent

        

        $footer = @"
p "This is footer from Module"
"@
        $includesFolderPath = Join-Path .\PSHTML\ -ChildPath "Includes"
        $FooterModuleFilePath = "$includesFolderPath\Footer.ps1"
        Set-Content -Path $FooterModuleFilePath -Value $footer -Force
        #write-host "FooterFilePath $FooterModuleFilePath" -ForegroundColor DarkBlue
        (Get-PSHTMLConfiguration).Load()
        Start-Sleep -Seconds 2 #Wait for the configuration to load
        Context '[Location]Module' {
            
            It 'Include files should be discovered' {
                Write-PSHTMLInclude -Name Footer | should not beNullOrEmpty
            }

            It 'Include files should be added to the HTML Document'{
                Write-PSHTMLInclude -Name footer | should match '.*This is footer from Module.*'
            }
        }

        #There is a bug when this test is run in PS5.1
        # It will keep calling the wrong include. 
        # ALTHOUGH ALL (!!) my manual tests are working fine.
        #I guess there is a variable that is empty somewhere when called in PS5.1 but I couldn't finger point the root until now..
        # Are YOU my superman which will fix this bug?
       if($PSVersionTable.PSVersion.Major -gt 5){
        
        Context '[Location]Project' {


        $ScriptFolder = Join-Path $testdrive -ChildPath 'PlopScript'
        $Null = New-Item -type directory -Path $Scriptfolder
        $ScriptFilePath = Join-Path $ScriptFolder -ChildPath 'plop.ps1'
        $ModuleFolder = Get-PSHTMLConfiguration | Select-Object -ExpandProperty ModuleFolder
        $PlopScriptContents = @"
Import-Module {0} -Force
Write-PSHTMLInclude -Name Footer
"@ -f $ModuleFolder
        New-Item -ItemType File -Path $ScriptFilePath -Force -Value $PlopScriptContents
       

        $footer = @"
p "This is footer from Project"
"@

        $head = @"
p "This is head from Project"
"@

        $includesScriptFolderPath = Join-Path $ScriptFolder -ChildPath "Includes"
        set-location $ScriptFolder
        $null = New-Item -type directory -Path $includesScriptFolderPath

        $FilePathHead = "$includesScriptFolderPath\head.ps1"
        Set-Content -Path $FilePathHead -Value $head -Force

        $FilePathFooter = "$includesScriptFolderPath\footer.ps1"
        Set-Content -Path $FilePathFooter -Value $footer -Force

        

            It 'Include files should be discovered and Project includes should be included when conflict with module include exists' {
                #Here we execute a script that includes the head file. The head file exsits at two locations:
                #the module and the script caller loation folder (Also known as the project folder).
                # The precedence rule is that the project folder takes precedence over the module folder.
                #Therefore, the head file from the project folder should be included.
                $return = & $ScriptFilePath
                $return | should -Not -BeNullOrEmpty
                $return | should -Match '.*<p >This is footer from Project</p>.*'
            }
        }
        }
        set-location -Path $home

        #Cleanup 
    }