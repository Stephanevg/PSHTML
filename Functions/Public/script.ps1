Function script {
    <#
    .SYNOPSIS
    Generates script HTML tag.
    
    .EXAMPLE
    script -type text/javascript -src "myscript.js"
    
    Generates the following code:

    <script type="text/javascript" src="myscript.js"></script>
    
    .EXAMPLE
    script -type text/javascript  -content "alert( 'Hello, world!' );"

    Generates the following code:

    <script type="text/javascript">alert( 'Hello, world!' );</script>

    #>
    [CmdletBinding()]
    Param(

        
        [Parameter(Position =0)]
        [String]$src,
        
        [Parameter(Mandatory=$false,Position = 1)]
        [ValidateSet("text/javascript")]
        [String]$type,

        [Parameter(Position =2)]
        [String]$Class,

        [Parameter(Position = 3)]
        [String]$Id,

        [Parameter(Position =4)]
        [String]$Style,

        [Parameter(Position = 5)]
        [Hashtable]$Attributes,

        [Parameter(Position = 6)]
        [string]$content

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

        "<script {0}>{1}</script>"  -f $attr,$content 
        

        
    }#End process
    
    
}
