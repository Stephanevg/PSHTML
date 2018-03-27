Function ol {
    Param(

        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $false
        )]
        [scriptblock]
        $ChildItem,

        [switch]
        $reversed,

        [string]
        $start,

        [string]
        $type,

        [Hashtable]$CustomAttributes
    )

    $attr = ""
        foreach ($entry in $PSBoundParameters.Keys){
            switch($entry){
                "start" {$attr += "start=$start ";Break}
                "type" {$attr += "type=`"$type`" ";Break}
                "CustomAttributes" {

                    Foreach($key in $CustomAttributes.Keys){

                        $attr += "$($key)=$($CustomAttributes[$key]) "
             
                    }

                }
                default{}
            }
        }

        if($reversed){
            $attr += "reversed=`"true`" "
        }
        
        if($attr){
            "<ol $attr>" 
        }else{
            "<ol>"
        }
       

        if($ChildItem){
            $ChildItem.Invoke()
        }
            

        '</ol>'
    }