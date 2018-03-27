Function Div {
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
        $Attributes = ""
        foreach ($entry in $PSBoundParameters.Keys){
            switch($entry){
                "Class" {$Attributes = $Attributes + "class=$class ";Break}
                "id" {$Attributes = $Attributes + "Id=$Id ";Break}
                "style" {$Attributes = $Attributes + "style=`"$Style`" ";Break}
                default{}
            }
        }

        if($Attributes){
            "<div $Attributes>" 
        }else{
            "<div>"
        }

        if($ChildItem){
            $ChildItem.Invoke()
        }
            

        '</div>'
    }
    
    
}