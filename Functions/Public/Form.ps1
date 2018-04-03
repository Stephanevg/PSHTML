Function Form {
    <#
    .SYNOPSIS
    Generates Form HTML tag.
    
    .EXAMPLE
    
    form "/action_Page.php" post _self
    
    Generates the following html element: (Not very usefull, we both agree on that)

    <from action="/action_Page.php" method="post" target="_self" >
    </form>
    
    .EXAMPLE
    
    #>
    [CmdletBinding()]
    Param(

        [Parameter(Mandatory=$true,Position = 0)]
        [String]$action,

        [Parameter(Mandatory=$true,Position = 1)]
        [ValidateSet("get","post")]
        [String]$method = "get",

        [Parameter(Mandatory=$true,Position = 2)]
        [ValidateSet("_blank","_self","_parent","top")]
        [String]$target = "_self",

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
            if ($entry -eq 'content'){
                continue
            }
            $attr += "$($entry)=`"$($boundParams[$entry])`" "

        }

        

        if($attr){
            "<form $attr>" 
        }else{
            "<form>"
        }

        if($Content){
            $Content.Invoke()
        }
            

        '</form>'
    }
    
    
}

form "/action_Page.php" post _self -ErrorAction Ignore -Verbose -Debug -WarningAction Ignore -InformationAction SilentlyContinue -WarningVariable wv 