Function Title {
    <#
    .LINK
    https://github.com/Stephanevg/PSHTML
#>
    Param(
        [String]
        $Content
    )

    Process {

        $tagname = "title"
    
        Set-HtmlTag -TagName $tagname -PSBParameters $PSBoundParameters -MyCParametersKeys $MyInvocation.MyCommand.Parameters.Keys -TagType nonVoid
    }

}
