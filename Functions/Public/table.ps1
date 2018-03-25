Function Get-Table {
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