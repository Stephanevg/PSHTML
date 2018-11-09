Function strong {
    <#
    .SYNOPSIS
    Generates strong HTML tag.

    .Description
    This tag is a "Textual semantic" tag. To use it in a "P" tag, be sure to prefix it with a semicolon (";").
    See example for more details.

    .EXAMPLE
    p{
        "This is";strong {"cool"}
    }

    Will generate the following code

    <p>
        This is
        <strong>
        cool
        </strong>
    </p>



    .Notes
    Author: Stéphane van Gulick
    Version: 3.1.0
    History:
    2018.10.30;@ChristopheKumor;Updated to version 3.0
        2018.05.23;@Stephanevg; Updated function to use New-HTMLTag
        2018.05.09;@Stephanevg; Creation

    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [CmdletBinding()]
    Param(

        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $true,
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
    $tagname = "strong"

    Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid

}


