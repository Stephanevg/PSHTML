Function area {
    <#
    .SYNOPSIS
    Generates <area> HTML tag.

    .DESCRIPTION
    The are tag must be used in a <map> element (Use the 'map' function)

    The <area> element is always nested inside a <map> tag.

    More information can be found here --> https://www.w3schools.com/tags/tag_area.asp


    .PARAMETER Class
    Allows to specify one (or more) class(es) to assign the html element.
    More then one class can be assigned by seperating them with a white space.

    .PARAMETER Id
    Allows to specify an id to assign the html element.

    .PARAMETER Style
    Allows to specify in line CSS style to assign the html element.

    .PARAMETER Content
    Allows to add child element(s) inside the current opening and closing HTML tag(s).


    .EXAMPLE
    area -href "link.php" -alt "alternate description" -coords "0,0,10,10"

   Generates the following code:

    <area href="link.php" alt="alternate description" coords="0,0,10,10" >

    .EXAMPLE
    area -href image.png -coords "0,0,20,20" -shape rect

    Generates the following code:

    <area href="image.png"coords="0,0,20,20"shape="rect" >

    .NOTES
     Current version 3.1
        History:
            2018.11.08;Stephanevg; Updated to version 3.1
            2018.10.30;@ChristopheKumor;Updated to version 3.0
            2018.04.10;Stephanevg; Added parameters
            2018.04.01;Stephanevg;Creation.
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [CmdletBinding()]
    Param(


        [Parameter(Position = 0)]
        [String]$href,

        [Parameter(Position = 1)]
        [String]$alt,

        [Parameter(Position = 2)]
        [String]$coords,

        [Parameter(Position = 3)]
        [validateset("default", "rect", "circle", "poly")]
        [String]$shape,

        [Parameter(Mandatory = $false, Position = 4)]
        [ValidateSet("_blank", "_self", "_parent", "top")]
        [String]$target,

        [Parameter(Position = 5)]
        [String]$type,

        [Parameter(Position = 6)]
        [String]$Class,

        [Parameter(Position = 7)]
        [String]$Id,

        [Parameter(Position = 8)]
        [String]$Style,

        [Parameter(Position = 9)]
        [Hashtable]$Attributes


    )
    Process {

        $tagname = "area"

        if(!($Target)){
          
            $PSBoundParameters.Target = "_Blank"
        }

        Set-htmltag -TagName $tagName -Parameters $PSBoundParameters -TagType void
    }#End process


}
