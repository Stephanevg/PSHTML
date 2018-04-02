Function article {
    <#
    .SYNOPSIS
    Generates article HTML tag.
    
    .EXAMPLE
    
    article {
        h1 "This is blog post number 1"
        p {
            "This is content of blog post 1"
        }
    }

    Generates the following code:

    <article>
        <h1>This is blog post number 1</h1>
        <p>
            This is content of blog post 1
        </p>
    </article>
    
    .EXAMPLE
    
    It is also possible to use regular powershell logic inside a scriptblock. The example below, generates a article element
    based on values located in a powershell object. The content is generated dynamically through the usage of a foreach loop.

    $objs = @()
    $objs += new-object psobject -property @{"title"="this is title 2";content="this is the content of article 2"}
    $objs += new-object psobject -property @{"title"="this is title 3";content="this is the content of article 3"}
    $objs += new-object psobject -property @{"title"="this is title 4";content="this is the content of article 4"}
    $objs += new-object psobject -property @{"title"="this is title 5";content="this is the content of article 5"}
    $objs += new-object psobject -property @{"title"="this is title 6";content="this is the content of article 6"}

    body {

        foreach ($article in $objs){
            article {
                h2 $article.title
                p{
                    $article.content
                }
            }
        }
    }

    Generates the following code:

        <body>
            <article>
                <h2>this is title 2</h2>
                <p>
                this is the content of article 2
                </p>
            </article>
            <article>
                <h2>this is title 3</h2>
                <p>
                this is the content of article 3
                </p>
            </article>
            <article>
                <h2>this is title 4</h2>
                <p>
                this is the content of article 4
                </p>
            </article>
            <article>
                <h2>this is title 5</h2>
                <p>
                this is the content of article 5
                </p>
            </article>
            <article>
                <h2>this is title 6</h2>
                <p>
                this is the content of article 6
                </p>
            </article>
        </body>

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
            "InarticleationAction",
            "InarticleationVariable",
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
            "<article $attr>" 
        }else{
            "<article>"
        }

        if($Content){
            $Content.Invoke()
        }
            

        '</article>'
    }
    
    
}
