Function fieldset {
    <#
    .SYNOPSIS
    Create a fieldset title in an HTML document.

    .EXAMPLE

    fieldset
    .EXAMPLE
    fieldset "woop1" -Class "class"

    .EXAMPLE
    $css = @"
        "p {color:green;}
        h1 {color:orange;}"
    "@
    fieldset {$css} -media "print" -type "text/css"

    .Notes
    Author: Stéphane van Gulick
    Version: 1.0.0
    History:
        2018.05.09;@Stephanevg; Creation
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [Cmdletbinding()]
    Param(
        [Parameter(Mandatory=$false)]
        [AllowEmptyString()]
        [AllowNull()]
        $Content,

        [switch]$disabled,

        [String]$form,

        [String]$name,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class,

        [String]$Id,

        [Hashtable]$Attributes
    )


        $CommonParameters = @('tagname') + [System.Management.Automation.PSCmdlet]::CommonParameters + [System.Management.Automation.PSCmdlet]::OptionalCommonParameters
        $CustomParameters = $PSBoundParameters.Keys | Where-Object -FilterScript { $_ -notin $CommonParameters }



        $htmltagparams = @{}
        $tagname = "fieldset"
        if($CustomParameters){

            foreach ($entry in $CustomParameters){

                if($entry -eq "content"){


                    $htmltagparams.$entry = $PSBoundParameters[$entry]
                }else{
                    $htmltagparams.$entry = "{0}" -f $PSBoundParameters[$entry]
                }


            }

            if($Attributes){
                $htmltagparams += $Attributes
            }

        }
    Set-HtmlTag -TagName $tagname -Attributes $htmltagparams -TagType nonVoid




}

