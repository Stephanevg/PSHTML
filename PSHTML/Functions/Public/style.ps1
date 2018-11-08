Function style {
    <#
    .SYNOPSIS
    Create a style title in an HTML document.

    .EXAMPLE

    style
    .EXAMPLE
    style "woop1" -Class "class"

    .EXAMPLE
    $css = @"
        "p {color:green;}
        h1 {color:orange;}"
    "@
    style {$css} -media "print" -type "text/css"

    .Notes
    Author: Stéphane van Gulick
    Version: 3.1.0
    History:
    2018.10.30;@ChristopheKumor;Updated to version 3.0
        2018.05.09;@Stephanevg; Creation
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [Cmdletbinding()]
    Param(
        [Parameter(Mandatory = $false)]
        [AllowEmptyString()]
        [AllowNull()]
        $Content,

        [String]$media,

        [String]$Type,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class,

        [String]$Id,

        [Hashtable]$Attributes
    )

    $tagname = "style"

    Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid



}
