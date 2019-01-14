Function Col {
    <#
    .SYNOPSIS
    Generates col HTML tag.

    .DESCRIPTION
    The <col> tag specifies column properties for each column within a <colgroup> element.
    The <col> tag is useful for applying styles to entire columns, instead of repeating the styles for each cell, for each row.

    .PARAMETER Class
    Allows to specify one (or more) class(es) to assign the html element.
    More then one class can be assigned by seperating them with a white space.

    .PARAMETER Id
    Allows to specify an id to assign the html element.

    .PARAMETER Style
    Allows to specify in line CSS style to assign the html element.


    .EXAMPLE

    col -span 3 -Class "Table1"

    Generates the following code

    <col span="3" Class="Table1"  >

    .EXAMPLE

    Col is often used in conjunction with 'colgroup'. See below for an example using colgroup and two col

    Colgroup {
        col -span 3 -Style "Background-color:red"
        col -Style "Backgroung-color:yellow"
    }

    Generates the following code
   <colgroup>
        <col span="3" Style="Background-color:red"  >
        <col Style="Backgroung-color:yellow"  >
    </colgroup>

    .NOTES
    Current version 3.1
    History:
        2018.11.1; Stephanevg;Updated to version 3.1
        2018.10.30;@ChristopheKumor;Updated to version 3.0
        2018.04.08;Stephanvg; Updated to version 1.0
        2018.04.01;Stephanevg;Fix disyplay bug.
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    Param(
        [Parameter(Position = 0)]
        [int]
        $span,

        [Parameter(Position = 1)]
        [String]$Class,

        [Parameter(Position = 2)]
        [String]$Id,

        [Parameter(Position = 3)]
        [String]$Style,

        [Parameter(Position = 4)]
        [Hashtable]$Attributes

    )

    Process {
        $tagname = "col"
        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType Void
    }

}
