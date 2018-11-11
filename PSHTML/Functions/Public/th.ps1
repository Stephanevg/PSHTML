Function Th {
    <#
    .LINK
    https://github.com/Stephanevg/PSHTML
    .NOTES
    Current version 3.2
        History:
            2018.11.11;@ChristopheKumor;Updated to version 3.2
#>
    Param(
        $Content
    )

    Process {

        $tagname = "th"

        Set-HtmlTag -TagName $tagname -TagType NonVoid -Cmdlet $PSCmdlet
    }

}