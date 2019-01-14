Function Link {
    <#
    .SYNOPSIS
    Create a link title in an HTML document.

    .EXAMPLE

    link

    #Generates the following code:

    <link>

    .EXAMPLE

    link -Attributes @{"Attribute1"="val1";"Attribute2"="val2"}

    Generates the following code

    <link Attribute1="val1" Attribute2="val2"  >

    .EXAMPLE

    $Style = "font-family: arial; text-align: center;"
    link -Style $style

    Generates the following code

    <link Style="font-family: arial; text-align: center;"  >

    .Notes
    Author: Stéphane van Gulick
    Version: 3.1.0
    History:
    2018.10.30;@ChristopheKumor;Updated to version 3.0
        2018.04.08;Stephanevg; Updated to version 1.0: Updated content block to support string & ScriptBlock
        2018.03.25;@Stephanevg; Added Styles, ID, CLASS attributes functionality
        2018.03.25;@Stephanevg; Creation
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    Param(
        [Parameter(Mandatory = $true)]
        [String]
        $href,

        [AllowEmptyString()]
        [AllowNull()]
        $type,

        [Parameter(Mandatory = $False)]
        [Validateset("alternate", "author", "dns-prefetch", "help", "icon", "license", "next", "pingback", "preconnect", "prefetch", "preload", "prerender", "prev", "search", "stylesheet")]
        [string]
        $rel,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Integrity,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$CrossOrigin,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class,

        [String]$Id,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Style,

        [Hashtable]$Attributes
    )


    Process {
        $tagname = "link"
        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType Void
    }

}

