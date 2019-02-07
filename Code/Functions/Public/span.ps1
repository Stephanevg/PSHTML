Function span {
    <#
    .SYNOPSIS
    Create a span tag in an HTML document.

    .EXAMPLE

    span
    .EXAMPLE
    span "woop1" -Class "class"

    .EXAMPLE
    span "woop2" -Class "class" -Id "Something"

    .EXAMPLE
    span "woop3" -Class "class" -Id "something" -Style "color:red;"

    .NOTES
    Current version 3.1
       History:
       
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [Cmdletbinding()]
    Param(
        [Parameter(Mandatory = $false)]
        [AllowEmptyString()]
        [AllowNull()]
        [String]
        $Content,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class = "",

        [String]$Id,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Style,

        [String]$value,

        [HashTable]$Attributes


    )

    Process {

        $tagname = "span"

        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid
        
    }
}