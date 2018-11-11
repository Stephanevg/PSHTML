Function small {
    <#
    .SYNOPSIS
    Create a <small> element in an HTML document.

    .DESCRIPTION
    The <small> tag defines smaller text (and other side comments).


    .EXAMPLE

    small

    Returns>

    <small>
    </small>
    .EXAMPLE
    small "woop1" -Class "class"

    <small Class="class"  >
        woop1
    </small>

    .Notes
    Author: Stéphane van Gulick
    Version: 3.1.0
    History:
    2018.10.30;@ChristopheKumor;Updated to version 3.0
        2018.10.04;@Stephanevg; Creation

    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [Cmdletbinding()]
    Param(

        [Parameter(Mandatory = $false)]
        [AllowEmptyString()]
        [AllowNull()]
        $Content,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class,

        [String]$Id,

        [String]$Style,

        [Hashtable]$Attributes
    )

    $tagname = "small"

    Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid
}

