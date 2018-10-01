Function article {
    <#
    .SYNOPSIS
    Generates article HTML tag.

    .PARAMETER Class
    Allows to specify one (or more) class(es) to assign the html element.
    More then one class can be assigned by seperating them with a white space.

    .PARAMETER Id
    Allows to specify an id to assign the html element.

    .PARAMETER Style
    Allows to specify in line CSS style to assign the html element.

    .PARAMETER Content
    Allows to add child element(s) inside the current opening and closing HTML tag(s).


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

    .NOTES
     Current version 1.0
        History:
            2018.04.10;Stephanevg; Added parameters
            2018.04.01;Stephanevg;Creation.
    .LINK
        https://github.com/Stephanevg/PSHTML
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
        $CommonParameters = ("Attributes", "content") + [System.Management.Automation.PSCmdlet]::CommonParameters + [System.Management.Automation.PSCmdlet]::OptionalCommonParameters
        $CustomParameters = $PSBoundParameters.Keys | Where-Object -FilterScript { $_ -notin $CommonParameters }

        if($CustomParameters){

            foreach ($entry in $CustomParameters){


                $Attr += "{0}=`"{1}`" " -f $entry,$PSBoundParameters[$entry]

            }

        }

        if($Attributes){
            foreach($entry in $Attributes.Keys){

                $attr += "{0}=`"{1}`" " -f $entry,$Attributes[$Entry]
            }
        }

        if($attr){
            "<article {0} >"  -f $attr
        }else{
            "<article>"
        }



        if($Content){
            $Content.Invoke()
        }


        '</article>'
    }


}
