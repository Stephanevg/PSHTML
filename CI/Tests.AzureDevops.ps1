
install-module pester -Force
$TestsFolder = "$($env:Build.SourcesDirectory)/Tests"
gci $env:
write-host "sourcedirectory = $($env:Build.SourcesDirectory)"
set-location $TestsFolder
$res = Invoke-Pester -Path $TestsFolder -OutputFormat NUnitXml -OutputFile TestsResults.xml -PassThru #-CodeCoverage $TestFiles
