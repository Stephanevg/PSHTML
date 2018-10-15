Function map {
    <#
    .SYNOPSIS
    Generates map HTML tag.

    .DESCRIPTION
    The map must be used in conjunction with area. Pass an 'area' parameter with its arguments in the 'Content' parameter

    .EXAMPLE

    map -Content {area -href "map.png" -coords "0,0,50,50" -shape circle -target top }

    Generates the following code

    <map>
        <area href="map.png" coords="0,0,50,50" shape="circle" target="top" >
    </map>

    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [CmdletBinding()]
    Param(

        [Parameter(Position = 1)]
        [String]$Class,

        [Parameter(Position = 2)]
        [String]$Id,

        [Parameter(Position = 3)]
        [String]$Style,

        [Parameter(Position = 4)]
        [Hashtable]$Attributes,

        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $false,
            Position = 5
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
            "InmapationAction",
            "InmapationVariable",
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



        if($attr){
            "<map $attr>"
        }else{
            "<map>"
        }

        if($Content){
            $Content.Invoke()
        }


        '</map>'
    }


}