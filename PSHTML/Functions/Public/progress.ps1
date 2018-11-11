Function progress {
    <#
    .SYNOPSIS
    Create a progress tag in an HTML document.

    .DESCRIPTION

    Tip: Use the <progress> tag in conjunction with JavaScript to display the progress of a task.

    Note: The <progress> tag is not suitable for representing a gauge (e.g. disk space usage or relevance of a query result). To represent a gauge, use the <meter> tag instead.

    .EXAMPLE
    

    .EXAMPLE

    .NOTES
    Current version 3.1.0
       History:
        2018.10.30;@ChristopheKumor;Updated to version 3.0
            2018.10.10;bateskevinhanevg;Creation.
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [Cmdletbinding()]
    Param(
        [Parameter(Mandatory = $false)]
        [AllowEmptyString()]
        [AllowNull()]
        $Content,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Max = "",

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Value = "",

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class = "",

        [String]$Id,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Style,

        [String]$title,

        [Hashtable]$Attributes
    )

    Process {
        $tagname = "progress"

        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid
    }
}
