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
    Current version 2.1
       History:
        2018.10.24;@ChristopheKumor;Modified $htmltagparams filling to version 2.1
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

        [ValidateSet("1", "A", "a", "I", "i")]
        [Parameter(Position = 7)]
        [String]$type


    )
    Begin {
        $htmltagparams = @{}
        $tagname = "ol"
    }
    Process {



        foreach ($paramkey in $MyInvocation.MyCommand.Parameters.Keys) {
            $paramvalue = Get-Variable $paramkey -ValueOnly -EA SilentlyContinue
            if ($paramvalue -and !$PSBoundParameters.ContainsKey($paramkey)) {
                $htmltagparams.$paramkey = $paramvalue
            }
        }
        
        switch ($PSBoundParameters.Keys) {
            'content' { 
                if ($PSBoundParameters['content'] -is [System.Management.Automation.ScriptBlock]) {
                    $htmltagparams.$_ = $PSBoundParameters[$_]
                    continue
                }
                elseif ($null -eq $htmltagparams.$_) {
                    $htmltagparams.$_ = @($PSBoundParameters[$_])
                    continue   
                }
                else {
                    $htmltagparams.$_ += $PSBoundParameters[$_] 
                    continue
                }
            }
            'Attributes' { 
                if ($null -eq $htmltagparams.$_) {
                    $htmltagparams.$_ += $PSBoundParameters[$_]
                }
                continue
            }
            default { 
                if ($PSBoundParameters[$_].IsPresent) { 
                    $htmltagparams.$_ = $null
                }
                else {
                    $htmltagparams.$_ = '{0}' -f $PSBoundParameters[$_]
                }
            }
        }
    }
    End {

        Set-HtmlTag -TagName $tagname -Attributes $htmltagparams -TagType nonVoid
        
    }

}

