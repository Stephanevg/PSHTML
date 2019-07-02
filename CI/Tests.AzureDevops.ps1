
$PSVersionTable
install-module pester -Force
$TestsFolder = join-path -path "$($env:BUILD_SOURCESDIRECTORY)" -childpath "Tests"
write-host "sourcedirectory = $($env:BUILD_SOURCESDIRECTORY)"
gci $env:BUILD_SOURCESDIRECTORY
set-location $TestsFolder
$res = Invoke-Pester -Path $TestsFolder -OutputFormat NUnitXml -OutputFile TestsResults.xml -PassThru #-CodeCoverage $TestFiles

if ($res.FailedCount -gt 0 -or $res.PassedCount -eq 0) { 
    throw "$($res.FailedCount) tests failed - $($res.PassedCount) successfully passed"
};
$PSVersionTable