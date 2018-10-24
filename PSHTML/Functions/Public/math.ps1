Function math {
    <#
    .SYNOPSIS
    Create a math tag in an HTML document.

    .EXAMPLE
    
    math -dir ltr -MathbackGround "#234"

    #Generates the following

    <math dir="ltr" MathbackGround="#234"  >
    </math>

    .EXAMPLE
    
     math -dir ltr -MathbackGround "#234" -Display Inline -Overflow linebreak
    
     #Generates the following

     <math Overflow="linebreak" dir="ltr" Display="Inline" MathbackGround="#234"  >
    </math>

    .NOTES
    Current version 2.1
       History:
            2018.10.24;@ChristopheKumor;Modified $htmltagparams filling to version 2.1
            2018.04.01;stephanevg;Creation.
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

        [ValidateSet("ltr", "rtl")]
        [AllowEmptyString()]
        [AllowNull()]
        [String]$dir = "",

        [AllowEmptyString()]
        [AllowNull()]
        [String]$href = "",

        [AllowEmptyString()]
        [AllowNull()]
        [String]$MathbackGround = "",

        [AllowEmptyString()]
        [AllowNull()]
        [String]$MathColor = "",

        [ValidateSet("Block", "Inline")]
        [AllowEmptyString()]
        [AllowNull()]
        [String]$Display = "",


        [ValidateSet("linebreak", "scrolle", "elide", "truncate", "scale")]
        [AllowEmptyString()]
        [AllowNull()]
        [String]$Overflow,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class = "",

        [String]$Id,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Style,

        [String]$title,

        [Hashtable]$Attributes
    )

    Begin {
        
        $htmltagparams = @{}
        $tagname = "math"
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
        Set-HtmlTag -TagName $tagname -Attributes $htmltagparams -TagType NonVoid 
    }
}

