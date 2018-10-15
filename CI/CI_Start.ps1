import-module pester
start-sleep -seconds 2

write-output "BUILD_FOLDER: $($env:APPVEYOR_BUILD_FOLDER)"
write-output "PROJECT_NAME: $($env:APPVEYOR_PROJECT_NAME)"
write-output "BRANCH: $($env:APPVEYOR_REPO_BRANCH)"
$ModuleClonePath = Join-Path -Path $env:APPVEYOR_BUILD_FOLDER -ChildPath $env:APPVEYOR_PROJECT_NAME
Write-Output "MODULE CLONE PATH: $($ModuleClonePath)"

$moduleName = "$($env:APPVEYOR_PROJECT_NAME)"
Get-Module $moduleName

#Pester Tests
write-verbose "invoking pester"
#$TestFiles = (Get-ChildItem -Path .\ -Recurse  | ?{$_.name.EndsWith(".ps1") -and $_.name -notmatch ".tests." -and $_.name -notmatch "build" -and $_.name -notmatch "Example"}).Fullname
$res = Invoke-Pester -Path ".\Tests" -OutputFormat NUnitXml -OutputFile TestsResults.xml -PassThru #-CodeCoverage $TestFiles

#Uploading Testresults to Appveyor
(New-Object 'System.Net.WebClient').UploadFile("https://ci.appveyor.com/api/testresults/nunit/$($env:APPVEYOR_JOB_ID)", (Resolve-Path .\TestsResults.xml))


if ($res.FailedCount -gt 0) { throw "$($res.FailedCount) tests failed."};

    
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
        if($Localversion -le $GalleryVersion){
            Write-host "[$($env:APPVEYOR_REPO_BRANCH)] PsClassUtils version $($localversion)  is identical with the one on the gallery. No upload will be done."
        }Else{
            If($env:APPVEYOR_REPO_COMMIT_MESSAGE -match '^push psgallery.*$ '){

                try{

                    publish-module -Name $ModuleName -NuGetApiKey $Env:PSgalleryKey -ErrorAction stop;
                    write-host "[$($env:APPVEYOR_REPO_BRANCH)][$($LocalVersion)] Module deployed to the psgallery" -foregroundcolor green;
                }Catch{
                    write-host "[$($env:APPVEYOR_REPO_BRANCH)][$($LocalVersion)] An error occured while publishing the module to the gallery" -foregroundcolor red;
                    write-host "[$($env:APPVEYOR_REPO_BRANCH)][$($LocalVersion)] $_" -foregroundcolor red;
                }
            }else{

            }
        }
    }else{
        write-host "[$($env:APPVEYOR_REPO_BRANCH)] Build tasks finished." -foregroundcolor Yellow;
}