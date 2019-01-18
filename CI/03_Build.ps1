Write-Host "[BUILD][START] Launching Build Process" -ForegroundColor RED -BackgroundColor White

# Retrieve parent folder
$Current = (Split-Path -Path $MyInvocation.MyCommand.Path)
$Root = ((Get-Item $Current).Parent).FullName
$ModuleName = "PSHTML"
$ModuleFolderPath = Join-Path -Path $Root -ChildPath $ModuleName

$CodeSourcePath = Join-Path -Path $Root -ChildPath "Code"

$ExportPath = Join-Path -Path $ModuleFolderPath -ChildPath "pshtml.psm1"
if(Test-Path $ExportPath){
    Write-Host "[BUILD][PSM1] PSM1 file detected. Deleting..." -ForegroundColor RED -BackgroundColor White
    Remove-Item -Path $ExportPath -Force
}
$DAte = Get-DAte
"#Generated at $($Date) by Stephane van Gulick" | out-File -FilePath $ExportPath -Encoding utf8 -Append

Write-Host "[BUILD][Code] Loading Class, public and private functions" -ForegroundColor RED -BackgroundColor White

$PublicClasses = Get-ChildItem -Path "$CodeSourcePath\Classes\" -Filter *.ps1 | sort-object Name
$PrivateFunctions = Get-ChildItem -Path "$CodeSourcePath\Functions\Private" -Filter *.ps1
$PublicFunctions = Get-ChildItem -Path "$CodeSourcePath\Functions\Public" -Filter *.ps1

$MainPSM1Contents = @()
$MainPSM1Contents += $PublicClasses
$MainPSM1Contents += $PrivateFunctions
$MainPSM1Contents += $PublicFunctions



#Creating PSM1
Write-Host "[BUILD][START][MAIN PSM1] Building main PSM1" -ForegroundColor RED -BackgroundColor White
Foreach($file in $MainPSM1Contents){
    Gc $File.FullName | out-File -FilePath $ExportPath -Encoding utf8 -Append
    
}

Write-Host "[BUILD][START][POST] Adding post content" -ForegroundColor RED -BackgroundColor White

$PostContentPath = Join-Path -Path $Current -ChildPath "03_postContent.ps1"
$file = Get-item $PostContentPath
Gc $File.FullName | out-File -FilePath $ExportPath -Encoding utf8 -Append

Write-Host "[BUILD][START][PSD1] Adding functions to export" -ForegroundColor RED -BackgroundColor White

$FunctionsToExport = $PublicFunctions.BaseName
$Manifest = Join-Path -Path $ModuleFolderPath -ChildPath "pshtml.psd1"
Update-ModuleManifest -Path $Manifest -FunctionsToExport $FunctionsToExport

Write-Host "[BUILD][END][MAIN PSM1] building main PSM1 " -ForegroundColor RED -BackgroundColor White

Write-Host "[BUILD][END]End of Build Process" -ForegroundColor RED -BackgroundColor White