Function P {
    
    Param(

        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $false,
            Position = 0
        )]
        [scriptblock]
        $ChildItem,

        [String]$Class,

        [String]$Id,

        [String]$Style,

        [String]$Title
    )
    Process{

        $Attributes = ""
        foreach ($entry in $PSBoundParameters.Keys){
            switch($entry){
                "Class" {$Attributes = $Attributes + "Class=$class ";Break}
                "id" {$Attributes = $Attributes + "Id=$Id ";Break}
                "style" {$Attributes = $Attributes + "style=`"$Style`" ";Break}
                "Title" {$Attributes = $Attributes + "title=`"$Title`" ";Break}
                default{}
            }
        }

        if($Attributes){
            "<p $Attributes>" 
        }else{
            "<p>"
        }

        if($ChildItem){
            $ChildItem.Invoke()
        }
            

        '</p>'
    }
    
    
}