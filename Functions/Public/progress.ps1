Function progress {
    <#
    .SYNOPSIS
    Create a progress tag in an HTML document.

    .DESCRIPTION

    Tip: Use the <progress> tag in conjunction with JavaScript to display the progress of a task.

    Note: The <progress> tag is not suitable for representing a gauge (e.g. disk space usage or relevance of a query result). To represent a gauge, use the <meter> tag instead.

    .EXAMPLE
    

    .EXAMPLE

    .NOTES
    Current version 2.0
       History:

            2018.10.10;bateskevinhanevg;Creation.
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
        [String]$Max="",

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Value="",

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

        $CommonParameters = "tagname" + [System.Management.Automation.PSCmdlet]::CommonParameters + [System.Management.Automation.PSCmdlet]::OptionalCommonParameters
        $CustomParameters = $PSBoundParameters.Keys | ? { $_ -notin $CommonParameters }
        
        $htmltagparams = @{}
        $tagname = "progress"

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
