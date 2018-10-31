Function script {
    <#
    .SYNOPSIS
    Generates script HTML tag.

    .EXAMPLE
    script -type text/javascript -src "myscript.js"

    Generates the following code:

    <script type="text/javascript" src="myscript.js"></script>

    .EXAMPLE
    script -type text/javascript  -content "alert( 'Hello, world!' );"

    Generates the following code:

    <script type="text/javascript">alert( 'Hello, world!' );</script>
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [CmdletBinding()]
    Param(


        [Parameter(Position = 0)]
        [String]$src,

        [Parameter(Mandatory = $false, Position = 1)]
        [ValidateSet("text/javascript")]
        [String]$type,

        [Parameter(Position = 2)]
        [String]$integrity,

        [Parameter(Position = 3)]
        [String]$crossorigin,

        [Parameter(Position = 4)]
        [String]$Class,

        [Parameter(Position = 5)]
        [String]$Id,

        [Parameter(Position = 6)]
        [String]$Style,

        [Parameter(Position = 7)]
        [Hashtable]$Attributes,

        [Parameter(Position = 8)]
        [string]$content

    )
 
    Process {

        $tagname = "script"

        Set-HtmlTag -TagName $tagname -PSBParameters $PSBoundParameters -MyCParametersKeys $MyInvocation.MyCommand.Parameters.Keys -TagType nonVoid
    }
}
