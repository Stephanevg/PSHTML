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
    Current version 2.0
       History:
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

        [ValidateSet("ltr","rtl")]
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

        [ValidateSet("Block","Inline")]
        [AllowEmptyString()]
        [AllowNull()]
        [String]$Display = "",


        [ValidateSet("linebreak","scrolle","elide","truncate","scale")]
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
        $CommonParameters = @('tagname') + [System.Management.Automation.PSCmdlet]::CommonParameters + [System.Management.Automation.PSCmdlet]::OptionalCommonParameters
        $CustomParameters = $PSBoundParameters.Keys | ? { $_ -notin $CommonParameters }
        
        if ($CustomParameters) {

            Switch ($CustomParameters) {
                {($_ -eq 'content') -and ($null -eq $htmltagparams.$_)} {
                    $htmltagparams.$_ = @($PSBoundParameters[$_])
                    continue
                }
                {$_ -eq 'content'} {
                    $htmltagparams.$_ += $PSBoundParameters[$_]
                    continue
                }
                default {$htmltagparams.$_ = "{0}" -f $PSBoundParameters[$_]}
            }
        }
    }
    End {
        if ($Attributes) {
            $htmltagparams += $Attributes
        }
        Set-HtmlTag -TagName $tagname -Attributes $htmltagparams -TagType NonVoid 
    }
}

