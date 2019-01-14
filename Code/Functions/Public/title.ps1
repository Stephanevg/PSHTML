Function Title {
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

        $tagname = "title"
    
        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid
    }

}
