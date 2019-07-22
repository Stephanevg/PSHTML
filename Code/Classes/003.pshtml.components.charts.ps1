
#From Jakub Jares (Thanks!)
function Clear-WhiteSpace ($Text) {
    "$($Text -replace "(`t|`n|`r)"," " -replace "\s+"," ")".Trim()
}

Enum ChartType {
    bar
    horizontalBar
    line
    doughnut
    pie
    radar
    polarArea
}

Class Color {
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

<#

    Original color names

    static [String] $blue = "rgb(30,144,255)"
    static [String] $red = "rgb(220,20,60)"
    static [string] $Yellow = "rgb(255,255,0)"
    static [string] $Green = "rgb(173,255,47)"
    static [string] $Orange = "rgb(255,165,0)"
    static [string] $Black = "rgb(0,0,0)"
    static [string] $White = "rgb(255,255,255)"
#>

#   W3 color names
#   Implement hex, rgb, rgba, hsl and hsla types
#   https://www.w3.org/TR/css-color-3/#colorunits
static [object] $aliceblue_def = @{"r"=240;"g"=248;"b"=255}
static [object] $antiquewhite_def = @{"r"=250;"g"=235;"b"=215}
static [object] $aqua_def = @{"r"=0;"g"=255;"b"=255}
static [object] $aquamarine_def = @{"r"=127;"g"=255;"b"=212}
static [object] $azure_def = @{"r"=240;"g"=255;"b"=255}
static [object] $beige_def = @{"r"=245;"g"=245;"b"=220}
static [object] $bisque_def = @{"r"=255;"g"=228;"b"=196}
static [object] $black_def = @{"r"=0;"g"=0;"b"=0}
static [object] $blanchedalmond_def = @{"r"=255;"g"=235;"b"=205}
static [object] $blue_def = @{"r"=0;"g"=0;"b"=255}
static [object] $blueviolet_def = @{"r"=138;"g"=43;"b"=226}
static [object] $brown_def = @{"r"=165;"g"=42;"b"=42}
static [object] $burlywood_def = @{"r"=222;"g"=184;"b"=135}
static [object] $cadetblue_def = @{"r"=95;"g"=158;"b"=160}
static [object] $chartreuse_def = @{"r"=127;"g"=255;"b"=0}
static [object] $chocolate_def = @{"r"=210;"g"=105;"b"=30}
static [object] $coral_def = @{"r"=255;"g"=127;"b"=80}
static [object] $cornflowerblue_def = @{"r"=100;"g"=149;"b"=237}
static [object] $cornsilk_def = @{"r"=255;"g"=248;"b"=220}
static [object] $crimson_def = @{"r"=220;"g"=20;"b"=60}
static [object] $cyan_def = @{"r"=0;"g"=255;"b"=255}
static [object] $darkblue_def = @{"r"=0;"g"=0;"b"=139}
static [object] $darkcyan_def = @{"r"=0;"g"=139;"b"=139}
static [object] $darkgoldenrod_def = @{"r"=184;"g"=134;"b"=11}
static [object] $darkgray_def = @{"r"=169;"g"=169;"b"=169}
static [object] $darkgreen_def = @{"r"=0;"g"=100;"b"=0}
static [object] $darkgrey_def = @{"r"=169;"g"=169;"b"=169}
static [object] $darkkhaki_def = @{"r"=189;"g"=183;"b"=107}
static [object] $darkmagenta_def = @{"r"=139;"g"=0;"b"=139}
static [object] $darkolivegreen_def = @{"r"=85;"g"=107;"b"=47}
static [object] $darkorange_def = @{"r"=255;"g"=140;"b"=0}
static [object] $darkorchid_def = @{"r"=153;"g"=50;"b"=204}
static [object] $darkred_def = @{"r"=139;"g"=0;"b"=0}
static [object] $darksalmon_def = @{"r"=233;"g"=150;"b"=122}
static [object] $darkseagreen_def = @{"r"=143;"g"=188;"b"=143}
static [object] $darkslateblue_def = @{"r"=72;"g"=61;"b"=139}
static [object] $darkslategray_def = @{"r"=47;"g"=79;"b"=79}
static [object] $darkslategrey_def = @{"r"=47;"g"=79;"b"=79}
static [object] $darkturquoise_def = @{"r"=0;"g"=206;"b"=209}
static [object] $darkviolet_def = @{"r"=148;"g"=0;"b"=211}
static [object] $deeppink_def = @{"r"=255;"g"=20;"b"=147}
static [object] $deepskyblue_def = @{"r"=0;"g"=191;"b"=255}
static [object] $dimgray_def = @{"r"=105;"g"=105;"b"=105}
static [object] $dimgrey_def = @{"r"=105;"g"=105;"b"=105}
static [object] $dodgerblue_def = @{"r"=30;"g"=144;"b"=255}
static [object] $firebrick_def = @{"r"=178;"g"=34;"b"=34}
static [object] $floralwhite_def = @{"r"=255;"g"=250;"b"=240}
static [object] $forestgreen_def = @{"r"=34;"g"=139;"b"=34}
static [object] $fuchsia_def = @{"r"=255;"g"=0;"b"=255}
static [object] $gainsboro_def = @{"r"=220;"g"=220;"b"=220}
static [object] $ghostwhite_def = @{"r"=248;"g"=248;"b"=255}
static [object] $gold_def = @{"r"=255;"g"=215;"b"=0}
static [object] $goldenrod_def = @{"r"=218;"g"=165;"b"=32}
static [object] $gray_def = @{"r"=128;"g"=128;"b"=128}
static [object] $green_def = @{"r"=0;"g"=128;"b"=0}
static [object] $greenyellow_def = @{"r"=173;"g"=255;"b"=47}
static [object] $grey_def = @{"r"=128;"g"=128;"b"=128}
static [object] $honeydew_def = @{"r"=240;"g"=255;"b"=240}
static [object] $hotpink_def = @{"r"=255;"g"=105;"b"=180}
static [object] $indianred_def = @{"r"=205;"g"=92;"b"=92}
static [object] $indigo_def = @{"r"=75;"g"=0;"b"=130}
static [object] $ivory_def = @{"r"=255;"g"=255;"b"=240}
static [object] $khaki_def = @{"r"=240;"g"=230;"b"=140}
static [object] $lavender_def = @{"r"=230;"g"=230;"b"=250}
static [object] $lavenderblush_def = @{"r"=255;"g"=240;"b"=245}
static [object] $lawngreen_def = @{"r"=124;"g"=252;"b"=0}
static [object] $lemonchiffon_def = @{"r"=255;"g"=250;"b"=205}
static [object] $lightblue_def = @{"r"=173;"g"=216;"b"=230}
static [object] $lightcoral_def = @{"r"=240;"g"=128;"b"=128}
static [object] $lightcyan_def = @{"r"=224;"g"=255;"b"=255}
static [object] $lightgoldenrodyellow_def = @{"r"=250;"g"=250;"b"=210}
static [object] $lightgray_def = @{"r"=211;"g"=211;"b"=211}
static [object] $lightgreen_def = @{"r"=144;"g"=238;"b"=144}
static [object] $lightgrey_def = @{"r"=211;"g"=211;"b"=211}
static [object] $lightpink_def = @{"r"=255;"g"=182;"b"=193}
static [object] $lightsalmon_def = @{"r"=255;"g"=160;"b"=122}
static [object] $lightseagreen_def = @{"r"=32;"g"=178;"b"=170}
static [object] $lightskyblue_def = @{"r"=135;"g"=206;"b"=250}
static [object] $lightslategray_def = @{"r"=119;"g"=136;"b"=153}
static [object] $lightslategrey_def = @{"r"=119;"g"=136;"b"=153}
static [object] $lightsteelblue_def = @{"r"=176;"g"=196;"b"=222}
static [object] $lightyellow_def = @{"r"=255;"g"=255;"b"=224}
static [object] $lime_def = @{"r"=0;"g"=255;"b"=0}
static [object] $limegreen_def = @{"r"=50;"g"=205;"b"=50}
static [object] $linen_def = @{"r"=250;"g"=240;"b"=230}
static [object] $magenta_def = @{"r"=255;"g"=0;"b"=255}
static [object] $maroon_def = @{"r"=128;"g"=0;"b"=0}
static [object] $mediumaquamarine_def = @{"r"=102;"g"=205;"b"=170}
static [object] $mediumblue_def = @{"r"=0;"g"=0;"b"=205}
static [object] $mediumorchid_def = @{"r"=186;"g"=85;"b"=211}
static [object] $mediumpurple_def = @{"r"=147;"g"=112;"b"=219}
static [object] $mediumseagreen_def = @{"r"=60;"g"=179;"b"=113}
static [object] $mediumslateblue_def = @{"r"=123;"g"=104;"b"=238}
static [object] $mediumspringgreen_def = @{"r"=0;"g"=250;"b"=154}
static [object] $mediumturquoise_def = @{"r"=72;"g"=209;"b"=204}
static [object] $mediumvioletred_def = @{"r"=199;"g"=21;"b"=133}
static [object] $midnightblue_def = @{"r"=25;"g"=25;"b"=112}
static [object] $mintcream_def = @{"r"=245;"g"=255;"b"=250}
static [object] $mistyrose_def = @{"r"=255;"g"=228;"b"=225}
static [object] $moccasin_def = @{"r"=255;"g"=228;"b"=181}
static [object] $navajowhite_def = @{"r"=255;"g"=222;"b"=173}
static [object] $navy_def = @{"r"=0;"g"=0;"b"=128}
static [object] $oldlace_def = @{"r"=253;"g"=245;"b"=230}
static [object] $olive_def = @{"r"=128;"g"=128;"b"=0}
static [object] $olivedrab_def = @{"r"=107;"g"=142;"b"=35}
static [object] $orange_def = @{"r"=255;"g"=165;"b"=0}
static [object] $orangered_def = @{"r"=255;"g"=69;"b"=0}
static [object] $orchid_def = @{"r"=218;"g"=112;"b"=214}
static [object] $palegoldenrod_def = @{"r"=238;"g"=232;"b"=170}
static [object] $palegreen_def = @{"r"=152;"g"=251;"b"=152}
static [object] $paleturquoise_def = @{"r"=175;"g"=238;"b"=238}
static [object] $palevioletred_def = @{"r"=219;"g"=112;"b"=147}
static [object] $papayawhip_def = @{"r"=255;"g"=239;"b"=213}
static [object] $peachpuff_def = @{"r"=255;"g"=218;"b"=185}
static [object] $peru_def = @{"r"=205;"g"=133;"b"=63}
static [object] $pink_def = @{"r"=255;"g"=192;"b"=203}
static [object] $plum_def = @{"r"=221;"g"=160;"b"=221}
static [object] $powderblue_def = @{"r"=176;"g"=224;"b"=230}
static [object] $purple_def = @{"r"=128;"g"=0;"b"=128}
static [object] $red_def = @{"r"=255;"g"=0;"b"=0}
static [object] $rosybrown_def = @{"r"=188;"g"=143;"b"=143}
static [object] $royalblue_def = @{"r"=65;"g"=105;"b"=225}
static [object] $saddlebrown_def = @{"r"=139;"g"=69;"b"=19}
static [object] $salmon_def = @{"r"=250;"g"=128;"b"=114}
static [object] $sandybrown_def = @{"r"=244;"g"=164;"b"=96}
static [object] $seagreen_def = @{"r"=46;"g"=139;"b"=87}
static [object] $seashell_def = @{"r"=255;"g"=245;"b"=238}
static [object] $sienna_def = @{"r"=160;"g"=82;"b"=45}
static [object] $silver_def = @{"r"=192;"g"=192;"b"=192}
static [object] $skyblue_def = @{"r"=135;"g"=206;"b"=235}
static [object] $slateblue_def = @{"r"=106;"g"=90;"b"=205}
static [object] $slategray_def = @{"r"=112;"g"=128;"b"=144}
static [object] $slategrey_def = @{"r"=112;"g"=128;"b"=144}
static [object] $snow_def = @{"r"=255;"g"=250;"b"=250}
static [object] $springgreen_def = @{"r"=0;"g"=255;"b"=127}
static [object] $steelblue_def = @{"r"=70;"g"=130;"b"=180}
static [object] $tan_def = @{"r"=210;"g"=180;"b"=140}
static [object] $teal_def = @{"r"=0;"g"=128;"b"=128}
static [object] $thistle_def = @{"r"=216;"g"=191;"b"=216}
static [object] $tomato_def = @{"r"=255;"g"=99;"b"=71}
static [object] $turquoise_def = @{"r"=64;"g"=224;"b"=208}
static [object] $violet_def = @{"r"=238;"g"=130;"b"=238}
static [object] $wheat_def = @{"r"=245;"g"=222;"b"=179}
static [object] $white_def = @{"r"=255;"g"=255;"b"=255}
static [object] $whitesmoke_def = @{"r"=245;"g"=245;"b"=245}
static [object] $yellow_def = @{"r"=255;"g"=255;"b"=0}
static [object] $yellowgreen_def = @{"r"=154;"g"=205;"b"=50}

static [string] $aliceblue = "rgb({0},{1},{2})" -f [Color]::aliceblue_def.r, [Color]::aliceblue_def.g, [Color]::aliceblue_def.b
static [string] $antiquewhite = "rgb({0},{1},{2})" -f [Color]::antiquewhite_def.r, [Color]::antiquewhite_def.g, [Color]::antiquewhite_def.b
static [string] $aqua = "rgb({0},{1},{2})" -f [Color]::aqua_def.r, [Color]::aqua_def.g, [Color]::aqua_def.b
static [string] $aquamarine = "rgb({0},{1},{2})" -f [Color]::aquamarine_def.r, [Color]::aquamarine_def.g, [Color]::aquamarine_def.b
static [string] $azure = "rgb({0},{1},{2})" -f [Color]::azure_def.r, [Color]::azure_def.g, [Color]::azure_def.b
static [string] $beige = "rgb({0},{1},{2})" -f [Color]::beige_def.r, [Color]::beige_def.g, [Color]::beige_def.b
static [string] $bisque = "rgb({0},{1},{2})" -f [Color]::bisque_def.r, [Color]::bisque_def.g, [Color]::bisque_def.b
static [string] $black = "rgb({0},{1},{2})" -f [Color]::black_def.r, [Color]::black_def.g, [Color]::black_def.b
static [string] $blanchedalmond = "rgb({0},{1},{2})" -f [Color]::blanchedalmond_def.r, [Color]::blanchedalmond_def.g, [Color]::blanchedalmond_def.b
static [string] $blue = "rgb({0},{1},{2})" -f [Color]::blue_def.r, [Color]::blue_def.g, [Color]::blue_def.b
static [string] $blueviolet = "rgb({0},{1},{2})" -f [Color]::blueviolet_def.r, [Color]::blueviolet_def.g, [Color]::blueviolet_def.b
static [string] $brown = "rgb({0},{1},{2})" -f [Color]::brown_def.r, [Color]::brown_def.g, [Color]::brown_def.b
static [string] $burlywood = "rgb({0},{1},{2})" -f [Color]::burlywood_def.r, [Color]::burlywood_def.g, [Color]::burlywood_def.b
static [string] $cadetblue = "rgb({0},{1},{2})" -f [Color]::cadetblue_def.r, [Color]::cadetblue_def.g, [Color]::cadetblue_def.b
static [string] $chartreuse = "rgb({0},{1},{2})" -f [Color]::chartreuse_def.r, [Color]::chartreuse_def.g, [Color]::chartreuse_def.b
static [string] $chocolate = "rgb({0},{1},{2})" -f [Color]::chocolate_def.r, [Color]::chocolate_def.g, [Color]::chocolate_def.b
static [string] $coral = "rgb({0},{1},{2})" -f [Color]::coral_def.r, [Color]::coral_def.g, [Color]::coral_def.b
static [string] $cornflowerblue = "rgb({0},{1},{2})" -f [Color]::cornflowerblue_def.r, [Color]::cornflowerblue_def.g, [Color]::cornflowerblue_def.b
static [string] $cornsilk = "rgb({0},{1},{2})" -f [Color]::cornsilk_def.r, [Color]::cornsilk_def.g, [Color]::cornsilk_def.b
static [string] $crimson = "rgb({0},{1},{2})" -f [Color]::crimson_def.r, [Color]::crimson_def.g, [Color]::crimson_def.b
static [string] $cyan = "rgb({0},{1},{2})" -f [Color]::cyan_def.r, [Color]::cyan_def.g, [Color]::cyan_def.b
static [string] $darkblue = "rgb({0},{1},{2})" -f [Color]::darkblue_def.r, [Color]::darkblue_def.g, [Color]::darkblue_def.b
static [string] $darkcyan = "rgb({0},{1},{2})" -f [Color]::darkcyan_def.r, [Color]::darkcyan_def.g, [Color]::darkcyan_def.b
static [string] $darkgoldenrod = "rgb({0},{1},{2})" -f [Color]::darkgoldenrod_def.r, [Color]::darkgoldenrod_def.g, [Color]::darkgoldenrod_def.b
static [string] $darkgray = "rgb({0},{1},{2})" -f [Color]::darkgray_def.r, [Color]::darkgray_def.g, [Color]::darkgray_def.b
static [string] $darkgreen = "rgb({0},{1},{2})" -f [Color]::darkgreen_def.r, [Color]::darkgreen_def.g, [Color]::darkgreen_def.b
static [string] $darkgrey = "rgb({0},{1},{2})" -f [Color]::darkgrey_def.r, [Color]::darkgrey_def.g, [Color]::darkgrey_def.b
static [string] $darkkhaki = "rgb({0},{1},{2})" -f [Color]::darkkhaki_def.r, [Color]::darkkhaki_def.g, [Color]::darkkhaki_def.b
static [string] $darkmagenta = "rgb({0},{1},{2})" -f [Color]::darkmagenta_def.r, [Color]::darkmagenta_def.g, [Color]::darkmagenta_def.b
static [string] $darkolivegreen = "rgb({0},{1},{2})" -f [Color]::darkolivegreen_def.r, [Color]::darkolivegreen_def.g, [Color]::darkolivegreen_def.b
static [string] $darkorange = "rgb({0},{1},{2})" -f [Color]::darkorange_def.r, [Color]::darkorange_def.g, [Color]::darkorange_def.b
static [string] $darkorchid = "rgb({0},{1},{2})" -f [Color]::darkorchid_def.r, [Color]::darkorchid_def.g, [Color]::darkorchid_def.b
static [string] $darkred = "rgb({0},{1},{2})" -f [Color]::darkred_def.r, [Color]::darkred_def.g, [Color]::darkred_def.b
static [string] $darksalmon = "rgb({0},{1},{2})" -f [Color]::darksalmon_def.r, [Color]::darksalmon_def.g, [Color]::darksalmon_def.b
static [string] $darkseagreen = "rgb({0},{1},{2})" -f [Color]::darkseagreen_def.r, [Color]::darkseagreen_def.g, [Color]::darkseagreen_def.b
static [string] $darkslateblue = "rgb({0},{1},{2})" -f [Color]::darkslateblue_def.r, [Color]::darkslateblue_def.g, [Color]::darkslateblue_def.b
static [string] $darkslategray = "rgb({0},{1},{2})" -f [Color]::darkslategray_def.r, [Color]::darkslategray_def.g, [Color]::darkslategray_def.b
static [string] $darkslategrey = "rgb({0},{1},{2})" -f [Color]::darkslategrey_def.r, [Color]::darkslategrey_def.g, [Color]::darkslategrey_def.b
static [string] $darkturquoise = "rgb({0},{1},{2})" -f [Color]::darkturquoise_def.r, [Color]::darkturquoise_def.g, [Color]::darkturquoise_def.b
static [string] $darkviolet = "rgb({0},{1},{2})" -f [Color]::darkviolet_def.r, [Color]::darkviolet_def.g, [Color]::darkviolet_def.b
static [string] $deeppink = "rgb({0},{1},{2})" -f [Color]::deeppink_def.r, [Color]::deeppink_def.g, [Color]::deeppink_def.b
static [string] $deepskyblue = "rgb({0},{1},{2})" -f [Color]::deepskyblue_def.r, [Color]::deepskyblue_def.g, [Color]::deepskyblue_def.b
static [string] $dimgray = "rgb({0},{1},{2})" -f [Color]::dimgray_def.r, [Color]::dimgray_def.g, [Color]::dimgray_def.b
static [string] $dimgrey = "rgb({0},{1},{2})" -f [Color]::dimgrey_def.r, [Color]::dimgrey_def.g, [Color]::dimgrey_def.b
static [string] $dodgerblue = "rgb({0},{1},{2})" -f [Color]::dodgerblue_def.r, [Color]::dodgerblue_def.g, [Color]::dodgerblue_def.b
static [string] $firebrick = "rgb({0},{1},{2})" -f [Color]::firebrick_def.r, [Color]::firebrick_def.g, [Color]::firebrick_def.b
static [string] $floralwhite = "rgb({0},{1},{2})" -f [Color]::floralwhite_def.r, [Color]::floralwhite_def.g, [Color]::floralwhite_def.b
static [string] $forestgreen = "rgb({0},{1},{2})" -f [Color]::forestgreen_def.r, [Color]::forestgreen_def.g, [Color]::forestgreen_def.b
static [string] $fuchsia = "rgb({0},{1},{2})" -f [Color]::fuchsia_def.r, [Color]::fuchsia_def.g, [Color]::fuchsia_def.b
static [string] $gainsboro = "rgb({0},{1},{2})" -f [Color]::gainsboro_def.r, [Color]::gainsboro_def.g, [Color]::gainsboro_def.b
static [string] $ghostwhite = "rgb({0},{1},{2})" -f [Color]::ghostwhite_def.r, [Color]::ghostwhite_def.g, [Color]::ghostwhite_def.b
static [string] $gold = "rgb({0},{1},{2})" -f [Color]::gold_def.r, [Color]::gold_def.g, [Color]::gold_def.b
static [string] $goldenrod = "rgb({0},{1},{2})" -f [Color]::goldenrod_def.r, [Color]::goldenrod_def.g, [Color]::goldenrod_def.b
static [string] $gray = "rgb({0},{1},{2})" -f [Color]::gray_def.r, [Color]::gray_def.g, [Color]::gray_def.b
static [string] $green = "rgb({0},{1},{2})" -f [Color]::green_def.r, [Color]::green_def.g, [Color]::green_def.b
static [string] $greenyellow = "rgb({0},{1},{2})" -f [Color]::greenyellow_def.r, [Color]::greenyellow_def.g, [Color]::greenyellow_def.b
static [string] $grey = "rgb({0},{1},{2})" -f [Color]::grey_def.r, [Color]::grey_def.g, [Color]::grey_def.b
static [string] $honeydew = "rgb({0},{1},{2})" -f [Color]::honeydew_def.r, [Color]::honeydew_def.g, [Color]::honeydew_def.b
static [string] $hotpink = "rgb({0},{1},{2})" -f [Color]::hotpink_def.r, [Color]::hotpink_def.g, [Color]::hotpink_def.b
static [string] $indianred = "rgb({0},{1},{2})" -f [Color]::indianred_def.r, [Color]::indianred_def.g, [Color]::indianred_def.b
static [string] $indigo = "rgb({0},{1},{2})" -f [Color]::indigo_def.r, [Color]::indigo_def.g, [Color]::indigo_def.b
static [string] $ivory = "rgb({0},{1},{2})" -f [Color]::ivory_def.r, [Color]::ivory_def.g, [Color]::ivory_def.b
static [string] $khaki = "rgb({0},{1},{2})" -f [Color]::khaki_def.r, [Color]::khaki_def.g, [Color]::khaki_def.b
static [string] $lavender = "rgb({0},{1},{2})" -f [Color]::lavender_def.r, [Color]::lavender_def.g, [Color]::lavender_def.b
static [string] $lavenderblush = "rgb({0},{1},{2})" -f [Color]::lavenderblush_def.r, [Color]::lavenderblush_def.g, [Color]::lavenderblush_def.b
static [string] $lawngreen = "rgb({0},{1},{2})" -f [Color]::lawngreen_def.r, [Color]::lawngreen_def.g, [Color]::lawngreen_def.b
static [string] $lemonchiffon = "rgb({0},{1},{2})" -f [Color]::lemonchiffon_def.r, [Color]::lemonchiffon_def.g, [Color]::lemonchiffon_def.b
static [string] $lightblue = "rgb({0},{1},{2})" -f [Color]::lightblue_def.r, [Color]::lightblue_def.g, [Color]::lightblue_def.b
static [string] $lightcoral = "rgb({0},{1},{2})" -f [Color]::lightcoral_def.r, [Color]::lightcoral_def.g, [Color]::lightcoral_def.b
static [string] $lightcyan = "rgb({0},{1},{2})" -f [Color]::lightcyan_def.r, [Color]::lightcyan_def.g, [Color]::lightcyan_def.b
static [string] $lightgoldenrodyellow = "rgb({0},{1},{2})" -f [Color]::lightgoldenrodyellow_def.r, [Color]::lightgoldenrodyellow_def.g, [Color]::lightgoldenrodyellow_def.b
static [string] $lightgray = "rgb({0},{1},{2})" -f [Color]::lightgray_def.r, [Color]::lightgray_def.g, [Color]::lightgray_def.b
static [string] $lightgreen = "rgb({0},{1},{2})" -f [Color]::lightgreen_def.r, [Color]::lightgreen_def.g, [Color]::lightgreen_def.b
static [string] $lightgrey = "rgb({0},{1},{2})" -f [Color]::lightgrey_def.r, [Color]::lightgrey_def.g, [Color]::lightgrey_def.b
static [string] $lightpink = "rgb({0},{1},{2})" -f [Color]::lightpink_def.r, [Color]::lightpink_def.g, [Color]::lightpink_def.b
static [string] $lightsalmon = "rgb({0},{1},{2})" -f [Color]::lightsalmon_def.r, [Color]::lightsalmon_def.g, [Color]::lightsalmon_def.b
static [string] $lightseagreen = "rgb({0},{1},{2})" -f [Color]::lightseagreen_def.r, [Color]::lightseagreen_def.g, [Color]::lightseagreen_def.b
static [string] $lightskyblue = "rgb({0},{1},{2})" -f [Color]::lightskyblue_def.r, [Color]::lightskyblue_def.g, [Color]::lightskyblue_def.b
static [string] $lightslategray = "rgb({0},{1},{2})" -f [Color]::lightslategray_def.r, [Color]::lightslategray_def.g, [Color]::lightslategray_def.b
static [string] $lightslategrey = "rgb({0},{1},{2})" -f [Color]::lightslategrey_def.r, [Color]::lightslategrey_def.g, [Color]::lightslategrey_def.b
static [string] $lightsteelblue = "rgb({0},{1},{2})" -f [Color]::lightsteelblue_def.r, [Color]::lightsteelblue_def.g, [Color]::lightsteelblue_def.b
static [string] $lightyellow = "rgb({0},{1},{2})" -f [Color]::lightyellow_def.r, [Color]::lightyellow_def.g, [Color]::lightyellow_def.b
static [string] $lime = "rgb({0},{1},{2})" -f [Color]::lime_def.r, [Color]::lime_def.g, [Color]::lime_def.b
static [string] $limegreen = "rgb({0},{1},{2})" -f [Color]::limegreen_def.r, [Color]::limegreen_def.g, [Color]::limegreen_def.b
static [string] $linen = "rgb({0},{1},{2})" -f [Color]::linen_def.r, [Color]::linen_def.g, [Color]::linen_def.b
static [string] $magenta = "rgb({0},{1},{2})" -f [Color]::magenta_def.r, [Color]::magenta_def.g, [Color]::magenta_def.b
static [string] $maroon = "rgb({0},{1},{2})" -f [Color]::maroon_def.r, [Color]::maroon_def.g, [Color]::maroon_def.b
static [string] $mediumaquamarine = "rgb({0},{1},{2})" -f [Color]::mediumaquamarine_def.r, [Color]::mediumaquamarine_def.g, [Color]::mediumaquamarine_def.b
static [string] $mediumblue = "rgb({0},{1},{2})" -f [Color]::mediumblue_def.r, [Color]::mediumblue_def.g, [Color]::mediumblue_def.b
static [string] $mediumorchid = "rgb({0},{1},{2})" -f [Color]::mediumorchid_def.r, [Color]::mediumorchid_def.g, [Color]::mediumorchid_def.b
static [string] $mediumpurple = "rgb({0},{1},{2})" -f [Color]::mediumpurple_def.r, [Color]::mediumpurple_def.g, [Color]::mediumpurple_def.b
static [string] $mediumseagreen = "rgb({0},{1},{2})" -f [Color]::mediumseagreen_def.r, [Color]::mediumseagreen_def.g, [Color]::mediumseagreen_def.b
static [string] $mediumslateblue = "rgb({0},{1},{2})" -f [Color]::mediumslateblue_def.r, [Color]::mediumslateblue_def.g, [Color]::mediumslateblue_def.b
static [string] $mediumspringgreen = "rgb({0},{1},{2})" -f [Color]::mediumspringgreen_def.r, [Color]::mediumspringgreen_def.g, [Color]::mediumspringgreen_def.b
static [string] $mediumturquoise = "rgb({0},{1},{2})" -f [Color]::mediumturquoise_def.r, [Color]::mediumturquoise_def.g, [Color]::mediumturquoise_def.b
static [string] $mediumvioletred = "rgb({0},{1},{2})" -f [Color]::mediumvioletred_def.r, [Color]::mediumvioletred_def.g, [Color]::mediumvioletred_def.b
static [string] $midnightblue = "rgb({0},{1},{2})" -f [Color]::midnightblue_def.r, [Color]::midnightblue_def.g, [Color]::midnightblue_def.b
static [string] $mintcream = "rgb({0},{1},{2})" -f [Color]::mintcream_def.r, [Color]::mintcream_def.g, [Color]::mintcream_def.b
static [string] $mistyrose = "rgb({0},{1},{2})" -f [Color]::mistyrose_def.r, [Color]::mistyrose_def.g, [Color]::mistyrose_def.b
static [string] $moccasin = "rgb({0},{1},{2})" -f [Color]::moccasin_def.r, [Color]::moccasin_def.g, [Color]::moccasin_def.b
static [string] $navajowhite = "rgb({0},{1},{2})" -f [Color]::navajowhite_def.r, [Color]::navajowhite_def.g, [Color]::navajowhite_def.b
static [string] $navy = "rgb({0},{1},{2})" -f [Color]::navy_def.r, [Color]::navy_def.g, [Color]::navy_def.b
static [string] $oldlace = "rgb({0},{1},{2})" -f [Color]::oldlace_def.r, [Color]::oldlace_def.g, [Color]::oldlace_def.b
static [string] $olive = "rgb({0},{1},{2})" -f [Color]::olive_def.r, [Color]::olive_def.g, [Color]::olive_def.b
static [string] $olivedrab = "rgb({0},{1},{2})" -f [Color]::olivedrab_def.r, [Color]::olivedrab_def.g, [Color]::olivedrab_def.b
static [string] $orange = "rgb({0},{1},{2})" -f [Color]::orange_def.r, [Color]::orange_def.g, [Color]::orange_def.b
static [string] $orangered = "rgb({0},{1},{2})" -f [Color]::orangered_def.r, [Color]::orangered_def.g, [Color]::orangered_def.b
static [string] $orchid = "rgb({0},{1},{2})" -f [Color]::orchid_def.r, [Color]::orchid_def.g, [Color]::orchid_def.b
static [string] $palegoldenrod = "rgb({0},{1},{2})" -f [Color]::palegoldenrod_def.r, [Color]::palegoldenrod_def.g, [Color]::palegoldenrod_def.b
static [string] $palegreen = "rgb({0},{1},{2})" -f [Color]::palegreen_def.r, [Color]::palegreen_def.g, [Color]::palegreen_def.b
static [string] $paleturquoise = "rgb({0},{1},{2})" -f [Color]::paleturquoise_def.r, [Color]::paleturquoise_def.g, [Color]::paleturquoise_def.b
static [string] $palevioletred = "rgb({0},{1},{2})" -f [Color]::palevioletred_def.r, [Color]::palevioletred_def.g, [Color]::palevioletred_def.b
static [string] $papayawhip = "rgb({0},{1},{2})" -f [Color]::papayawhip_def.r, [Color]::papayawhip_def.g, [Color]::papayawhip_def.b
static [string] $peachpuff = "rgb({0},{1},{2})" -f [Color]::peachpuff_def.r, [Color]::peachpuff_def.g, [Color]::peachpuff_def.b
static [string] $peru = "rgb({0},{1},{2})" -f [Color]::peru_def.r, [Color]::peru_def.g, [Color]::peru_def.b
static [string] $pink = "rgb({0},{1},{2})" -f [Color]::pink_def.r, [Color]::pink_def.g, [Color]::pink_def.b
static [string] $plum = "rgb({0},{1},{2})" -f [Color]::plum_def.r, [Color]::plum_def.g, [Color]::plum_def.b
static [string] $powderblue = "rgb({0},{1},{2})" -f [Color]::powderblue_def.r, [Color]::powderblue_def.g, [Color]::powderblue_def.b
static [string] $purple = "rgb({0},{1},{2})" -f [Color]::purple_def.r, [Color]::purple_def.g, [Color]::purple_def.b
static [string] $red = "rgb({0},{1},{2})" -f [Color]::red_def.r, [Color]::red_def.g, [Color]::red_def.b
static [string] $rosybrown = "rgb({0},{1},{2})" -f [Color]::rosybrown_def.r, [Color]::rosybrown_def.g, [Color]::rosybrown_def.b
static [string] $royalblue = "rgb({0},{1},{2})" -f [Color]::royalblue_def.r, [Color]::royalblue_def.g, [Color]::royalblue_def.b
static [string] $saddlebrown = "rgb({0},{1},{2})" -f [Color]::saddlebrown_def.r, [Color]::saddlebrown_def.g, [Color]::saddlebrown_def.b
static [string] $salmon = "rgb({0},{1},{2})" -f [Color]::salmon_def.r, [Color]::salmon_def.g, [Color]::salmon_def.b
static [string] $sandybrown = "rgb({0},{1},{2})" -f [Color]::sandybrown_def.r, [Color]::sandybrown_def.g, [Color]::sandybrown_def.b
static [string] $seagreen = "rgb({0},{1},{2})" -f [Color]::seagreen_def.r, [Color]::seagreen_def.g, [Color]::seagreen_def.b
static [string] $seashell = "rgb({0},{1},{2})" -f [Color]::seashell_def.r, [Color]::seashell_def.g, [Color]::seashell_def.b
static [string] $sienna = "rgb({0},{1},{2})" -f [Color]::sienna_def.r, [Color]::sienna_def.g, [Color]::sienna_def.b
static [string] $silver = "rgb({0},{1},{2})" -f [Color]::silver_def.r, [Color]::silver_def.g, [Color]::silver_def.b
static [string] $skyblue = "rgb({0},{1},{2})" -f [Color]::skyblue_def.r, [Color]::skyblue_def.g, [Color]::skyblue_def.b
static [string] $slateblue = "rgb({0},{1},{2})" -f [Color]::slateblue_def.r, [Color]::slateblue_def.g, [Color]::slateblue_def.b
static [string] $slategray = "rgb({0},{1},{2})" -f [Color]::slategray_def.r, [Color]::slategray_def.g, [Color]::slategray_def.b
static [string] $slategrey = "rgb({0},{1},{2})" -f [Color]::slategrey_def.r, [Color]::slategrey_def.g, [Color]::slategrey_def.b
static [string] $snow = "rgb({0},{1},{2})" -f [Color]::snow_def.r, [Color]::snow_def.g, [Color]::snow_def.b
static [string] $springgreen = "rgb({0},{1},{2})" -f [Color]::springgreen_def.r, [Color]::springgreen_def.g, [Color]::springgreen_def.b
static [string] $steelblue = "rgb({0},{1},{2})" -f [Color]::steelblue_def.r, [Color]::steelblue_def.g, [Color]::steelblue_def.b
static [string] $tan = "rgb({0},{1},{2})" -f [Color]::tan_def.r, [Color]::tan_def.g, [Color]::tan_def.b
static [string] $teal = "rgb({0},{1},{2})" -f [Color]::teal_def.r, [Color]::teal_def.g, [Color]::teal_def.b
static [string] $thistle = "rgb({0},{1},{2})" -f [Color]::thistle_def.r, [Color]::thistle_def.g, [Color]::thistle_def.b
static [string] $tomato = "rgb({0},{1},{2})" -f [Color]::tomato_def.r, [Color]::tomato_def.g, [Color]::tomato_def.b
static [string] $turquoise = "rgb({0},{1},{2})" -f [Color]::turquoise_def.r, [Color]::turquoise_def.g, [Color]::turquoise_def.b
static [string] $violet = "rgb({0},{1},{2})" -f [Color]::violet_def.r, [Color]::violet_def.g, [Color]::violet_def.b
static [string] $wheat = "rgb({0},{1},{2})" -f [Color]::wheat_def.r, [Color]::wheat_def.g, [Color]::wheat_def.b
static [string] $white = "rgb({0},{1},{2})" -f [Color]::white_def.r, [Color]::white_def.g, [Color]::white_def.b
static [string] $whitesmoke = "rgb({0},{1},{2})" -f [Color]::whitesmoke_def.r, [Color]::whitesmoke_def.g, [Color]::whitesmoke_def.b
static [string] $yellow = "rgb({0},{1},{2})" -f [Color]::yellow_def.r, [Color]::yellow_def.g, [Color]::yellow_def.b
static [string] $yellowgreen = "rgb({0},{1},{2})" -f [Color]::yellowgreen_def.r, [Color]::yellowgreen_def.g, [Color]::yellowgreen_def.b

static [string[]]$colornames = ([Color].GetProperties()  | Where-Object { $_.PropertyType.ToString() -EQ 'System.String'} | Select -Expand Name)

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
    return [Color]::hslcalc($r, $g, $b, 9) ;
}

static [string] hsla([int]$r,[int]$g,[int]$b, [double] $a){ 
    return [Color]::hslcalc($r, $g, $b, $a) ;
}

    static [string] rgb([int]$r,[int]$g,[int]$b){
        return "rgb({0},{1},{2})" -f $r,$g,$b
    }
    static [string] rgba([int]$r,[int]$g,[int]$b,[double]$a){
        return "rgba({0},{1},{2},{3})" -f $r,$g,$b,$a
    }
}


#region dataSet
Class dataSet {
    [System.Collections.ArrayList] $data = @()
    [Array]$label

    dataSet(){
       
    }

    dataset([Array]$Data,[Array]$Label){
        
        if ( @( $Label ).Count -eq 1 ) {
            $this.SetLabel($Label)
        }
        else {
            foreach($l in $Label){
                $this.AddLabel($l)
            }
        }
        foreach($d in $data){
            $this.AddData($d)
        }
        
        
    }

    [void]AddLabel([Array]$Label){
        foreach($L in $Label){
            $null = $this.Label.Add($L)
        }
    }
    
    [void]SetLabel([String]$Label){
        $this.label = $Label
    }
    

    [void]AddData([Array]$Data){
        foreach($D in $Data){
            $null = $this.data.Add($d)
        }
    }
}

Class datasetbar : dataset {
    [String] $xAxisID
    [String] $yAxisID
    [string]  $backgroundColor
    [string]  $borderColor
    [int]    $borderWidth = 1
    [String] $borderSkipped
    [string]  $hoverBackgroundColor
    [string]  $hoverBorderColor
    [int]    $hoverBorderWidth

    datasetbar(){
       
    }

    datasetbar([Array]$Data,[Array]$Label){
        
        $this.SetLabel($Label)
        $this.AddData($Data)
        
    }
}

Class datasetPolarArea : dataset {
    [Array]  $backgroundColor
    [Array]  $borderColor
    [int]    $borderWidth = 1
    [String] $borderSkipped
    [Array]  $hoverBackgroundColor
    [Array]  $hoverBorderColor
    [int]    $hoverBorderWidth

    datasetPolarArea(){
    
    }

    datasetPolarArea([Array]$Data,[Array]$Label){
        if ( @( $Label ).Count -gt 1 ) {
            $this.AddLabel($Label)
        }
        else {
            $this.SetLabel( @( $Label)[0] )
        }
        $this.AddData($Data)
        
    }
}


Class datasetline : dataset{
    #See https://www.chartjs.org/docs/latest/charts/line.html
    #[String] $xAxisID
    #[String] $yAxisID

    [String]  $backgroundColor
    [String]  $borderColor
    [int]    $borderWidth = 1
    [int[]]    $borderDash = 0
    [int]    $borderDashOffSet = 0

    [ValidateSet("butt","round","square")]
    [String]    $borderCapStyle

    [ValidateSet("bevel","round","miter")]
    [String]    $borderJoinStyle

    [ValidateSet("default","monotone")]
    [String] $cubicInterpolationMode = "default"
    [Bool] $fill = $false
    [double]$lineTension = 0.5 #Stepped line should not be present, for this one to work.
    
    $pointBackgroundColor = "rgb(255,255,255)"
    $pointBorderColor = "rgb(0,0,0)"
    [Int[]]$pointBorderWidth = 1
    [Int]$pointRadius = 4
    [ValidateSet("circle","cross","crossRot","dash","line","rect","rectRounded","rectRot","star","triangle")]
    $pointStyle = "circle"

    [int[]]$pointRotation
    [int[]]$pointHitRadius

    [String]  $PointHoverBackgroundColor
    [String]  $pointHoverBorderColor
    [int]    $pointHoverBorderWidth
    [int] $pointHoverRadius
    [bool]$showLine = $true
    [bool]$spanGaps

    #[ValidateSet("true","false","before","after")]
    #[String] $steppedLine = 'false' #Had to remove it, otherwise lines could not be rounded. It would ignore the $LineTension settings, even when set to false

    datasetline(){

    }

    datasetline([Array]$Data,[String]$Label){
        Write-verbose "[DatasetLine][Instanciation]Start"
        $this.SetLabel($Label)
        $this.AddData($Data)
        Write-verbose "[DatasetLine][Instanciation]End"
    }

    SetLineColor([String]$Color,[Bool]$Fill){
        Write-verbose "[DatasetLine][SetLineColor] Start"
        $this.borderColor = $Color
        $this.backgroundColor = $Color
        if($Fill){
           $this.SetLineBackGroundColor($Color)
        }
        Write-verbose "[DatasetLine][SetLineColor] End"
    }

    SetLineBackGroundColor(){
        Write-verbose "[DatasetLine][SetLineBackGroundColor] Start"
        #Without any color parameter, this will take the existing line color, and simply add 0.4 of alpha to it for the background color
        if(!($this.borderColor)){
            $t = $this.borderColor
            $this.fill = $true
            $t = $t.replace("rgb","rgba")
            $backgroundC = $t.replace(")",",0.4)")
            $this.backgroundColor = $backgroundC
        }
        Write-verbose "[DatasetLine][SetLineBackGroundColor] End"
    }

    SetLineBackGroundColor([String]$Color){
        #this will take the color, and add 0.4 of alpha to it for the background color
        Write-verbose "[DatasetLine][SetLineBackGroundColor] Start"
        $this.fill = $true
        $t = $Color
        $t = $t.replace("rgb","rgba")
        $backgroundC = $t.replace(")",",0.4)")
        $this.backgroundColor = $backgroundC
        Write-verbose "[DatasetLine][SetLineBackGroundColor] End"
    }
}


Class datasetpie : dataset {


    [System.Collections.ArrayList]$backgroundColor
    [String]$borderColor = "white"
    [int]$borderWidth = 1
    [System.Collections.ArrayList]$hoverBackgroundColor
    [Color]$HoverBorderColor
    [int]$HoverBorderWidth

    datasetpie(){

    }

    datasetpie([Array]$Data,[String]$ChartLabel){
        Write-verbose "[DatasetPie][Instanciation]Start"
        $this.SetLabel($ChartLabel)
        $this.AddData($Data)
        Write-verbose "[DatasetPie][Instanciation]End"
    }

    AddBackGroundColor($Color){
        if($null -eq $this.backgroundColor){
            $this.backgroundColor = @()
        }
        $this.backgroundColor.Add($Color)
    }

    AddBackGroundColor([Array]$Colors){
        
        foreach($c in $Colors){
            $this.AddBackGroundColor($c)
        }
        
    }

    AddHoverBackGroundColor($Color){
        if($null -eq $this.HoverbackgroundColor){
            $this.HoverbackgroundColor = @()
        }
        $this.HoverbackgroundColor.Add($Color)
    }

    AddHoverBackGroundColor([Array]$Colors){
        foreach($c in $Colors){
            $this.AddHoverBackGroundColor($c)
        }
        
    }

}

Class datasetDoughnut : dataset {

    [System.Collections.ArrayList]$backgroundColor
    [String]$borderColor = "white"
    [int]$borderWidth = 1
    [System.Collections.ArrayList]$hoverBackgroundColor
    [Color]$HoverBorderColor
    [int]$HoverBorderWidth

    datasetDoughnut(){

    }

    datasetDoughnut([Array]$Data,[String]$ChartLabel){
        Write-verbose "[DatasetDoughnut][Instanciation]Start"
        $this.SetLabel($ChartLabel)
        $this.AddData($Data)
        Write-verbose "[DatasetDoughnut][Instanciation]End"
    }

    AddBackGroundColor($Color){
        if($null -eq $this.backgroundColor){
            $this.backgroundColor = @()
        }
        $this.backgroundColor.Add($Color)
    }

    AddBackGroundColor([Array]$Colors){
        
        foreach($c in $Colors){
            $this.AddBackGroundColor($c)
        }
        
    }

    AddHoverBackGroundColor($Color){
        if($null -eq $this.HoverbackgroundColor){
            $this.HoverbackgroundColor = @()
        }
        $this.HoverbackgroundColor.Add($Color)
    }

    AddHoverBackGroundColor([Array]$Colors){
        foreach($c in $Colors){
            $this.AddHoverBackGroundColor($c)
        }
        
    }

}

#endregion


#region Configuration&Options

Class scales {
    [System.Collections.ArrayList]$yAxes = @()
    [System.Collections.ArrayList]$xAxes = @("")

    scales(){

        $null =$this.yAxes.Add(@{"ticks"=@{"beginAtZero"=$true}})
    }
}

Class ChartTitle {
    [Bool]$display=$false
    [String]$text
}

Class ChartAnimation {
    $OnComplete = 'void(0)'
}

Class ChartOptions  {
    [int]$barPercentage = 0.9
    [Int]$categoryPercentage = 0.8
    [bool]$responsive = $false
    [String]$barThickness
    [Int]$maxBarThickness
    [Bool] $offsetGridLines = $true
    [scales]$scales = [scales]::New()
    [ChartTitle]$title = [ChartTitle]::New()
    [ChartAnimation]$Animation = [ChartAnimation]::New()

    <#
        elements: {
						rectangle: {
							borderWidth: 2,
						}
					},
					responsive: true,
					legend: {
						position: 'right',
					},
					title: {
						display: true,
						text: 'Chart.js Horizontal Bar Chart'
					}
    #>
}

#endregion

#region Charts

Class BarChartOptions : ChartOptions {

}

Class horizontalBarChartOptions : ChartOptions {

}

Class PieChartOptions : ChartOptions {

}

Class LineChartOptions : ChartOptions {
    [Bool] $showLines = $True
    [Bool] $spanGaps = $False
}

Class DoughnutChartOptions : ChartOptions {
    
}

Class RadarChartOptions : ChartOptions {
    [scales]$scales = $null
}

Class polarAreaChartOptions : ChartOptions {
    [scales]$scales = $null
}

Class ChartData {
    [System.Collections.ArrayList] $labels = @()
    [System.Collections.ArrayList] $datasets = @()
    #[DataSet[]] $datasets = [dataSet]::New()

    ChartData(){
        #$this.datasets = [dataSet]::New()
        $this.datasets.add([dataSet]::New())
    }

    AddDataSet([DataSet]$Dataset){
        #$this.datasets += $Dataset
        $this.datasets.Add($Dataset)
    }

    SetLabels([Array]$Labels){
        Foreach($l in $Labels){

            $Null = $this.labels.Add($l)
        }
    }

}

Class BarData : ChartData {
    
    
}

Class Chart {
    [ChartType]$type
    [ChartData]$data
    [ChartOptions]$options
    Hidden [String]$definition

    Chart(){
        $Currenttype = $this.GetType()

        if ($Currenttype -eq [Chart])
        {
            throw("Class $($Currenttype) must be inherited")
        }
    }

    SetData([ChartData]$Data){
        $this.Data = $Data
    }

    SetOptions([ChartOptions]$Options){
        $this.Options = $Options
    }

    #Is this actually used? Could be removed?
    hidden [void] BuildDefinition(){
        $This.GetDefinitionStart()
        $This.GetDefinitionBody()
        $This.GetDefinitionEnd()
        #Do stuff with $DEfinition
    }

    Hidden [String]GetDefinitionStart([String]$CanvasID){
<#

$Start = @"
var ctx = document.getElementById("$($CanvasID)").getContext('2d');
var myChart = new Chart(ctx, 
"@
#>
$Start = "var ctx = document.getElementById(`"$($CanvasID)`").getContext('2d');"
$Start = $Start + [Environment]::NewLine
$Start = $Start + "var myChart = new Chart(ctx, "
    return $Start
    }

    Hidden [String]GetDefinitionEnd(){
        Return ");"
    }

    Hidden [String]GetDefinitionBody(){
        
        ##Graph Structure
            #Type
            #Data
                #Labels[]
                #DataSets[]
                    #Label
                    #Data[]
                    #BackGroundColor[]
                    #BorderColor[]
                    #BorderWidth int
            #Options
                #Scales
                    #yAxes []
                        #Ticks
                            #beginAtZero [bool]
                            
        $Body = $this | select @{N='type';E={$_.type.ToString()}},Data,Options  | convertto-Json -Depth 6 -Compress
        $BodyCleaned =  Clear-WhiteSpace $Body
        Return $BodyCleaned
    }

    [String] GetDefinition([String]$CanvasID){
        
        $FullDefintion = [System.Text.StringBuilder]::new()
        $FullDefintion.Append($this.GetDefinitionStart([String]$CanvasID))
        $FullDefintion.AppendLine($this.GetDefinitionBody())
        $FullDefintion.AppendLine($this.GetDefinitionEnd())
        $FullDefintionCleaned = Clear-WhiteSpace $FullDefintion
        return $FullDefintionCleaned
    }

    [String] GetDefinition([String]$CanvasID,[Bool]$ToBase64){
        
        $FullDefintion = [System.Text.StringBuilder]::new()
        $FullDefintion.Append($this.GetDefinitionStart([String]$CanvasID))
        $FullDefintion.AppendLine($this.GetDefinitionBody())
        $FullDefintion.AppendLine($this.GetDefinitionEnd())
        $FullDefintion.AppendLine("function RemoveCanvasAndCreateBase64Image (){")
        $FullDefintion.AppendLine("var base64 = this.toBase64Image();")
        $FullDefintion.AppendLine("var element = this.canvas;")
        $FullDefintion.AppendLine("var parent = element.parentNode;")
        $FullDefintion.AppendLine("var img = document.createElement('img');")
        $FullDefintion.AppendLine("img.src = base64;")
        $FullDefintion.AppendLine("img.name = element.id;")
        $FullDefintion.AppendLine("element.before(img);")
        $FullDefintion.AppendLine("parent.removeChild(element);")
        $FullDefintion.AppendLine("parent.removeChild(element);")
        $FullDefintion.AppendLine("};")
        <#
        //var scripttags = document.getElementsByTagName('script');
        //var scripttags = document.getElementsByTagName('script');
        //for (i=0;i<scripttags.length;){
        //    var parent = scripttags[i].parentNode;
        //    parent.removeChild(scripttags[i]);
        //}
        };
        #>
        $FullDefintionCleaned = Clear-WhiteSpace $FullDefintion
        return $FullDefintionCleaned
    }
}

Class BarChart : Chart{

    [ChartType] $type = [ChartType]::bar
    
    BarChart(){
        #$Type = [ChartType]::bar

    }

    BarChart([ChartData]$Data,[ChartOptions]$Options){
        $this.data = $Data
        $This.options = $Options
    }

}

Class horizontalBarChart : Chart{

    [ChartType] $type = [ChartType]::horizontalBar
    
    horizontalBarChart(){
        #$Type = [ChartType]::bar

    }

    horizontalBarChart([ChartData]$Data,[ChartOptions]$Options){
        $this.data = $Data
        $This.options = $Options
    }

}

Class LineChart : Chart{

    [ChartType] $type = [ChartType]::line
    
    LineChart(){
        #$Type = [ChartType]::bar

    }

    LineChart([ChartData]$Data,[ChartOptions]$Options){
        $this.data = $Data
        $This.options = $Options
    }

}

Class PieChart : Chart{

    [ChartType] $type = [ChartType]::pie
    
    PieChart(){
        

    }

    PieChart([ChartData]$Data,[ChartOptions]$Options){
        $this.data = $Data
        $This.options = $Options
    }

}

Class doughnutChart : Chart {
    [ChartType] $type = [ChartType]::doughnut
    
    DoughnutChart(){
        
    }

    DoughnutChart([ChartData]$Data,[ChartOptions]$Options){
        $this.data = $Data
        $This.options = $Options
    }
}

Class RadarChart : Chart{

    [ChartType] $type = [ChartType]::radar
    
    RadarChart(){
        #$Type = [ChartType]::bar

    }

    RadarChart([ChartData]$Data,[ChartOptions]$Options){
        $this.data = $Data
        $This.options = $Options
    }

}

Class polarAreaChart : Chart{

    [ChartType] $type = [ChartType]::polarArea
    
    polarAreaChart(){
        #$Type = [ChartType]::bar

    }

    polarAreaChart([ChartData]$Data,[ChartOptions]$Options){
        $this.data = $Data
        $This.options = $Options
    }

}




#endregion


