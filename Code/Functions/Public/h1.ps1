Function H1 {
    <#
    .SYNOPSIS
    Create a h1 title in an HTML document.

    .EXAMPLE

    h1
    .EXAMPLE
    h1 "woop1" -Class "class"

    .EXAMPLE
    h1 "woop2" -Class "class" -Id "MainTitle"

    .EXAMPLE
    h1 {"woop3"} -Class "class" -Id "MaintTitle" -Style "color:red;"

    .Notes
    Author: Stéphane van Gulick
    Version: 3.1.0
    History:
    2018.10.30;@ChristopheKumor;Updated to version 3.0
        2018.04.08;Stephanevg; Updated to version 1.0: Updated content block to support string & ScriptBlock
        2018.04.08;Stephanevg; Fixed custom Attributes display bug. Updated help
        2018.03.25;@Stephanevg; Added Styles, ID, CLASS attributes functionality
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
        $tagname = "h1"
        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid
    }
}