
Write-Host "[TEST][START]" -ForegroundColor RED -BackgroundColor White
import-module pester
start-sleep -seconds 2

write-output "BUILD_FOLDER: $($env:APPVEYOR_BUILD_FOLDER)"
write-output "PROJECT_NAME: $($env:APPVEYOR_PROJECT_NAME)"
write-output "BRANCH: $($env:APPVEYOR_REPO_BRANCH)"
$ModuleClonePath = Join-Path -Path $env:APPVEYOR_BUILD_FOLDER -ChildPath $env:APPVEYOR_PROJECT_NAME
Write-Output "MODULE CLONE PATH: $($ModuleClonePath)"

$ModuleClonePath = Join-Path -Path $env:APPVEYOR_BUILD_FOLDER -ChildPath $env:APPVEYOR_PROJECT_NAME

$moduleName = "$($env:APPVEYOR_PROJECT_NAME)"
Get-Module $moduleName

#Pester Tests
write-verbose "invoking pester"
#$TestFiles = (Get-ChildItem -Path .\ -Recurse  | ?{$_.name.EndsWith(".ps1") -and $_.name -notmatch ".tests." -and $_.name -notmatch "build" -and $_.name -notmatch "Example"}).Fullname


$res = Invoke-Pester -Path "$($env:APPVEYOR_BUILD_FOLDER)/Tests" -OutputFormat NUnitXml -OutputFile TestsResults.xml -PassThru #-CodeCoverage $TestFiles

#Uploading Testresults to Appveyor
(New-Object 'System.Net.WebClient').UploadFile("https://ci.appveyor.com/api/testresults/nunit/$($env:APPVEYOR_JOB_ID)", (Resolve-Path ./TestsResults.xml))


if ($res.FailedCount -gt 0 -or $res.PassedCount -eq 0) { 
    throw "$($res.FailedCount) tests failed - $($res.PassedCount) successfully passed"
};


    
if ($res.FailedCount -eq 0 -and $res.successcount -ne 0) {
    If ($env:APPVEYOR_REPO_BRANCH -eq "master") {
        Write-host "[$($env:APPVEYOR_REPO_BRANCH)] All tested Passed, and on Branch 'master'"
        $OfficialModulePath = $env:PSModulePath.SPlit(";")[0]

        Copy-Item -Path $ModuleClonePath -Destination $OfficialModulePath -Recurse -Force

        Write-host "[$($env:APPVEYOR_REPO_BRANCH)][$($ModuleName)] Import module from: $($ModuleClonePath)\$($ModuleName).psd1" -ForegroundColor DarkGreen
        import-module "$($ModuleClonePath)\$($ModuleName).psd1" -Force
        try{
            $GalleryModule = Find-Module $ModuleName -ErrorAction stop
            $GalleryVersion = $GalleryModule.version 
        }catch{
            Write-host "[$($env:APPVEYOR_REPO_BRANCH)][$($ModuleName)] Module not found on the gallery (is this the First deployment perhaps?)"
        }
        $LocalVersion = (get-module $ModuleName).version.ToString()

        if($LocalVersion -eq ""){
            throw "Could not get version numbers"
        }

        if ($Localversion -le $GalleryVersion) {
            Write-host "[$($env:APPVEYOR_REPO_BRANCH)][$($ModuleName)] $($moduleName) version $($localversion)  is identical with the one on the gallery. No upload done."
            write-host "[$($env:APPVEYOR_REPO_BRANCH)][$($ModuleName)] Module not deployed to the psgallery" -foregroundcolor Yellow;
        }
        Else {
            $envIsLinux = $false
            if($IsLinux){

                $envIsLinux = $true
            }
            If($env:APPVEYOR_REPO_COMMIT_MESSAGE -match '^push psgallery.*$' -and $envIsLinux){

                try{
    
                    publish-module -Name $ModuleName -NuGetApiKey $Env:PSgalleryKey -ErrorAction stop;
                    write-host "[$($env:APPVEYOR_REPO_BRANCH)][$($ModuleName)][$($LocalVersion)] Module successfully deployed to the psgallery" -foregroundcolor green;
                }Catch{
                    write-host "[$($env:APPVEYOR_REPO_BRANCH)][$($ModuleName)][$($LocalVersion)] An error occured while publishing the module to the gallery" -foregroundcolor red;
                    write-host "[$($env:APPVEYOR_REPO_BRANCH)][$($ModuleName)][$($LocalVersion)] $_" -foregroundcolor red;
                }
            }else{
                write-host "[$($env:APPVEYOR_REPO_BRANCH)][$($LocalVersion)] All checks passed, but module not deployed to the gallery. " -foregroundcolor green;
            }

        }
    }Else{
        Write-host "[$($env:APPVEYOR_REPO_BRANCH)][$($ModuleName)] Awesome, nothing to do more. If you want to upload to the gallery, please merge from dev into master: use 'push gallery' in commit message to master to publish the module."
    }
}
else {
    Write-host "[$($env:APPVEYOR_REPO_BRANCH)][$($ModuleName)] Failed tests: $($res.failedcount) - Successfull tests: $($res.successcount)" -ForegroundColor Red
}
Write-Host "[TEST][END]" -ForegroundColor RED -BackgroundColor White