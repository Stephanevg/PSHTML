
install-module pester
$TestsFolder = "$($env:Build.SourcesDirectory)/Tests"
set-location $TestsFolder
$res = Invoke-Pester -Path $TestsFolder -OutputFormat NUnitXml -OutputFile TestsResults.xml -PassThru #-CodeCoverage $TestFiles
