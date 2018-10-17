Function SUP {
    <#
    .SYNOPSIS
    Create a SUP title in an HTML document.

    .EXAMPLE

    SUP
    .EXAMPLE
    SUP "woop1" -Class "class"

    .EXAMPLE
    SUP "woop2" -Class "class" -Id "MainTitle"

    .EXAMPLE
    SUP {"woop3"} -Class "class" -Id "MaintTitle" -Style "color:red;"

    .Notes
    Author: Chendrayan Venkatesan (Chen V)
    Version: 1.0.0
    History:
        2018.10.17;@ChendrayanV; New Version 1.0.0
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

        [Hashtable]$Attributes
    )

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
        "<SUP {0} >"  -f $attr
    }else{
        "<SUP>"
    }


    if($Content){

        if($Content -is [System.Management.Automation.ScriptBlock]){
            $Content.Invoke()
        }else{
            $Content
        }
    }


    '</SUP>'

}