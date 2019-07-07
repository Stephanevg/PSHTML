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
        [String]$rel= "stylesheet",

        [Parameter(
            ParametersetName = "Style"
        )]
        [String]$href,

        [String]$Integrity,

        [String]$CrossOrigin,

        
        [Parameter(mandatory=$false)]
        [String]$FileName = (Throw "Please specifiy a file name"),

        [Parameter(mandatory=$false)]
        [String]$Path
    )

    $hash = @{}
    $Hash.Integrity = $Integrity
    $Hash.Crossorigin = $CrossOrigin
    
    switch($type){
        "Script" {

            $Hash.Source = $Source
            break
        }
        "Style" {
            $Hash.rel = $rel
            $hash.href = $href
            break
        }
        default {"Type $($Type) no supported."}
    }

    If(!($FileName.EndsWith('.cdn'))){
        $FileName = $FileName + '.cdn'
    }

    $FilePath = Join-Path -Path $Path -ChildPath $FileName

    $obj = New-Object psobject -Property $hash

    $obj | ConvertTo-Json | out-file -FilePath $FilePath -Encoding utf8

    return Get-Item $FilePath

}