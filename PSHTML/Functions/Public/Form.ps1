Function Form {
    <#
    .SYNOPSIS
    Generates Form HTML tag.

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

    form "/action_Page.php" post _self

    Generates the following html element: (Not very usefull, we both agree on that)

    <from action="/action_Page.php" method="post" target="_self" >
    </form>

    .EXAMPLE
    The following Example show how to pass custom HTML tag and their values
    form "/action_Page.php" post _self -attributes @{"Woop"="Wap";"sap"="sop"}

    .NOTES
    Current version 0.8
    History:
    2018.10.30;@ChristopheKumor;Updated to version 3.0
        2018.04.08;Stephanevg; Fixed custom Attributes display bug. Updated help
        2018.04.01;Stephanevg;Fix disyplay bug.
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [CmdletBinding()]
    Param(

        [Parameter(Mandatory = $true, Position = 0)]
        [String]$action,

        [Parameter(Mandatory = $true, Position = 1)]
        [ValidateSet("get", "post")]
        [String]$method = "get",

        [Parameter(Mandatory = $true, Position = 2)]
        [ValidateSet("_blank", "_self", "_parent", "top")]
        [String]$target = "_self",

        [Parameter(Position = 3)]
        [String]$Class,

        [Parameter(Position = 4)]
        [String]$Id,

        [Parameter(Position = 5)]
        [String]$Style,

        [Parameter(Position = 6)]
        [Hashtable]$Attributes,

        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $false,
            Position = 7
        )]
        [scriptblock]
        $Content
    )

    Process {
        $tagname = "form"
        Set-HtmlTag -TagName $tagname -PSBParameters $PSBoundParameters -MyCParametersKeys $MyInvocation.MyCommand.Parameters.Keys -TagType nonVoid
    }
}

