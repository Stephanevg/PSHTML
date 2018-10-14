Function optgroup {
    <#
    .SYNOPSIS
    Create a optgroup title in an HTML document.

    .DESCRIPTION
    The <optgroup> is used to group related options in a drop-down list.

    If you have a long list of options, groups of related options are easier to handle for a user.

    .EXAMPLE

    optgroup
    .EXAMPLE
    

    .Notes
    Author: Stéphane van Gulick
    Version: 2.0.0
    History:
        2018.05.11;@Stephanevg; fixed minor bugs
        2018.05.09;@Stephanevg; Creation

    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [Cmdletbinding()]
    Param(

        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $false,
            Position = 0
        )]
        [AllowEmptyString()]
        [AllowNull()]
        $Content,

        [Parameter(Mandatory = $false)]
        [String]$Label,

        [Switch]
        $Disabled,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Id,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Style,

        [Hashtable]$Attributes
    )

        $attr = ""
        $CommonParameters = @('tagname') + [System.Management.Automation.PSCmdlet]::CommonParameters + [System.Management.Automation.PSCmdlet]::OptionalCommonParameters
        $CustomParameters = $PSBoundParameters.Keys | Where-Object -FilterScript { $_ -notin $CommonParameters }

        $htmltagparams = @{}
        $tagname = "optgroup"

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

optgroup
