Function area {
    <#
    .SYNOPSIS
    Generates area HTML tag.

    .DESCRIPTION
    The are tag must be used in a <map> element (Use the 'map' function)
    
    .EXAMPLE
    area -href "link.php" -alt "alternate description" -coords "0,0,10,10"
    
   Generates the following code: 

    <area href="link.php" alt="alternate description" coords="0,0,10,10" >
    
    .EXAMPLE
    area -href image.png -coords "0,0,20,20" -shape rect

    Generates the following code: 

    <area href="image.png"coords="0,0,20,20"shape="rect" >


    #>
    [CmdletBinding()]
    Param(

        
        [Parameter(Position =0)]
        [String]$href,

        [Parameter(Position =1)]
        [String]$alt,

        [Parameter(Position =2)]
        [String]$coords,

        [Parameter(Position =3)]
        [validateset("default","rect","circle","poly")]
        [String]$shape,

        [Parameter(Mandatory=$false,Position = 4)]
        [ValidateSet("_blank","_self","_parent","top")]
        [String]$target = "_Blank",

        [Parameter(Position =5)]
        [String]$type,

        [Parameter(Position =6)]
        [String]$Class,

        [Parameter(Position = 7)]
        [String]$Id,

        [Parameter(Position =8)]
        [String]$Style,

        [Parameter(Position = 9)]
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
            "WarningVariable"
        )

        foreach ($cp in $CommonParameters){

            $null = $boundParams.Remove($cp)
        }

        foreach ($entry in $boundParams.Keys){
            if($entry -eq "content"){
                continue
            }
            #$attr += "$($entry)=`"$($boundParams[$entry])`" "
            $attr += "{0}=`"{1}`" " -f $entry,$boundParams[$entry]

        }

        "<area {0} >"  -f $attr
        

        
    }#End process
    
    
}
