Function blockquote {
    <#
    .SYNOPSIS
    Create a blockquote tag in an HTML document.

    .EXAMPLE
    blockquote -cite "https://www.google.com" -Content @"
        Google is a
        great website
        to search for information
    "@

    .EXAMPLE
    blockquote -cite "https://www.google.com" -class "classy" -style "stylish" -Content @"
        Google is a
        great website
        to search for information
    "@

    .NOTES
    Current version 3.1
       History:
            2018.11.1; Stephanevg;Updated to version 3.1
            2018.10.30;@ChristopheKumor;Updated to version 3.0
            2018.10.29;@ChristopheKumor;New Set-HtmlTag function to version 2.2
            2018.10.02;@NicolasBaudin;Fixed pipeline support bug. to version 2.1
            2018.10.02;@stephanevg;Fixed error when no content passed. to version 2.0
            2018.10.02;bateskevin;updated to version 2.0
            2018.05.07;stephanevg;updated to version 1.0
            2018.04.01;bateskevinhanevg;Creation.
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [Cmdletbinding()]
    Param(

        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $false,
            Position = 0
        )]
        [AllowEmptyString()]
        [AllowNull()]
        $Content,

        [string]$cite,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class,

        [String]$Id,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Style,

        [String]$title,

        [Hashtable]$Attributes
    )

    $tagname = "blockquote"
    Set-htmltag -TagName $tagName -Parameters $PSBoundParameters -TagType NonVoid    


}
