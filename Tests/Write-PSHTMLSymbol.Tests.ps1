$TestsPath = Split-Path $MyInvocation.MyCommand.Path

#$FunctionsPath = join-Path -Path (get-item $TestsPath).Parent -ChildPath "Functions"

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\PSHTML -Force

Describe 'Write-PSHTMLSymbol' {
    $Value = "GREEK CAPITAL LETTER ZETA"
    $Result = Write-PSHTMLSymbol -Name 'GREEK CAPITAL LETTER ZETA'
    it 'should return &Zeta;' {
        $Result | should be '&Zeta;'
    }
}