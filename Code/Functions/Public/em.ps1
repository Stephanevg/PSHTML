Function em {
    <#
    .SYNOPSIS
    Generates em HTML tag.

    .Description
    This tag is a phrase tag. It renders as emphasized text.

    .EXAMPLE
    p{
        "This is";em {"cool"}
    }

    Will generate the following code

    <p>
        This is
        <em>
        cool
        </em>
    </p>

    .Notes
    Author: Andrew Wickham
    Version: 3.1.0
    History:
    2018.10.30;@ChristopheKumor;Updated to version 3.0
        2018.10.04;@awickham10; Creation

    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [CmdletBinding()]
    Param(

        [Parameter(
            ValueFromPipeline = $true,
            Position = 0
        )]
        $Content,

        [Parameter(Position = 1)]
        [String]$Class,

        [Parameter(Position = 2)]
        [String]$Id,

        [Parameter(Position = 3)]
        [String]$Style,

        [Parameter(Position = 4)]
        [Hashtable]$Attributes

    )

    $tagname = "em"

    Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType NonVoid



}