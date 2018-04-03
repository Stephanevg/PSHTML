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

        [Hashtable]$Attributes
    )
    Process{

        

        $attr = ""
        $boundParams = $PSBoundParameters
        $CommonParameters = @(
            "Debug",
            "ErrorAction",
            "ErrorVariable",
            "InformationAction",
            "InformationVariable",
            "OutVariable",
            "OutBuffer",
            "PipelineVariable",
            "Verbose",
            "WarningAction",
            "WarningVariable",
            "Attributes"
        )

        foreach ($cp in $CommonParameters){

            $null = $boundParams.Remove($cp)
        }

        foreach ($entry in $boundParams.Keys){
            if ($entry -eq 'content'){
                continue
            }
            $attr += "$($entry)=`"$($boundParams[$entry])`" "

        }

        if($Attributes){

            Foreach($key in $Attributes.Keys){

                $attr += '{0}="{1}" ' -f $key,$Attributes[$key]
     
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

