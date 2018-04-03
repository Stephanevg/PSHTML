Function input {
    <#
    .SYNOPSIS
    Generates input HTML tag.
    
    .EXAMPLE
    
   
    
    .EXAMPLE
    
    #>
    [CmdletBinding()]
    Param(

        #Need to add the other ones from --> https://www.w3schools.com/tags/tag_input.asp
        [Parameter(Mandatory=$true,Position = 0)]
        [ValidateSet("button","checkbox","submit","email","radio","password","text")]
        [String]$type,

        [Parameter(Mandatory=$true,Position = 1)]
        [String]$name,

        [Parameter(Mandatory=$false,Position = 2)]
        [switch]$required,

        [Parameter(Position = 3)]
        [String]$Class,

        [Parameter(Position = 4)]
        [String]$Id,

        [Parameter(Position = 5)]
        [String]$Style,

        [Parameter(Position = 6)]
        [Hashtable]$Attributes,

        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $false,
            Position = 7
        )]
        [scriptblock]
        $Content
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
            "WarningVariable"
        )

        foreach ($cp in $CommonParameters){

            $null = $boundParams.Remove($cp)
        }

        foreach ($entry in $boundParams.Keys){

            $attr += "$($entry)=`"$($boundParams[$entry])`" "

        }

        

        if($attr){
            "<input $attr>" 
        }else{
            throw "No attributes were defined for <input> element"
        }

        
    }#End process
    
    
}
