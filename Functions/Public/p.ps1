Function p {
    <#
    .SYNOPSIS
    Create a p tag in an HTML document.

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

    p
    .EXAMPLE
    p "woop1" -Class "class"

    .EXAMPLE
    p "woop2" -Class "class" -Id "Something"

    .EXAMPLE
    p "woop3" -Class "class" -Id "something" -Style "color:red;"

    .EXAMPLE
    p {
        $Important = strong{"This is REALLY important"}
        "This is regular test in a paragraph " + $Important
    }

    Generates the following code

    <p>
    This is regular test in a paragraph <strong>"This is REALLY important"</strong>
    </p>

    .NOTES
    Current version 1.1.0
       History:
           2018.04.10;Stephanevg;Updated content (removed string, added if for selection between scriptblock and string).
           2018.04.01;bateskevinhanevg;Creation.
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [Cmdletbinding()]
    Param(
        [Parameter(Mandatory=$false)]
        [AllowEmptyString()]
        [AllowNull()]
        $Content,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class,

        [String]$Id,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Style,

        [String]$title,

        [Hashtable]$Attributes
    )

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
            "<p {0} >"  -f $attr
        }else{
            "<p>"
        }



        if($Content){

            if($Content -is [System.Management.Automation.ScriptBlock]){
                $Content.Invoke()
            }else{
                $Content
            }
        }

    "</p>"

}