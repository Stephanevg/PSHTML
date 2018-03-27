Function Tfoot {
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
        "<tfoot>"
       

        if($ChildItem){
            $ChildItem.Invoke()
        }
            

        '</tfoot>'
    }
    
    
}