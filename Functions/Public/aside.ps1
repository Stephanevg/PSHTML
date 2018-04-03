Function aside {
    <#
    .SYNOPSIS
    Generates aside HTML tag.
    
    .EXAMPLE

    aside {
        h4 "This is an aside"
        p{
            "This is a paragraph inside the aside block"
        }
    }

    Generates the following code:

    <aside>
        <h4>This is an aside</h4>
        <p>
            This is a paragraph inside the aside block
        </p>
    </aside>
        
    #>
    [CmdletBinding()]
    Param(

        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $false,
            Position = 0
        )]
        [scriptblock]
        $Content,

        [Parameter(Position = 1)]
        [String]$Class,

        [Parameter(Position = 2)]
        [String]$Id,

        [Parameter(Position = 3)]
        [String]$Style,

        [Parameter(Position = 4)]
        [Hashtable]$Attributes 
    )
    Process{

        $attr = ""
        $boundParams = $PSBoundParameters
        $CommonParameters = @(
            "Debug",
            "ErrorAction",
            "ErrorVariable",
            "InasideationAction",
            "InasideationVariable",
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
            if ($entry -eq 'content' -or $entry -eq 'attributes'){
                continue
            }
            $attr += "$($entry)=`"$($boundParams[$entry])`" "

        }

        if ($Attributes){
            foreach ($entry in $Attributes.Keys){

                $attr += "$($entry)=`"$($Attributes[$entry])`" "
    
            }
        }

        

        if($attr){
            "<aside $attr>" 
        }else{
            "<aside>"
        }

        if($Content){
            $Content.Invoke()
        }
            

        '</aside>'
    }
    
    
}
