Function canvas {
    <#
    .SYNOPSIS
    Create a canvas tag in an HTML document.

    .DESCRIPTION

    Will create a canvas. Perfect to draw beautfill art.

    Note: Any text inside the <canvas> element will be displayed in browsers that does not support <canvas>.

    .EXAMPLE
    
     canvas -Height 300 -Width 400

     generates

    <canvas Height="300" Width="400"  >
    </canvas>

    .EXAMPLE
    
    #text will be displayed, only if the canvas cannot be displayed in the browser.
    canvas -Height 300 -Width 400 -Content "Not supported in your browser"

    <canvas Width="400" Height="300"  >
        Not supported in your browser
    </canvas>

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

        [AllowEmptyString()]
        [AllowNull()]
        $Height,

        [AllowEmptyString()]
        [AllowNull()]
        $Width,

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
        $tagname = "canvas"
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

