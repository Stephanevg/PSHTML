
$TestsFolder = "$($env:Build.SourcesDirectory)/Tests"
$res = Invoke-Pester -Path $TestsFolder -OutputFormat NUnitXml -OutputFile TestsResults.xml -PassThru #-CodeCoverage $TestFiles
