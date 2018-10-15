Function datalist {
    <#
    .SYNOPSIS
    Create a datalist tag in an HTML document.

    .DESCRIPTION

    The <datalist> tag specifies a list of pre-defined options for an <input> element.

    The <datalist> tag is used to provide an "autocomplete" feature on <input> elements. Users will see a drop-down list of pre-defined options as they input data.

    Use the <input> element's list attribute to bind it together with a <datalist> element.

    .EXAMPLE
    
    datalist {
        option -value "Volvo" -Content "Volvo" 
        option -value Saab -Content "saab"
    }


    Generates the following code:

    <datalist>
        <option value="Volvo"  >volvo</option>
        <option value="Saab"  >saab</option>
    </datalist>
    .EXAMPLE
    

    .NOTES
    Current version 2.0
       History:
            2018.10.05;@stephanevg;Creation.
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
        $tagname = "datalist"

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
        Set-HtmlTag -TagName $tagname -Attributes $htmltagparams -TagType NonVoid   
    }
}
