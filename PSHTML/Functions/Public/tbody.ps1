Function Tbody {
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
        $ChildItem
    )
    Process{
        "<tbody>"


        if($ChildItem){
            $ChildItem.Invoke()
        }


        '</tbody>'
    }


}