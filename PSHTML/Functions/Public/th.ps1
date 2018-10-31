Function Th {
    <#
    .LINK
    https://github.com/Stephanevg/PSHTML
#>
    Param(
        [String]
        $Content
    )

    Process {

        $tagname = "th"

        Set-HtmlTag -TagName $tagname -PSBParameters $PSBoundParameters -MyCParametersKeys $MyInvocation.MyCommand.Parameters.Keys -TagType nonVoid
    }

}