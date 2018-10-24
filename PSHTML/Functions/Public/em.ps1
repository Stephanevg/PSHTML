Function em {
    <#
    .SYNOPSIS
    Generates em HTML tag.

    .Description
    This tag is a phrase tag. It renders as emphasized text.

    .EXAMPLE
    p{
        "This is";em {"cool"}
    }

    Will generate the following code

    <p>
        This is
        <em>
        cool
        </em>
    </p>

    .Notes
    Author: Andrew Wickham
    Version: 2.1
    History:
        2018.10.24;@ChristopheKumor;Modified $htmltagparams filling to version 2.1
        2018.10.04;@awickham10; Creation

    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [CmdletBinding()]
    Param(

        [Parameter(
            ValueFromPipeline = $true,
            Position = 0
        )]
        [object]$Content,

        [Parameter(Position = 1)]
        [String]$Class,

        [Parameter(Position = 2)]
        [String]$Id,

        [Parameter(Position = 3)]
        [String]$Style,

        [Parameter(Position = 4)]
        [Hashtable]$Attributes

    )
    Begin {
        $htmltagparams = @{}
        $tagname = "em"
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