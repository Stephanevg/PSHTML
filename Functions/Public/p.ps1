Function Get-P {
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
        "<p>"
       

        if($ChildItem){
            $ChildItem.Invoke()
        }
            

        '</p>'
    }
    
    
}