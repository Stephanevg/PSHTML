Function Thead {
    <#
    .SYNOPSIS
    Allows to create an Thead HTML element (<Thead> </Thead>)
    .Description
    Thead should be used inside a 'table' block.

    .Example

    Thead {
        
    }

    .LINK
    https://github.com/Stephanevg/PSHTML
    .NOTES
        Version 3.1.0
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

        $tagname = "thead"
    
        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid
    }

}