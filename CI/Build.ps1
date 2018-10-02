import-module pester
start-sleep -seconds 2

Get-Module PSHTML

#Pester Tests
write-verbose "invoking pester"
$TestFiles = (Get-ChildItem -Path .\ -Recurse  | ?{$_.name.EndsWith(".ps1") -and $_.name -notmatch ".tests." -and $_.name -notmatch "build" -and $_.name -notmatch "Example"}).Fullname
$res = Invoke-Pester -Path ".\Tests" -OutputFormat NUnitXml -OutputFile TestsResults.xml -PassThru -CodeCoverage $TestFiles

#Uploading Testresults to Appveyor
(New-Object 'System.Net.WebClient').UploadFile("https://ci.appveyor.com/api/testresults/nunit/$($env:APPVEYOR_JOB_ID)", (Resolve-Path .\TestsResults.xml))
