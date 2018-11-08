Function Th {
    <#
    .LINK
    https://github.com/Stephanevg/PSHTML
#>
    Param(
        $Content
    )

    Process {

        $tagname = "th"

        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid
    }

}