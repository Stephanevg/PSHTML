Function ol {

    <#
    .SYNOPSIS
    Generates ol HTML tag.
    
    .EXAMPLE
    
    ol {
        
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

    Param(

        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $false
        )]
        [scriptblock]
        $content,

        [switch]
        $reversed,

        [string]
        $start,

        [string]    
        $type,

        [Hashtable]$Attributes
    )

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
            "WarningVariable",
            "Attributes"
        )

        foreach ($cp in $CommonParameters){

            $null = $boundParams.Remove($cp)
        }

        foreach ($entry in $boundParams.Keys){
            if ($entry -eq 'content'){
                continue
            }
            $attr += '{0}="{1}" ' -f $entry,$boundParams[$entry]

        }

        $boundParams.Remove("childitem")

        if($reversed){
            $attr += "reversed=`"true`" "
        }

        if($Attributes){
            Foreach($key in $Attributes.Keys){

                $attr += '{0}="{1}" ' -f $key,$Attributes[$key] 
     
            }
        }
        
        if($attr){
            "<ol $attr>" 
        }else{
            "<ol>"
        }
       

        if($content){
            $content.Invoke()
        }
            

        '</ol>'
    }