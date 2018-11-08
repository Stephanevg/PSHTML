Function Th {
    <#
    .LINK
    https://github.com/Stephanevg/PSHTML
    .NOTES
        Version 3.1.0
#>
    Param(
        $Content
    )

    Process {

        $tagname = "th"

        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid
    }

}