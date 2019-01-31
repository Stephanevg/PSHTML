$TestsPath = Split-Path $MyInvocation.MyCommand.Path

#$FunctionsPath = join-Path -Path (get-item $TestsPath).Parent -ChildPath "Functions"

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\PSHTML -Force

InModuleScope PSHTML {

    Describe "Testing Assets" {
       
        Context "Testing Base data"{

            It 'Get-PSHTMLAsset must be publicly available'{
                $c = get-command -Module PSHTML -Name Get-PSHTMLAsset 
                $c | should not BeNullOrEmpty
                $c.Name | Should be "Get-PSHTMLAsset"
            }

            It 'Write-PSHTMLAsset must be publicly available'{
                $w = get-command -Module PSHTML -Name Write-PSHTMLAsset 
                $w | should not BeNullOrEmpty
                $w.Name | Should be "Write-PSHTMLAsset"
            }

            it 'Get-PSHTMLAssets Should not Throw'{
                {Get-PSHTMLAsset} | should not throw
                Get-PSHTMLAsset | Should Not be NullOrEmpty
            }

            it 'Write-PSHTMLAssets Should not Throw'{
                {Write-PSHTMLAsset} | should not throw
                Write-PSHTMLAsset | Should Not be NullOrEmpty
            }
        }


        $Var = Get-PSHTMLAsset
    
        Context "Testing for Default Assets presence in module"{

            It '[Styles] Bootstrap'{
                $var | ? {$_.Type -eq 'Style' -and $_.Name -eq 'Bootstrap'} | Should not BeNullOrEmpty
                ($var | ? {$_.Type -eq 'Style' -and $_.Name -eq 'Bootstrap'} | Measure).Count | Should be 1
                Test-Path ($var | ? {$_.Type -eq 'Style' -and $_.Name -eq 'Bootstrap'}).GetFullfilePath() | Should be $true
            }

            It '[Javascript] Bootstrap'{
                $var | ? {$_.Type -eq 'Script' -and $_.Name -eq 'Bootstrap'} | Should not BeNullOrEmpty
                ($var | ? {$_.Type -eq 'Script' -and $_.Name -eq 'Bootstrap'} | Measure).Count | Should be 1
                Test-Path ($var | ? {$_.Type -eq 'Script' -and $_.Name -eq 'Bootstrap'}).GetFullfilePath() | Should be $true
            }

            It '[Javascript] Jquery'{
                $var | ? {$_.Type -eq 'Script' -and $_.Name -eq 'Jquery'} | Should not BeNullOrEmpty
                ($var | ? {$_.Type -eq 'Script' -and $_.Name -eq 'Jquery'} | Measure).Count | Should be 1
                Test-Path ($var | ? {$_.Type -eq 'Script' -and $_.Name -eq 'Jquery'}).GetFullfilePath() | Should be $true
            }

            It '[Javascript] ChartJs'{
                $var | ? {$_.Type -eq 'Script' -and $_.Name -eq 'ChartJS'} | Should not BeNullOrEmpty
                ($var | ? {$_.Type -eq 'Script' -and $_.Name -eq 'ChartJS'} | Measure).Count | Should be 1
                Test-Path ($var | ? {$_.Type -eq 'Script' -and $_.Name -eq 'ChartJS'}).GetFullfilePath() | Should be $true
            }
            
        }
        
        Context "Get-PSHTMLAsset Functionality check"{

            It '[GetType()] Base type should be [Asset]' {
                $Ass = Get-PSHTMLAsset
                Foreach($a in $ass){
                    
                    ($a).GetType().BaseType.Name | Should be "Asset"
                }
            }

            It '[-Name ChartJs] Should return ChartJS Script Asset'{
                $N = Get-PSHTMLAsset -Name 'ChartJs' 
                $N.Name | Should be 'ChartJs'
                $N.Type | Should be 'Script'
            }

            It '[-Type Script] Should return only script Asset types'{
                $Scripts = Get-PSHTMLAsset -type 'Script'
                Foreach($s in $Scripts){
                    $s.Type | Should be 'Script'
                }
            }

            It '[-Type Style] Should return only Style Asset types'{
                $Scripts = Get-PSHTMLAsset -type 'Style'
                Foreach($s in $Scripts){
                    $s.Type | Should be 'Style'
                }
            }
        }

        Context "Write-PSHTMLAsset Functionality Check"{
            It '[ParameterLessCall] Should not throw' {
                {Write-PSHTMLAsset} | Should Not Throw
                Write-PSHTMLAsset | Should not BeNullOrEmpty
            }

            It '[Parameterless] Should write all <Script> & <Link> tags' {
                #This test tests if all the script and link tags are printed out when called without any parameter.
                #I make an assumption that by default, PSHTML has Scripts (.Js) AND Style (.css) files located in $RootFolder/Assets.
                # In version 0.7.3 it is so (Bootstrap has .css and .js files). However, this could change in the futur. And this Test could becomme obsolete.

                {Write-PSHTMLAsset} | Should Not Throw
                $HtmlScripts = Write-PSHTMLAsset 
                $HasScript = $false
                $HasStyle = $False
                Foreach($sci in $HtmlScripts){
                    write-output $sci
                    if($sci -Match '^<Script.*$'){
                        
                        $sci | Should match '^<Script src=.*></Script>$' 
                        $HasScript = $true
                    }elseIf($sci -Match '^<Link.*$'){

                        $sci | Should match "^<Link rel='stylesheet'.*>$" 
                        $HasStyle = $true
                    }
                }


                $HasScript -and $HasStyle | Should be $true
            }

            It '[-Type Script] Should write all <Script> Tags (only)' {
                {Write-PSHTMLAsset -Type Script} | Should Not Throw
                $HtmlScripts = Write-PSHTMLAsset -Type Script 
                Foreach($Hs in $HtmlScripts){
                    $Hs | Should match '^<Script src=.*></Script>$' 
                }
            }

            It '[-Type Style] Should write all <Link> Tags (only)' {
                {Write-PSHTMLAsset -Type Script} | Should Not Throw
                $htmlStyles = Write-PSHTMLAsset -Type Style 
                Foreach($Hstyle in $htmlStyles){
                    $Hstyle | Should match "^<Link rel='stylesheet'.*>$" 
                }
            }

            It '[-Name ChartJs] Should write ChartJs Tag ' {
                
                $HtmlScripts = Write-PSHTMLAsset -Name Chartjs
                Foreach($Hs in $HtmlScripts){
                    $Hs | Should match '^<Script src=.*Chartjs.*></Script>$' 
                }
            }

            It '[-Name BootStrap -Type Script] Should write Script Tags ' {
                
                $ss = Write-PSHTMLAsset -Name BootStrap -Type Script
               
                foreach($s in $ss){

                    $s | Should match '^<Script src=.*BootStrap.*></Script>$' 
                }
                
            }

            It '[-Name BootStrap -Type Script] Should write Style Tags ' {
                
                $st = Write-PSHTMLAsset -Name BootStrap -Type Style
                Foreach($t in $St){
                    $t | Should match "^<Link rel='stylesheet'.*Bootstrap.*>$" 
                }
            }

            It '[-Name BootStrap] Should write Script And Style Tags ' {
                
                #If no type is specified, and that the Asset has one or several script / style tags. All of them should be printed out.
                $HtmlScripts = Write-PSHTMLAsset -Name BootStrap
                ($HtmlScripts | Measure).Count | Should be 2 # Bootstrap has one .js file and .css file.
                $HasScript = $false
                $HasStyle = $False
                Foreach($sci in $HtmlScripts){
                    
                    if($sci -Match '^<Script.*$'){
                        
                        $sci | Should match '^<Script src=.*BootStrap.*></Script>$' 
                        $HasScript = $true
                    }elseIf($sci -Match '^<Link.*$'){

                        $sci | Should match "^<Link rel='stylesheet'.*Bootstrap.*>$"  
                        $HasStyle = $true
                    }
                }

                $HasScript -and $HasStyle | Should be $true

            }

        }

    }
}