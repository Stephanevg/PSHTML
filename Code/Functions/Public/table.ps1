Function Table {
    <#
    .SYNOPSIS
    Allows to create an table HTML element (<table> </table>)

    .Description
    The Table html element defined the contents of a table.

    .EXAMPLE

    Table {

    }

    .LINK
    https://github.com/Stephanevg/PSHTML

    .NOTES
    Version 1.0.0

#>
    Param(

        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $false,
            Position = 0
        )]
        $Content,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class = "",
    
        [String]$Id,
    
        [AllowEmptyString()]
        [AllowNull()]
        [String]$Style,

        [Hashtable]$Attributes
    )

    Process {

        $tagname = "Table"

        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid
    }
}



