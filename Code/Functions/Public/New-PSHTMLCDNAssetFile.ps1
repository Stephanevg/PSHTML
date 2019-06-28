Function New-PSHTMLCDNAssetFile {
    [CmdletBinding()]
    Param(
        [String]$Source,
        [String]$Integrity,
        [String]$CrossOrigin,
        [String]$FilePath
    )

    $hash = @{}
    $Hash.Source = $Source
    $Hash.Integrity = $Integrity
    $Hash.Crossorigin = $CrossOrigin

    $obj = New-Object psobject -Property $hash

    $obj | ConvertTo-Json | out-file -FilePath $FilePath -Encoding utf8

}