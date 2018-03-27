Function Header {
    Param(
        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $true,
            Position = 0
        )]
        [scriptblock]
        $ChildItem
    )
    "<header>"
    if($ChildItem){

        $ChildItem.Invoke()
    }
    "</header>"
    
    
}