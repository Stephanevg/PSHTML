Function br
{
    <#
    .SYNOPSIS
    Create a br in an HTML document.

    .EXAMPLE

    br
    
    .Notes
    Author: Ravikanth Chaganti
    Current version 3.2
    History: 
        2018.11.11;@ChristopheKumor;Updated to version 3.2
        2018.10.29;rchaganti; Adding br element
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [Cmdletbinding()]
    param
    (

        [Parameter(Position = 1)]
        [String]$Class,

        [Parameter(Position = 2)]
        [String]$Id,

        [Parameter(Position = 3)]
        [String]$Style,

        [Parameter(Position = 4)]
        [Hashtable]$Attributes
    )

    $tagname = "br"
    Set-HtmlTag -TagName $tagname -TagType void -Cmdlet $PSCmdlet
}
