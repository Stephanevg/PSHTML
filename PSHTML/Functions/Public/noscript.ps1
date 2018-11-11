Function Noscript {
    <#
    .SYNOPSIS
    Generates Noscript HTML tag.

    .EXAMPLE
    Noscript "Your browser doesn`'t support javascript"

    Generates the following code:

    <noscript >Your browser doesn't support javascript</noscript>

    .NOTES
        Current version 3.2
    History: 
        2018.11.11;@ChristopheKumor;Updated to version 3.2
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [CmdletBinding()]
    Param(


        [Parameter(Position = 1)]
        $content,

        [Parameter(Position = 2)]
        [String]$Class,

        [Parameter(Position = 3)]
        [String]$Id,

        [Parameter(Position = 4)]
        [String]$Style,

        [Parameter(Position = 5)]
        [Hashtable]$Attributes


    )

    Process {

        $tagname = "noscript"

        Set-HtmlTag -TagName $tagname -TagType NonVoid -Cmdlet $PSCmdlet
    }

}
