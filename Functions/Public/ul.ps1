Function ul {
    <#
    .SYNOPSIS
    Create a ul tag in an HTML document.

    .EXAMPLE
    ul

    .EXAMPLE
    ul -Content {li -Content "asdf"}

    .EXAMPLE
    ul -Class "class" -Id "something" -Style "color:red;"

    .NOTES
    Current version 1.1
       History:
           2018.10.02;bateskevin;Updated to v2.
           2018.04.14;stephanevg;fix Content bug. Upgraded to v1.1.
           2018.04.01;bateskevinhanevg;Creation.
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [CmdletBinding()]
    Param(

        [Parameter(
            ValueFromPipeline = $false,
            Mandatory = $false,
            Position = 0
        )]
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
        [Switch]$reversed,

        [Parameter(Position = 6)]
        [string]$start

    )
    Process {

        $CommonParameters = @('tagname') + [System.Management.Automation.PSCmdlet]::CommonParameters + [System.Management.Automation.PSCmdlet]::OptionalCommonParameters
        $CustomParameters = $PSBoundParameters.Keys | ? { $_ -notin $CommonParameters }
        
        $htmltagparams = @{}
        $tagname = "ul"

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

