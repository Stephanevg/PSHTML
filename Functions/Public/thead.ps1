Function Get-Thead {
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
        "<thead>"
       

        if($ChildItem){
            $ChildItem.Invoke()
        }
            

        '</thead>'
    }
    
    
}