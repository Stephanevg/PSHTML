Function selecttag {
    <#
    .SYNOPSIS

    creates a "select" html tag.

    .Description
    The name of the cmdlet has volontarly been changed from "select" to "selectag" in order to avoid a conflict with
    with the built-in powershell alias "select" (which points to Select-object)


    .EXAMPLE

    selecttag
    .EXAMPLE
    selecttag "woop1" -Class "class"

    .EXAMPLE

    <select>
        <option value="volvo">Volvo</option>
        <option value="saab">Saab</option>
        <option value="mercedes">Mercedes</option>
        <option value="audi">Audi</option>
    </select>

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
        $tagname = "select"
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
