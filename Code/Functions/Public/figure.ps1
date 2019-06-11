Function figure {
    <#
        .SYNOPSIS
        Generates a figure HTML tag.

        .EXAMPLE
        The following exapmles show cases how to create an empty figure, with a class, an ID, and, custom attributes.
        figure -Class "myclass1 MyClass2" -Id myid -Attributes @{"custom1"='val1';custom2='val2'}

        Generates the following code:

        <figure Class="myclass1 MyClass2" Id="myid" custom1="val1" custom2="val2"  >
        </figure>


        .NOTES
        Current version 3.1
        History:
        2018.10.30;@ChristopheKumor;Updated to version 3.0
           2018.10.02;bateskevin;Updated to v2.
           2018.04.01;bateskevin;Creation.
        .LINK
            https://github.com/Stephanevg/PSHTML
    #>

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

        $tagname = "figure"

        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid
        
    }
}