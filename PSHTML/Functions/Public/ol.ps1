Function ol {
    <#
    .SYNOPSIS
    Create a ol tag in an HTML document.

    .EXAMPLE
    ol

    .EXAMPLE
    ol -Content {li -Content "asdf"}

    .EXAMPLE
    ol -Class "class" -Id "something" -Style "color:red;"

    .EXAMPLE

    ol {li -Content "asdf"} -reversed -type a

    #Generates the following content

    <ol type="a" reversed >
        <li>
            asdf
        </li>
    </ol>

    .NOTES
    Current version 1.1
       History:
        2018.10.02;bateskevin;Updated to v2.
        2018.04.14;stephanevg;fix Content bug, Added parameter 'type'. Upgraded to v1.1.
        2018.04.01;bateskevin;Creation.
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [CmdletBinding()]
    Param(

        [Parameter(
            ValueFromPipeline = $true,
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
        [int]$start,

        [ValidateSet("1","A","a","I","i")]
        [Parameter(Position = 7)]
        [String]$type


    )
    Process {

        $CommonParameters = @('tagname') + [System.Management.Automation.PSCmdlet]::CommonParameters + [System.Management.Automation.PSCmdlet]::OptionalCommonParameters
        $CustomParameters = $PSBoundParameters.Keys | ? { $_ -notin $CommonParameters }
        
        $htmltagparams = @{}
        $tagname = "ol"

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

