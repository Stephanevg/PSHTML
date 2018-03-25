Function Get-Tr {
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
        "<tr>"
       

        if($ChildItem){
            $ChildItem.Invoke()
        }
            

        '</tr>'
    }
    
    
}