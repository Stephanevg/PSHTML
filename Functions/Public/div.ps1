Function Get-Div {
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
        "<div>"
       

        if($ChildItem){
            $ChildItem.Invoke()
        }
            

        '</div>'
    }
    
    
}