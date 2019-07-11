function Get-PSHTMLColor {
    <#
    .SYNOPSIS
    
    Returns a color string based on a color type and name
    
    .DESCRIPTION
    
    Returns a color string based on one of the W3C defined color names, using one of the
    formats typically used in HTML.
    
    .PARAMETER Type
    
    The type of color returned. Possible values: hex, hsl, hsla, rgb, rgba
    
    .PARAMETER Color
    
    A color name as defined by the W3C
    
    .EXAMPLE
    
    Get-PSHTMLColor -Type hex -Color lightblue
    #ADD8E6
    
    .EXAMPLE
    
    Get-PSHTMLColor -Type hsl -Color lightblue
    hsl(194,52%,79%)
    
    .EXAMPLE
    
    Get-PSHTMLColor -Type hsla -Color lightblue
    hsla(194,52%,79%,0)
    
    .EXAMPLE
    
    Get-PSHTMLColor -Type rgb -Color lightblue
    rgb(173,216,230)
    
    .EXAMPLE
    
    Get-PSHTMLColor -Type rgba -Color lightblue
    rgba(173,216,230,0)
    
    #>
        Param(
            [Parameter(Mandatory=$false)]
            [ValidateSet("hex","hsl","hsla","rgb","rgba")]
            [string]
            $Type="rgb", 
            [Parameter(Mandatory=$true)]
            [ArgumentCompleter({[Color]::colornames})]
            [String]
            $Color
        )
    
        $colordef =  "$($color)_def"
        switch ($Type){
            'rgb' {
                Return [Color]::$color
                }
            'rgba' {
                Return [Color]::rgba([Color]::$colordef.R,[Color]::$colordef.G,[Color]::$colordef.B,0)
                }
            'hex' {
                Return [Color]::hex([Color]::$colordef.R,[Color]::$colordef.G,[Color]::$colordef.B)
                }
            'hsl'{
                Return [Color]::hsl([Color]::$colordef.R,[Color]::$colordef.G,[Color]::$colordef.B)
            }
            'hsla' {
                Return [Color]::hsla([Color]::$colordef.R,[Color]::$colordef.G,[Color]::$colordef.B,0)
            }
            default {
                Return [Color]::$Color
                }
        }
        
    }