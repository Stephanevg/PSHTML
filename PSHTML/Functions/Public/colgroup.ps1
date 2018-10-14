Function Colgroup {
    <#

    .SYNOPSIS
    Generates colgroup HTML tag.

    .DESCRIPTION
    The <colgroup> tag is useful for applying styles to entire columns, instead of repeating the styles for each cell, for each row.


    .PARAMETER Class
    Allows to specify one (or more) class(es) to assign the html element.
    More then one class can be assigned by seperating them with a white space.

    .PARAMETER Id
    Allows to specify an id to assign the html element.

    .PARAMETER Style
    Allows to specify in line CSS style to assign the html element.


    .EXAMPLE

    Colgroup {
        col -span 2
    }

    <colgroup>
        <col span="2"  >
    </colgroup>

    .EXAMPLE

    Colgroup {
        col -span 3 -Style "Background-color:red"
        col -Style "Backgroung-color:yellow"
    }

    Generates the following code
   <colgroup>
        <col span="3" Style="Background-color:red"  >
        <col Style="Backgroung-color:yellow"  >
    </colgroup>

    .NOTES
    Current version 1.0
    History:
        2018.04.08;Stephanevg; Updated to version 1.0
        2018.04.01;Stephanevg;Fix disyplay bug.
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    Param(

        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $false,
            Position = 0
        )]
        [scriptblock]
        $Content,

        [Parameter(Position = 1)]
        [int]
        $span,

        [Parameter(Position = 2)]
        [String]$Class,

        [Parameter(Position = 3)]
        [String]$Id,

        [Parameter(Position = 4)]
        [String]$Style,

        [Parameter(Position = 5)]
        [Hashtable]$Attributes


    )
    Process{
        $attr = ""
        $CommonParameters = ("Attributes", "Content") + [System.Management.Automation.PSCmdlet]::CommonParameters + [System.Management.Automation.PSCmdlet]::OptionalCommonParameters
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
            "<colgroup {0} >"  -f $attr
        }else{
            "<colgroup>"
        }



        if($Content){
            $Content.Invoke()
        }


        '</colgroup>'
    }


}