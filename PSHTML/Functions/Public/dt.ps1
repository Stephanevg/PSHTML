Function dt {
    <#
    .SYNOPSIS
    Create a dt tag in an HTML document.

    .EXAMPLE

    dt
    .EXAMPLE
    dt "woop1" -Class "class"

    .EXAMPLE
    dt "woop2" -Class "class" -Id "Something"

    .EXAMPLE
    dt "woop3" -Class "class" -Id "something" -Style "color:red;"

    .NOTES
    Current version 1.0
       History:
           2018.10.02;bateskevin;Updated to v2.
           2018.04.01;bateskevin;Creation.
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [Cmdletbinding()]
    Param(
        [Parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [AllowNull()]
        [String]
        $Content,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class="",

        [String]$Id,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Style,

        [String]$value,

        [Hashtable]$Attributes
    )

    Process {

        $CommonParameters = @('tagname') + [System.Management.Automation.PSCmdlet]::CommonParameters + [System.Management.Automation.PSCmdlet]::OptionalCommonParameters
        $CustomParameters = $PSBoundParameters.Keys | ? { $_ -notin $CommonParameters }
        
        $htmltagparams = @{}
        $tagname = "dt"

        if ($CustomParameters) {

            foreach ($entry in $CustomParameters) {


                if ($entry -eq "content") {

                    
                    $htmltagparams.$entry = $PSBoundParameters[$entry]
                }
                else {
                    $htmltagparams.$entry = "{0}" -f $PSBoundParameters[$entry]
                }
                
    
            }

            if ($Attributes) {
                $htmltagparams += $Attributes
            }


        }
        Set-HtmlTag -TagName $tagname -Attributes $htmltagparams -TagType nonVoid
        
    }
}