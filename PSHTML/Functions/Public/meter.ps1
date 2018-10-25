Function meter {
    <#
    .SYNOPSIS
    Create a meter tag in an HTML document.

    .DESCRIPTION

    The <meter> tag defines a scalar measurement within a known range, or a fractional value. This is also known as a gauge.

    Examples: Disk usage, the relevance of a query result, etc.

    Note: The <meter> tag should not be used to indicate progress (as in a progress bar). For progress bars, use the <progress> tag.

    .EXAMPLE
    
    <meter Min="0" Value="58" Max="100"  >
    Represents 58%
    </meter>

    .EXAMPLE
     meter -Value 0.75

     Returns:

    <meter Value="0.75"  >
    </meter>

    .NOTES
    Current version 2.1
       History:
            2018.10.24;@ChristopheKumor;Modified $htmltagparams filling to version 2.1
            2018.10.10;stephanevg;Creation.
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
        [AllowEmptyString()]
        [AllowNull()]
        [String]
        $Value,

        [Parameter(Mandatory = $false)]
        [AllowEmptyString()]
        [AllowNull()]
        [String]
        $Min,

        [Parameter(Mandatory = $false)]
        [AllowEmptyString()]
        [AllowNull()]
        [String]
        $Max,

        [string]$cite,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class,

        [String]$Id,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Style,

        [String]$title,

        [Hashtable]$Attributes
    )

    Begin {
        $CommonParameters = [System.Management.Automation.PSCmdlet]::CommonParameters + [System.Management.Automation.PSCmdlet]::OptionalCommonParameters
        $htmltagparams = @{}
        $tagname = "meter"        
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

        Set-HtmlTag -TagName $tagname -Attributes $htmltagparams -TagType NonVoid
    }
}
