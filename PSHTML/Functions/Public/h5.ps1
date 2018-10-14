Function h5 {
    <#
    .SYNOPSIS
    Create a h5 title in an HTML document.

    .EXAMPLE

    h5
    .EXAMPLE
    h5 "woop1" -Class "class"

    .EXAMPLE
    h5 "woop2" -Class "class" -Id "MainTitle"

    .EXAMPLE
    h5 {"woop3"} -Class "class" -Id "MaintTitle" -Style "color:red;"

    .Notes
    Author: Stéphane van Gulick
    Version: 1.0.0
    History:
        2018.04.08;Stephanevg; Updated to version 1.0: Updated content block to support string & ScriptBlock
        2018.03.25;@Stephanevg; Creation
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
        "<h5 {0} >"  -f $attr
    }else{
        "<h5>"
    }


    if($Content){

        if($Content -is [System.Management.Automation.ScriptBlock]){
            $Content.Invoke()
        }else{
            $Content
        }
    }


    '</h5>'

}