Function Html {
    Param(
        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $true,
            Position = 0
        )]
        [scriptblock]
        $ChildItem
    )
    
        
    "<html>"
       
        $ChildItem.Invoke()
    
    "</html>"

}