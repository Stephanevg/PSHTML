Function base {
    <#
    .SYNOPSIS
    Create a base title in an HTML document.

    .DESCRIPTION
    The <base> tag specifies the base URL/target for all relative URLs in a document.

    There can be at maximum one <base> element in a document, and it must be inside the <head> element.

    .EXAMPLE

    base
    .EXAMPLE
    base "woop1" -Class "class"

    .Notes
    Author: Stéphane van Gulick
    Version: 2.1
    History:
        2018.10.24;@ChristopheKumor;Modified $htmltagparams filling to version 2.1
        2018.05.11;@Stephanevg; fixed minor bugs
        2018.05.09;@Stephanevg; Creation

    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [Cmdletbinding()]
    Param(

        [Parameter(Mandatory = $true)]
        [String]$href,

        [ValidateSet("_self", "_blank", "_parent", "_top")]
        [String]$Target = "_self",

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class,

        [String]$Id,

        [Hashtable]$Attributes
    )

    Begin {
        $htmltagparams = @{}
        $tagname = "base"
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

        Set-HtmlTag -TagName $tagname -Attributes $htmltagparams -TagType Void
    }


}
