Function Div {
    <#
        .SYNOPSIS
        Generates a DIV HTML tag.

        .EXAMPLE
        The following exapmles show cases how to create an empty div, with a class, an ID, and, custom attributes.
        div -Class "myclass1 MyClass2" -Id myid -Attributes @{"custom1"='val1';custom2='val2'}

        Generates the following code:

        <div Class="myclass1 MyClass2" Id="myid" custom1="val1" custom2="val2"  >
        </div>


        .NOTES
        Current version 2.0
        History:
        2018.10.30;@ChristopheKumor;Updated to version 3.0
            2018.10.02;bateskevin; Updated to v2.0
            2018.04.10;Stephanevg; Added parameters
            2018.04.01;Stephanevg;Creation.
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

        $tagname = "div"

        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid
    }


}