Function Get-Footer {
    Param(
        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $true,
            Position = 0
        )]
        [scriptblock]
        $ChildItem
    )
    "<footer>"
    if($ChildItem){

        $ChildItem.Invoke()
    }
    "</footer>"
    
    
}