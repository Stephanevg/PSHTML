Function Col {
    <#
    .SYNOPSIS
    Generates col HTML tag.

    .DESCRIPTION
    The <col> tag specifies column properties for each column within a <colgroup> element.
    The <col> tag is useful for applying styles to entire columns, instead of repeating the styles for each cell, for each row.

    .PARAMETER Class
    Allows to specify one (or more) class(es) to assign the html element.
    More then one class can be assigned by seperating them with a white space.

    .PARAMETER Id
    Allows to specify an id to assign the html element.

    .PARAMETER Style
    Allows to specify in line CSS style to assign the html element.


    .EXAMPLE

    col -span 3 -Class "Table1"

    Generates the following code

    <col span="3" Class="Table1"  >

    .EXAMPLE

    Col is often used in conjunction with 'colgroup'. See below for an example using colgroup and two col

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
        2018.04.08;Stephanvg; Updated to version 1.0
        2018.04.01;Stephanevg;Fix disyplay bug.
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    Param(
        [Parameter(Position = 0)]
        [int]
        $span,

        [Parameter(Position = 1)]
        [String]$Class,

        [Parameter(Position = 2)]
        [String]$Id,

        [Parameter(Position = 3)]
        [String]$Style,

        [Parameter(Position = 4)]
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
        "<col {0} >"  -f $attr
    }else{
        "<col >"
    }



}
