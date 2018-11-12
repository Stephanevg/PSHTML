Function Table {
    <#
    .LINK
    https://github.com/Stephanevg/PSHTML

    .NOTES
    Current version 3.2
        History: 
            2018.11.11;@ChristopheKumor;Updated to version 3.2
#>
    Param(

        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $false,
            Position = 0
        )]
        $Content
    )

    Process {

        $tagname = "Table"

        Set-HtmlTag -TagName $tagname -TagType NonVoid -Cmdlet $PSCmdlet
    }
}



