Function style {
    <#
    .SYNOPSIS
    Create a style title in an HTML document.

    .EXAMPLE

    style
    .EXAMPLE
    style "woop1" -Class "class"

    .EXAMPLE
    $css = @"
        "p {color:green;}
        h1 {color:orange;}"
    "@
    style {$css} -media "print" -type "text/css"

    .Notes
    Author: Stéphane van Gulick
    Version: 2.1
    History:
        2018.10.24;@ChristopheKumor;Modified $htmltagparams filling to version 2.1
        2018.05.09;@Stephanevg; Creation
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [Cmdletbinding()]
    Param(
        [Parameter(Mandatory = $false)]
        [AllowEmptyString()]
        [AllowNull()]
        $Content,

        [String]$media,

        [String]$Type,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class,

        [String]$Id,

        [Hashtable]$Attributes
    )

    Begin {
        $htmltagparams = @{}
        $tagname = "style"
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
