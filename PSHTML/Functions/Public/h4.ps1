Function h4 {
    <#
    .SYNOPSIS
    Create a h4 title in an HTML document.

    .EXAMPLE

    h4
    .EXAMPLE
    h4 "woop1" -Class "class"

    .EXAMPLE
    h4 "woop2" -Class "class" -Id "MainTitle"

    .EXAMPLE
    h4 {"woop3"} -Class "class" -Id "MaintTitle" -Style "color:red;"

    .Notes
    Author: Stéphane van Gulick
    Version: 3.1.0
    History:
    2018.10.30;@ChristopheKumor;Updated to version 3.0
        2018.04.08;Stephanevg; Updated to version 1.0: Updated content block to support string & ScriptBlock
        2018.03.25;@Stephanevg; Creation
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

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Style,

        [Hashtable]$Attributes
    )

    Process {
        $tagname = "h4"
        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid
    }
}