Function nav {
    <#
    .SYNOPSIS
    Generates nav HTML tag.
    
    .EXAMPLE
    
    nav -Content {
        a -href "\home.html" -Target _blank
        a -href "\about.html" -Target _blank
        a -href "\blog.html" -Target _blank
        a -href "\contact.html" -Target _blank
    }

    Generates the following code:

    <nav>
        <a href=\home.html target="_blank" ></a>
        <a href=\about.html target="_blank" ></a>
        <a href=\blog.html target="_blank" ></a>
        <a href=\contact.html target="_blank" ></a>
    </nav>
    
    .EXAMPLE
    
    It is also possible to use regular powershell logic inside a scriptblock. The example below, generates a nav element
    based on values located in a array. The various links are build using a foreach loop.

    $Pages = "home.html","login.html","about.html"
    nav -Content {
        foreach($page in $pages){
            a -href "\$($page)" -Target _blank
        }
        
    } -Class "mainnavigation" -Style "border 1px"

    Generates the following code:

    <nav Class="mainnavigation" Style="border 1px" >
        <a href=\home.html target="_blank" >
        </a>
        <a href=\login.html target="_blank" >
        </a>
        <a href=\about.html target="_blank" >
        </a>
    </nav>

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
            "InnavationAction",
            "InnavationVariable",
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
            "<nav $attr>" 
        }else{
            "<nav>"
        }

        if($Content){
            $Content.Invoke()
        }
            

        '</nav>'
    }
    
    
}


