Function section {
    <#
    .SYNOPSIS
    Generates section HTML tag.
    
    .EXAMPLE
    
    section -Attributes @{"class"="MyClass";"id"="myid"} -Content {
        h1 "This is a h1"
        P{
            "This paragraph is part of a section with id 'myid'"
        }
    }
    
    Generates the following code:

    <section class="MyClass" id="myid" >
        <h1>This is a h1</h1>
        <p>
            This paragraph is part of a section with id 'myid'
        </p>
    </section>
    
    .EXAMPLE
    
    section -Class "myclass" -Style "section {border:1px dotted black;}" -Content {
        h1 "This is a h1"
        P{
            "This paragraph is part of section with id 'myid'"
        }
    }

    Generates the following code:

    <section Class="myclass" Style="section {border:1px dotted black;}" >
    <h1>This is a h1</h1>
        <p>
        This paragraph is part of section with id 'myid'
        </p>
    </section>

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
            "InsectionationAction",
            "InsectionationVariable",
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
            "<section $attr>" 
        }else{
            "<section>"
        }

        if($Content){
            $Content.Invoke()
        }
            

        '</section>'
    }
    
    
}
