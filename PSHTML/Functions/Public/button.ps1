Function button {
    <#
    .SYNOPSIS
    Creates a <button> html tag.

    .DESCRIPTION
    Should be used in conjunction with a form attribute.


    .EXAMPLE

    button
    .EXAMPLE
    button "woop1" -Class "class"

    .EXAMPLE

    <form>
    <fieldset>
        <button>Personalia:</button>
        Name: <input type="text" size="30"><br>
        Email: <input type="text" size="30"><br>
        Date of birth: <input type="text" size="10">
    </fieldset>
    </form>

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

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class,

        [String]$Id,

        [Hashtable]$Attributes
    )


        $CommonParameters = @('tagname') + [System.Management.Automation.PSCmdlet]::CommonParameters + [System.Management.Automation.PSCmdlet]::OptionalCommonParameters
        $CustomParameters = $PSBoundParameters.Keys | Where-Object -FilterScript { $_ -notin $CommonParameters }




        $htmltagparams = @{}
        $tagname = "button"
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

            Set-HtmlTag -TagName $tagname -Attributes $htmltagparams -TagType nonVoid
        }



}
