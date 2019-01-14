Function optgroup {
    <#
    .SYNOPSIS
    Create a optgroup title in an HTML document.

    .DESCRIPTION
    The <optgroup> is used to group related options in a drop-down list.

    If you have a long list of options, groups of related options are easier to handle for a user.

    .EXAMPLE

    optgroup
    .EXAMPLE
    

    .Notes
    Author: Stéphane van Gulick
    Version: 3.1.0
    History:
    2018.10.30;@ChristopheKumor;Updated to version 3.0
        2018.05.11;@Stephanevg; fixed minor bugs
        2018.05.09;@Stephanevg; Creation

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

        [Parameter(Mandatory = $false)]
        [String]$Label,

        [Switch]
        $Disabled,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Id,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Style,

        [Hashtable]$Attributes
    )

    $tagname = "optgroup"

    Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid


}
