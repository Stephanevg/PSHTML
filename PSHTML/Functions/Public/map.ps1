Function map {
    <#
    .SYNOPSIS
    Generates map HTML tag.

    .DESCRIPTION
    The map must be used in conjunction with area. Pass an 'area' parameter with its arguments in the 'Content' parameter

    .EXAMPLE

    map -Content {area -href "map.png" -coords "0,0,50,50" -shape circle -target top }

    Generates the following code

    <map>
        <area href="map.png" coords="0,0,50,50" shape="circle" target="top" >
    </map>

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
        [String]$Class,

        [Parameter(Position = 2)]
        [String]$Id,

        [Parameter(Position = 3)]
        [String]$Style,

        [Parameter(Position = 4)]
        [Hashtable]$Attributes,

        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $false,
            Position = 5
        )]
        [scriptblock]
        $Content
    )

    Process {
        $tagname = "map"
        Set-HtmlTag -TagName $tagname -TagType NonVoid -Cmdlet $PSCmdlet
    }
}