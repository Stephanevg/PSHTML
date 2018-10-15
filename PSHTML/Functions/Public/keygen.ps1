Function Keygen {
    <#
    .SYNOPSIS
    Create a Keygen tag in an HTML document.

    .DESCRIPTION

    The name attribute specifies the name of a <keygen> element.

    The name attribute of the <keygen> element is used to reference form data after the form has been submitted.

    .EXAMPLE

     keygen -Name "Secure"

     Returns:

    <Keygen Name="Secure"  />

    .NOTES
    Current version 2.0
       History:
            2018.10.10;Stephanevg;Creation.
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [Cmdletbinding()]
    Param(
        
        [AllowEmptyString()]
        [AllowNull()]
        [String]$Name="",

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class="",

        [String]$Id,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Style,

        [String]$title,

        [Hashtable]$Attributes
    )

    Process {

        $CommonParameters = @('tagname') + [System.Management.Automation.PSCmdlet]::CommonParameters + [System.Management.Automation.PSCmdlet]::OptionalCommonParameters
        $CustomParameters = $PSBoundParameters.Keys | ? { $_ -notin $CommonParameters }
        
        $htmltagparams = @{}
        $tagname = "Keygen"

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
        Set-HtmlTag -TagName $tagname -Attributes $htmltagparams -TagType void   
    }
}
