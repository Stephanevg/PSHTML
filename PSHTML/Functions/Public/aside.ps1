Function aside {
    <#
    .SYNOPSIS
    Generates aside HTML tag.

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

    aside {
        h4 "This is an aside"
        p{
            "This is a paragraph inside the aside block"
        }
    }

    Generates the following code:

    <aside>
        <h4>This is an aside</h4>
        <p>
            This is a paragraph inside the aside block
        </p>
    </aside>

    .LINK
        https://github.com/Stephanevg/PSHTML
    
    .NOTES
        Current version 3.1
        History:
            2018.11.1; Stephanevg;Updated to version 3.1
    #>
    [CmdletBinding()]
    Param(

        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $false,
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
    Process {

        $tagname = "aside"

        Set-htmltag -TagName $tagName -Parameters $PSBoundParameters  -TagType NonVoid
    }


}
