Function Noscript {
    <#
    .SYNOPSIS
    Generates Noscript HTML tag.

    .EXAMPLE
    Noscript "Your browser doesn`'t support javascript"

    Generates the following code:

    <noscript >Your browser doesn't support javascript</noscript>

    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [CmdletBinding()]
    Param(


        [Parameter(Position = 1)]
        [string]$content,

        [Parameter(Position =2)]
        [String]$Class,

        [Parameter(Position = 3)]
        [String]$Id,

        [Parameter(Position =4)]
        [String]$Style,

        [Parameter(Position = 5)]
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

        "<noscript {0}>{1}</noscript>"  -f $attr,$content



    }#End process


}
