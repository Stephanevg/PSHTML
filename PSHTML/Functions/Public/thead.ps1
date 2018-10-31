Function Thead {
    <#
    .LINK
    https://github.com/Stephanevg/PSHTML
#>
    Param(

        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $false,
            Position = 0
        )]
        [scriptblock]
        $Content
    )

    Process {

        $tagname = "thead"
    
        Set-HtmlTag -TagName $tagname -PSBParameters $PSBoundParameters -MyCParametersKeys $MyInvocation.MyCommand.Parameters.Keys -TagType nonVoid
    }

}