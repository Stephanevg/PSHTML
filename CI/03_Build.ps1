Write-Host "[BUILD][START] Launching Build Process" -ForegroundColor RED -BackgroundColor White

# Retrieve parent folder
$Current = (Split-Path -Path $MyInvocation.MyCommand.Path)
$Root = ((Get-Item $Current).Parent).FullName
$ModuleName = split-Path -Path $root -Leaf
Write-Host "[BUILD][START] Working on module $($ModuleName)" -ForegroundColor RED -BackgroundColor White
#$ModuleName = "PSClassUtils"
$ModuleFolderPath = Join-Path -Path $Root -ChildPath $ModuleName

$CodeSourcePath = Join-Path -Path $Root -ChildPath "Code"

$ExportPath = Join-Path -Path $ModuleFolderPath -ChildPath "$($ModuleName).psm1"
if(Test-Path $ExportPath){
    Write-Host "[BUILD][PSM1] PSM1 file detected. Deleting..." -ForegroundColor RED -BackgroundColor White
    Remove-Item -Path $ExportPath -Force
}
$DAte = Get-DAte
"#Generated at $($Date) by Stephane van Gulick" | out-File -FilePath $ExportPath -Encoding utf8 -Append

Write-Host "[BUILD][Code] Loading Class, public and private functions" -ForegroundColor RED -BackgroundColor White

$MainPSM1Contents = @()



$ClassFolderPath = "$CodeSourcePath\Classes\"
If(Test-Path $ClassFolderPath){
    $PublicClasses = Get-ChildItem -Path $ClassFolderPath -Filter *.ps1 | sort-object Name
    $MainPSM1Contents += $PublicClasses
}

$PrivateFunctionsFolderPath = "$CodeSourcePath\Functions\Private"
$PublicFunctionsFolderPath = "$CodeSourcePath\Functions\Public"
If(Test-Path $PrivateFunctionsFolderPath){

    $PrivateFunctions = Get-ChildItem -Path $PrivateFunctionsFolderPath -Filter *.ps1
    $MainPSM1Contents += $PrivateFunctions
}

If(Test-Path $PublicFunctionsFolderPath){

    $PublicFunctions = Get-ChildItem -Path $PublicFunctionsFolderPath -Filter *.ps1
    $MainPSM1Contents += $PublicFunctions
}



Write-Host "[BUILD][START][PRE] Adding Pre content" -ForegroundColor RED -BackgroundColor White

$PreContentPath = Join-Path -Path $Current -ChildPath "03_PreContent.ps1"

If(Test-Path $PrecontentPath){
    
    $file = Get-item $PreContentPath
    Gc $File.FullName | out-File -FilePath $ExportPath -Encoding utf8 -Append

}else{
    Write-Host "[BUILD][START][POST] No post content file found!" -ForegroundColor RED -BackgroundColor White

}

#Creating PSM1
Write-Host "[BUILD][START][MAIN PSM1] Building main PSM1" -ForegroundColor RED -BackgroundColor White
Foreach($file in $MainPSM1Contents){
    Gc $File.FullName | out-File -FilePath $ExportPath -Encoding utf8 -Append
    
}

Write-Host "[BUILD][START][POST] Adding post content" -ForegroundColor RED -BackgroundColor White

$PostContentPath = Join-Path -Path $Current -ChildPath "03_postContent.ps1"
If(test-Path $PostContentPath){

    $file = Get-item $PostContentPath
    Gc $File.FullName | out-File -FilePath $ExportPath -Encoding utf8 -Append
}else{
    Write-Host "[BUILD][START][POST] No post content file found!" -ForegroundColor RED -BackgroundColor White
}

Write-Host "[BUILD][START][PSD1] Adding functions to export" -ForegroundColor RED -BackgroundColor White

$FunctionsToExport = $PublicFunctions.BaseName
$Manifest = Join-Path -Path $ModuleFolderPath -ChildPath "$($ModuleName).psd1"
Update-ModuleManifest -Path $Manifest -FunctionsToExport $FunctionsToExport

Write-Host "[BUILD][END][MAIN PSM1] building main PSM1 " -ForegroundColor RED -BackgroundColor White

Write-Host "[BUILD][END]End of Build Process" -ForegroundColor RED -BackgroundColor White