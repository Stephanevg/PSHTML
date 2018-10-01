Function Table {
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
        "<table>"


        if($ChildItem){
            $ChildItem.Invoke()
        }


        '</Table>'
    }


}