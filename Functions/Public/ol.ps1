Function ol {

    <#
    .SYNOPSIS
    Generates ol HTML tag.
    
    .EXAMPLE
    
    ol -reversed -start 1 -type "typo" -Attributes @{Name="Kevin" ; whatever="floats your boat"} -content {
        li -content "Test entry" -Class "classy" -value 0 -Style "stylish" -Attributes @{Name="Johnny" ; bibop="bopib"}
        li "Test entry 2"
    }

    Generates the following code:

    <ol reversed="True" start="1" type="typo" reversed="true" Name="Kevin" whatever="floats your boat">
        <li Class="classy" value="0" Style="stylish" bibop="bopib" Name="Johnny">
            Test entry
        </li>
        <li>
            Test entry 2
        </li>
    </ol>
    
    .EXAMPLE
    
    It is also possible to use regular powershell logic inside a scriptblock. The example below, generates multiple ol elements. 
    Where every ol has an li tag in it showing service whch name starts with "s".

    $Services = Get-Service | ?{$_.name.Startswith("s")}

    

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