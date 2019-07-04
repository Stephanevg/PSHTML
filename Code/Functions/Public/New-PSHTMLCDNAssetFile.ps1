Function New-PSHTMLCDNAssetFile {
    [CmdletBinding()]
    Param(
        [ValidateSet('Style','script')]
        [String]$Type,
        [Parameter(
            ParametersetName = "Script"
        )]
        [String]$Source,
        [Parameter(
            ParametersetName = "Style"
        )]
        [String]$Link,

        [String]$Integrity,

        [String]$CrossOrigin,

        [Parameter(mandatory=$false)]
        [String]$FilePath
    )

    $hash = @{}
    $Hash.Source = $Source
    $Hash.Integrity = $Integrity
    $Hash.Crossorigin = $CrossOrigin

    $obj = New-Object psobject -Property $hash

    $obj | ConvertTo-Json | out-file -FilePath $FilePath -Encoding utf8

}