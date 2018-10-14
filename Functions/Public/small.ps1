Function small {
    <#
    .SYNOPSIS
    Create a <small> element in an HTML document.

    .DESCRIPTION
    The <small> tag defines smaller text (and other side comments).


    .EXAMPLE

    small

    Returns>

    <small>
    </small>
    .EXAMPLE
    small "woop1" -Class "class"

    <small Class="class"  >
        woop1
    </small>

    .Notes
    Author: Stéphane van Gulick
    Version: 2.0.0
    History:
        2018.10.04;@Stephanevg; Creation

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

        [String]$Style,

        [Hashtable]$Attributes
    )

        $attr = ""
        $CommonParameters = @('tagname') + [System.Management.Automation.PSCmdlet]::CommonParameters + [System.Management.Automation.PSCmdlet]::OptionalCommonParameters
        $CustomParameters = $PSBoundParameters.Keys | Where-Object -FilterScript { $_ -notin $CommonParameters }

        $htmltagparams = @{}
        $tagname = "small"
        if($CustomParameters){

            foreach ($entry in $CustomParameters){

                if($entry -eq "content"){


                    $htmltagparams.$entry = $PSBoundParameters[$entry]
                }else{
                    $htmltagparams.$entry = "{0}" -f $PSBoundParameters[$entry]
                }
            }
        }

        if($Attributes){
            $htmltagparams += $Attributes
        }

        Set-HtmlTag -TagName $tagname -Attributes $htmltagparams -TagType nonVoid
}

$CustomAtt = @{"MyAttribute1"='MyValue1';"MyAttribute2"="MyValue2"}
small -Attributes $CustomAtt