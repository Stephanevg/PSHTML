Function li {

    [CmdletBinding()]
    Param(
        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $true,
            Position = 0
        )]
        $content,

        [Parameter(Position = 1)]
        [String]$Class,

        [Parameter(Position = 2)]
        [String]$value,

        [Parameter(Position = 3)]
        [String]$Style,

        [Hashtable]$CustomAttributes
    )
    Process{

        

        $attr = ""
        foreach ($entry in $PSBoundParameters.Keys){
            switch($entry){
                "Class" {$attr += "Class=$class ";Break}
                "value" {$attr += "value=$value ";Break}
                "style" {$attr += "style=`"$Style`" ";Break}
                "CustomAttributes" {

                    Foreach($key in $CustomAttributes.Keys){

                        $attr += "$($key)=$($CustomAttributes[$key]) "
             
                    }

                }
                default{}
            }
        }

        $counter = 0
        
        if($content.GetType().name -eq "Object[]"){

            foreach($item in $content){

                if($attr){
                    "<li $attr>" 
                }else{
                    "<li>"
                }
    
                if($content){
                    $content[$counter]
                }
                    
                $counter ++
    
                '</li>'
            }     

        }else{

            if($attr){
                "<li $attr>" 
            }else{
                "<li>"
            }

            if($content){
                $content
            }
                
            $counter ++

            '</li>'

        }

        
    }
    
    
}

