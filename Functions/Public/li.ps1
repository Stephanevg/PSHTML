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
        [String]$Id,

        [Parameter(Position = 3)]
        [String]$Style,

        [Parameter(Position = 4)]
        [String]$Title,

        [Hashtable]$CustomAttributes
    )
    Process{

        

        $attr = ""
        foreach ($entry in $PSBoundParameters.Keys){
            switch($entry){
                "Class" {$attr += "Class=$class ";Break}
                "id" {$attr += "Id=$Id ";Break}
                "style" {$attr += "style=`"$Style`" ";Break}
                "Title" {$attr += "title=`"$Title`" ";Break}
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

