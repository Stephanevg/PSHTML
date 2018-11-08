Function dd {
    <#
    .SYNOPSIS
    Create a dd tag in an HTML document.

    .EXAMPLE

    dd
    .EXAMPLE
    dd "woop1" -Class "class"

    .EXAMPLE
    dd "woop2" -Class "class" -Id "Something"

    .EXAMPLE
    dd "woop3" -Class "class" -Id "something" -Style "color:red;"

    .NOTES
    Current version 3.1
       History:
       2018.10.30;@ChristopheKumor;Updated to version 3.0
           2018.10.02;bateskevin;Updated to v2.
           2018.04.01;bateskevin;Creation.
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [Cmdletbinding()]
    Param(
        [Parameter(Mandatory = $true)]
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

        $tagname = "dd"

        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid
        
    }
}