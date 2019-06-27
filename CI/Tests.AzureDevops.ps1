
install-module pester -Force
$TestsFolder = "$($env:Build_SourcesDirectory)/Tests"
gci env:
write-host "sourcedirectory = $($env:Build_SourcesDirectory)"
set-location $TestsFolder
$res = Invoke-Pester -Path $TestsFolder -OutputFormat NUnitXml -OutputFile TestsResults.xml -PassThru #-CodeCoverage $TestFiles
