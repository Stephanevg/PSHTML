Function base {
    <#
    .SYNOPSIS
    Create a base title in an HTML document.

    .DESCRIPTION
    The <base> tag specifies the base URL/target for all relative URLs in a document.

    There can be at maximum one <base> element in a document, and it must be inside the <head> element.

    .EXAMPLE

    base
    .EXAMPLE
    base "woop1" -Class "class"

    .Notes
    Author: Stéphane van Gulick
    Version: 1.0.1
    History:
        2018.05.11;@Stephanevg; fixed minor bugs
        2018.05.09;@Stephanevg; Creation

    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [Cmdletbinding()]
    Param(

        [Parameter(Mandatory = $true)]
        [String]$href,

        [ValidateSet("_self","_blank","_parent","_top")]
        [String]$Target = "_self",

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class,

        [String]$Id,

        [Hashtable]$Attributes
    )

        $attr = ""
        $CommonParameters = @('tagname') + [System.Management.Automation.PSCmdlet]::CommonParameters + [System.Management.Automation.PSCmdlet]::OptionalCommonParameters
        $CustomParameters = $PSBoundParameters.Keys | Where-Object -FilterScript { $_ -notin $CommonParameters }

        $htmltagparams = @{}
        $tagname = "base"
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
        Set-HtmlTag -TagName $tagname -Attributes $htmltagparams -TagType Void



}
