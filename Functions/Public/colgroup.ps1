Function Colgroup {
    <#
    The <colgroup> tag is useful for applying styles to entire columns, instead of repeating the styles for each cell, for each row.
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
        "<colgroup>"
       

        if($ChildItem){
            $ChildItem.Invoke()
        }
            

        '</colgroup>'
    }
    
    
}