$TestsPath = Split-Path $MyInvocation.MyCommand.Path

#$FunctionsPath = join-Path -Path (get-item $TestsPath).Parent -ChildPath "Functions"

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\PSHTML -Force

InModuleScope PSHTML {


    Describe "Testing New-PSHTMLCDNAssetFile" {

        Context 'General tests' {

            It '[No Parameters] Should throw' {
                {New-PSHTMLCDNAssetFile | Should Throw}
            }
            $Source = "PlopSource"
            $Integrity = "12345"
            $CrossOrigin = "Anonymous"
            $Path = $TestDrive

            $FileName = "woop.cdn"
            $CDNFilePath = join-Path $TestDrive -ChildPath $FileName

            It 'Should create an Asset File' {
                New-PSHTMLCDNAssetFile -Type script -Source $Source -Integrity $Integrity -CrossOrigin $CrossOrigin -Path $testdrive -FileName $FileName
                test-Path $CDNFilePath | Should be $true
            }

            it 'Should return FileInfo object' {
                $ReturnFile = New-PSHTMLCDNAssetFile -Type script -Source $Source -Integrity $Integrity -CrossOrigin $CrossOrigin -Path $testdrive -FileName $FileName

                $ReturnFile -eq $null | Should -Be $false
                $ReturnFile.GetType().FullName | Should be 'System.IO.FileInfo'
            }

            It 'Should create the correct content' {
                $CDNContent = gc $CDNFilePath -Raw | ConvertFrom-Json

                $CDNContent.Source | should be $Source
                $CDNContent.Integrity | should be $Integrity
                $CDNContent.CrossOrigin | should be $CrossOrigin
            }

            
        }
        Context 'Testing case: Not all parameters are set' {

            $CDNFilePath = join-Path $TestDrive -childpath $CdnFilePath
            $FileName = "woop.cdn"
            $CDNFilePathPArtially = join-Path $CDNFilePath -ChildPath $FileName
            $Source = "PlopSource"
            It 'Should create an Asset File' {
                New-PSHTMLCDNAssetFile -Type script -Source $Source -Path $TestDrive -FileName $FileName
                test-Path $CDNFilePathPArtially | Should be $true
            }
    
            It 'Should create the correct content' {
                $CDNContent = gc $CDNFilePathPArtially -Raw | ConvertFrom-Json
    
                $CDNContent.Source | should be $Source
                $CDNContent.Integrity | should -BeNullOrEmpty
                $CDNContent.CrossOrigin | should -BeNullOrEmpty
            }
        }

        Context 'Testing case: Styles CDN file (.css) no crossorigin, integrity' {

            $FileName = "Styles.cdn"
            $CDNFilePathPArtially = join-Path $TestDrive -ChildPath $FileName
            
 
            $href = "http:\\PlopSource"
            $rel = "stylesheet"
            It 'Should create an Asset File' {
                New-PSHTMLCDNAssetFile -Type Style -href $href -Path $TestDrive -FileName $FileName
                test-Path $CDNFilePathPArtially | Should be $true
            }
    
            It 'Should create the correct content' {
                $CDNContent = gc $CDNFilePathPArtially -Raw | ConvertFrom-Json
                $CDNContent.rel = $rel
                $CDNContent.$href | should be $Source
                $CDNContent.Integrity | should -BeNullOrEmpty
                $CDNContent.CrossOrigin | should -BeNullOrEmpty
            }
        }

        Context 'Testing case: Styles CDN file (.css) with crossorigin, integrity' {

            $FileName = "styles.cdn"
            $CDNFilePath = join-Path $TestDrive -ChildPath $FileName
            
            $href = "http:\\PlopSource"
            $rel = "stylesheet"
            $Crossorigin = "anonymous"
            $Integrity = "123456"
            It 'Should create an Asset File' {
                New-PSHTMLCDNAssetFile -Type Style -href $href -Integrity $Integrity -CrossOrigin $Crossorigin -Path $TestDrive -FileName $FileName
                test-Path $CDNFilePath | Should be $true
            }
    
            It 'Should create the correct content' {
                $CDNContent = gc $CDNFilePath -Raw | ConvertFrom-Json
                $CDNContent.rel = $rel
                $CDNContent.$href | should be $Source
                $CDNContent.Integrity | should be $Integrity
                $CDNContent.CrossOrigin | should be $Crossorigin
            }
        }

    }

}