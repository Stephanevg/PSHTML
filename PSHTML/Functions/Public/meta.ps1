Function meta {
    <#
    .SYNOPSIS
    Create a meta title in an HTML document.

    .DESCRIPTION

    Metadata is data (information) about data.

    The <meta> tag provides metadata about the HTML document. Metadata will not be displayed on the page, but will be machine parsable.

    Meta elements are typically used to specify page description, keywords, author of the document, last modified, and other metadata.

    The metadata can be used by browsers (how to display content or reload page), search engines (keywords), or other web services.

    (source --> https://www.w3schools.com/tags/tag_meta.asp)
    .EXAMPLE

    meta
    .EXAMPLE
    meta "woop1" -Class "class"

    .EXAMPLE
    meta "woop2" -Class "class" -Id "MainTitle"

    .EXAMPLE
    meta {"woop3"} -Class "class" -Id "MaintTitle" -Style "color:red;"

    .EXAMPLE

    meta -name author -content "Stephane van Gulick"

    Generates the following code:

    <meta name="author" content="Stephane van Gulick"  >

    .Notes
    Author: Stéphane van Gulick
    Version: 1.0.0
    History:
        2018.04.14;@Stephanevg; Creation
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [Cmdletbinding()]
    Param(
        [Parameter(Mandatory=$false)]
        [AllowEmptyString()]
        [AllowNull()]
        [string]$content,

        [Parameter(Mandatory=$false)]
        [AllowEmptyString()]
        [AllowNull()]
        [string]$charset,

        [ValidateSet("content-type","default-style","refresh")]
        [Parameter(Mandatory=$false)]
        [AllowEmptyString()]
        [AllowNull()]
        [string]$httpequiv,

        [ValidateSet("application-name","author","description","generator","keywords","viewport")]
        [Parameter(Mandatory=$false)]
        [AllowEmptyString()]
        [AllowNull()]
        [string]$name,

        [Parameter(Mandatory=$false)]
        [AllowEmptyString()]
        [AllowNull()]
        [string]$scheme,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$class,

        [String]$id,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Style,

        [Hashtable]$Attributes
    )

    $attr = ""
    #for the meta tag, content is a regular attribute that we can use.
    $CommonParameters = ("Attributes","httpequiv") + [System.Management.Automation.PSCmdlet]::CommonParameters + [System.Management.Automation.PSCmdlet]::OptionalCommonParameters
    $CustomParameters = $PSBoundParameters.Keys | Where-Object -FilterScript { $_ -notin $CommonParameters }

    if($CustomParameters){

        foreach ($entry in $CustomParameters){


            $Attr += "{0}=`"{1}`" " -f $entry,$PSBoundParameters[$entry]

        }

    }

    if($httpequiv){
        $Attr += "http-equiv=`"{0}`" " -f $PSBoundParameters['httpequiv']
    }

    if($Attributes){
        foreach($entry in $Attributes.Keys){

            $attr += "{0}=`"{1}`" " -f $entry,$Attributes[$Entry]
        }
    }

    if($attr){
        "<meta {0} >"  -f $attr
    }else{
        "<meta>"
    }



}
