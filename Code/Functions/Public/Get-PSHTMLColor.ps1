
Enum PSHTMLColor {
    aliceblue
    antiquewhite
    aqua
    aquamarine
    azure
    beige
    bisque
    black
    blanchedalmond
    blue
    blueviolet
    brown
    burlywood
    cadetblue
    chartreuse
    chocolate
    coral
    cornflowerblue
    cornsilk
    crimson
    cyan
    darkblue
    darkcyan
    darkgoldenrod
    darkgray
    darkgreen
    darkgrey
    darkkhaki
    darkmagenta
    darkolivegreen
    darkorange
    darkorchid
    darkred
    darksalmon
    darkseagreen
    darkslateblue
    darkslategray
    darkslategrey
    darkturquoise
    darkviolet
    deeppink
    deepskyblue
    dimgray
    dimgrey
    dodgerblue
    firebrick
    floralwhite
    forestgreen
    fuchsia
    gainsboro
    ghostwhite
    gold
    goldenrod
    gray
    green
    greenyellow
    grey
    honeydew
    hotpink
    indianred
    indigo
    ivory
    khaki
    lavender
    lavenderblush
    lawngreen
    lemonchiffon
    lightblue
    lightcoral
    lightcyan
    lightgoldenrodyellow
    lightgray
    lightgreen
    lightgrey
    lightpink
    lightsalmon
    lightseagreen
    lightskyblue
    lightslategray
    lightslategrey
    lightsteelblue
    lightyellow
    lime
    limegreen
    linen
    magenta
    maroon
    mediumaquamarine
    mediumblue
    mediumorchid
    mediumpurple
    mediumseagreen
    mediumslateblue
    mediumspringgreen
    mediumturquoise
    mediumvioletred
    midnightblue
    mintcream
    mistyrose
    moccasin
    navajowhite
    navy
    oldlace
    olive
    olivedrab
    orange
    orangered
    orchid
    palegoldenrod
    palegreen
    paleturquoise
    palevioletred
    papayawhip
    peachpuff
    peru
    pink
    plum
    powderblue
    purple
    red
    rosybrown
    royalblue
    saddlebrown
    salmon
    sandybrown
    seagreen
    seashell
    sienna
    silver
    skyblue
    slateblue
    slategray
    slategrey
    snow
    springgreen
    steelblue
    tan
    teal
    thistle
    tomato
    turquoise
    violet
    wheat
    white
    whitesmoke
    yellow
    yellowgreen
}

Class ColorFactory {
    [int]$r
    [int]$g
    [int]$b
    [double]$a

    color([int]$r,[int]$g,[int]$b){
        $this.r = $r
        $this.g = $g
        $this.b = $b
    }

    color([int]$r,[int]$g,[int]$b,[double]$a){
        $this.r = $r
        $this.g = $g
        $this.b = $b
        $this.a = $a
    }

#   W3 color names
#   Implement hex, rgb, rgba, hsl and hsla types
#   https://www.w3.org/TR/css-color-3/#colorunits

#logic from http://www.niwa.nu/2013/05/math-behind-colorspace-conversions-rgb-hsl/
static [string] hslcalc([int]$r, [int]$g, [int]$b, [double]$a) {
    $rc = [Math]::Round($r/255,2)
    $bc = [Math]::Round($b/255,2)
    $gc = [Math]::Round($g/255,2)

    $h = 0

    $m = $rc,$bc,$gc | Measure-Object -Maximum -Minimum
    $m

    $l = [Math]::Round(($m.Maximum + $m.Minimum)/2,2)
    Write-Verbose "L: $l"

    if ($m.Maximum -eq $m.Minimum) {
        $s = 0
    }
    else {
        if ($l -le 0.5) {
            $s = ($m.Maximum - $m.Minimum)/($m.Maximum + $m.Minimum)
        }
        else {
            $s = ($m.Maximum - $m.Minimum)/(2 - $m.Maximum - $m.Minimum)
        }
    }
    Write-Verbose "S: $s"

    if ($s -eq 0) {
        $h = 0
    }
    else {
        if ($rc -eq $m.Maximum) {
            $h =  ($gc-$bc)/($m.Maximum-$m.Minimum)
        }

        if ($gc -eq $m.Maximum) {
            $h =  2 + ($bc-$rc)/($m.Maximum-$m.Minimum)
        }

        if ($bc -eq $m.Maximum) {
            $h =  4 + ($rc-$gc)/($m.Maximum-$m.Minimum)  
        }

        if ($h -lt 0) {
            $h+= 360
        }

        $h = $h * 60
    }
    Write-Verbose "H: $h"
    
    if ($a -le 1) {
        return "hsla({0},{1:p0},{2:p0},{3})" -f [Math]::Round($h), [Math]::Round($s,2), $l, $a
    }
    else {
        $value = "hsl({0},{1:p0},{2:p0})" -f [Math]::Round($h), [Math]::Round($s,2), $l
        #on macOS, output is like this: hsl(240,100 %,50 %)
        $return = $value.Replace(" ","")
        return $return
        
    }
}

static [string] hex([int]$r,[int]$g,[int]$b){ 
    return "#{0:X2}{1:X2}{2:X2}" -f $r,$g,$b ;
}

static [string] hsl([int]$r,[int]$g,[int]$b){ 
    return [ColorFactory]::hslcalc($r, $g, $b, 9) ;
}

static [string] hsla([int]$r,[int]$g,[int]$b, [double] $a){ 
    return [ColorFactory]::hslcalc($r, $g, $b, $a) ;
}

static [string] rgb([int]$r,[int]$g,[int]$b){
    return "rgb({0},{1},{2})" -f $r,$g,$b
}
static [string] rgba([int]$r,[int]$g,[int]$b,[double]$a){
    return "rgba({0},{1},{2},{3})" -f $r,$g,$b,$a
}
}
function Get-PSHTMLColor {
    Param(
        [Parameter(Mandatory=$false)]
        [ValidateSet("hex","hsl","hsla","rgb","rgba")]
        [string]
        $Type="rgb", 
        [Parameter(Mandatory=$true)]
        [PSHTMLColor]
        $Color

    )
    $netcolor = [System.Drawing.Color]::FromName($color)
    switch ($Type){
        'rgb' {
            Return [ColorFactory]::rgb($netcolor.R,$netcolor.G,$netcolor.B)
            }
        'rgba' {
            Return [ColorFactory]::rgba($netcolor.R,$netcolor.G,$netcolor.B,0)
            }
        'hex' {
            Return [ColorFactory]::hex($netcolor.R,$netcolor.G,$netcolor.B)
            }
        'hsl'{
            Return [ColorFactory]::hsl($netcolor.R,$netcolor.G,$netcolor.B)
        }
        'hsla' {
            Return [ColorFactory]::hsla($netcolor.R,$netcolor.G,$netcolor.B,0)
        }
        default {
            Return [ColorFactory]::rgb($netcolor.R,$netcolor.G,$netcolor.B)
            }
    }
}