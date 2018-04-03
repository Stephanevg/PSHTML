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

        [Hashtable]$Attributes
    )

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
            "WarningVariable"
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

        $boundParams.Remove("childitem")

        if($reversed){
            $attr += "reversed=`"true`" "
        }

        if($Attributes){
            Foreach($key in $Attributes.Keys){

                $attr += "$($key)=$($Attributes[$key]) "
     
            }
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