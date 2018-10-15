Function dl {
    <#
    .SYNOPSIS
    Create a dl tag in an HTML document.

    .EXAMPLE
    dl

    .EXAMPLE
    dl -Content {dt -Content "Coffe";dl -Content "Black hot drink"}

    .EXAMPLE
    dl -Class "class" -Id "something" -Style "color:red;"

    .NOTES
    Current version 1.0
       History:
            2018.10.02;bateskevin;Updated to v2.
            2018.05.01;Removed reversed as this is not supported.
            2018.04.01;bateskevin;Creation.
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [CmdletBinding()]
    Param(

        [Parameter(Mandatory=$false,position=0)]
        [AllowEmptyString()]
        [AllowNull()]
        $Content,

        [Parameter(Position = 1)]
        [String]$Class,

        [Parameter(Position = 2)]
        [String]$Id,

        [Parameter(Position = 3)]
        [String]$Style,

        [Parameter(Position = 4)]
        [Hashtable]$Attributes,

        [Parameter(Position = 5)]
        [string]$start

    )
    Process {

        $CommonParameters = @('tagname') + [System.Management.Automation.PSCmdlet]::CommonParameters + [System.Management.Automation.PSCmdlet]::OptionalCommonParameters
        $CustomParameters = $PSBoundParameters.Keys | ? { $_ -notin $CommonParameters }
        
        $htmltagparams = @{}
        $tagname = "dl"

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
