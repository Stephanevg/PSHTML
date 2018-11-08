Function pre {
    <#
    .SYNOPSIS
    Create a pre tag in an HTML document.

    .EXAMPLE

    pre
    .EXAMPLE
    pre -Content @"

        whatever
        it       is

        you ne  ed
    "@

    .EXAMPLE
    pre -class "classy" -style "stylish" -Content @"

        whatever
        it       is

        you ne  ed
    "@

    .NOTES
    Current version 3.1.0
       History:
       2018.10.30;@ChristopheKumor;Updated to version 3.0
       2018.10.02:bateskevin; Updated to v2 
       2018.04.01;bateskevin;Creation.
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [Cmdletbinding()]
    Param(
        [Parameter(Mandatory = $true)]
        [AllowEmptyString()]
        [AllowNull()]
        $Content,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class = "",

        [String]$Id,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Style,

        [String]$title,

        [Hashtable]$Attributes
    )

    Process {
        $tagname = "pre"

        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid
        
    }
}