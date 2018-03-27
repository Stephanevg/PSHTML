Function Head {
    Param(
        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $true,
            Position = 0
        )]
        [scriptblock]
        $ChildItem
    )
    "<head>"
    if($ChildItem){

        $ChildItem.Invoke()
    }
    "</head>"
    
    
}