Function optgroup {
    <#
    .SYNOPSIS
    Create a optgroup title in an HTML document.

    .DESCRIPTION
    The <optgroup> is used to group related options in a drop-down list.

    If you have a long list of options, groups of related options are easier to handle for a user.

    .EXAMPLE

    optgroup
    .EXAMPLE
    

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

        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $false,
            Position = 0
        )]
        [AllowEmptyString()]
        [AllowNull()]
        $Content,

        [Parameter(Mandatory = $false)]
        [String]$Label,

        [Switch]
        $Disabled,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Id,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Style,

        [Hashtable]$Attributes
    )

    Begin {
        $CommonParameters = [System.Management.Automation.PSCmdlet]::CommonParameters + [System.Management.Automation.PSCmdlet]::OptionalCommonParameters
        $htmltagparams = @{}
        $tagname = "optgroup"
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
                if ($_ -notin $CommonParameters) {
            
                    if ($PSBoundParameters[$_].IsPresent) { 
                    $htmltagparams.$_ = $null
                }
                else {
                    $htmltagparams.$_ = '{0}' -f $PSBoundParameters[$_]
                }

            }
            }
        }
    }
    End {
        Set-HtmlTag -TagName $tagname -Attributes $htmltagparams -TagType nonVoid
    }

}

