Function New-PSHTMLCDNAssetFile {
    <#
    .SYNOPSIS
        Allows to create a CDN file.
        
    .DESCRIPTION
        Creates a .CDN file to use as a PSHTML Asset.
        The CDN file is automatically supported by Write-PSHTMLAsset and will create the CDN automatically based on the content of the CDN file.

    .PARAMETER TYPE
    Specify if the Asset should cover Script or Style references
    Parameters allowd: Script / Style

    .PARAMETER Source

    Specify the src attribute of a script tag.

    .PARAMETER Rel

    Specify the rel attribute of a link tag.

    .PARAMETER Href

    Specify the href attribute of a link tag.

    .PARAMETER Integrity

    Specify the integrity attribute.

    .PARAMETER CrossOrigin

    Specify the CrossOrigin attribute.

    .PARAMETER Path

    Specify in which folder path the file should be created (will use the parameter FileName to create the full path)

    .PARAMETER FileName

    Specify the name of the file that the cdn asset file will have (will use the parameter Path to create the full path).
    The FileName should end with the extension .CDN 
    If the extension .CDN is omitted, PSHTML will dynamically add it

    .EXAMPLE
        Add the latest version of Bootstrap CDN
        #Information of this example comes from -> https://getbootstrap.com/docs/4.3/getting-started/introduction/

        $Source = 'https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js'
        $Integrity = 'sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM'
        $CrossOrigin = 'anonymous'
        $BootStrapFolder =  $home\BootStrap4.3.1
        New-PSHTMLCDNAssetFile -Type script -Source $Source -Integrity $Integrity -CrossOrigin $CrossOrigin -Path $BootStrapFolder -FileName 'BootStrap4.3.1.cdn'

    .EXAMPLE
        Adds the latest version of MetroUI as an CDN asset

        $Href = 'https://cdn.metroui.org.ua/v4/css/metro-all.min.css'
        $Folder =  $home\MetroUI\
        New-PSHTMLCDNAssetFile -Type style -href $href -Path $Folder -FileName 'MetroUI.cdn'

    .INPUTS
        Inputs (if any)
    .OUTPUTS
        System.IO.FileInfo
    .NOTES
        Author: Stephane van Gulick
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [CmdletBinding()]
    Param(
        [ValidateSet('Style','script')]
        [String]$Type,

        [Parameter(
            ParametersetName = "Script"
        )]
        [String]$source,

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

            $Hash.source = $Source
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