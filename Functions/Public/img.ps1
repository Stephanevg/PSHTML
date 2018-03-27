Function img {
    #<img src="smiley.gif" alt="Smiley face" height="42" width="42">
    Param(

        [Parameter(Mandatory=$false)]
        [String]
        $src="",

        [Parameter(Mandatory=$false)]
        [string]
        $alt = "",

        [Parameter(Mandatory=$false)]
        [string]
        $height,

        [Parameter(Mandatory=$false)]
        [string]
        $width,

        [String]$Class,

        [String]$Id,

        [String]$Style
    )


    $Attributes = ""
    foreach ($entry in $PSBoundParameters.Keys){
        switch($entry){
            "Class" {$Attributes = $Attributes + "Class=$class ";Break}
            "id" {$Attributes = $Attributes + "Id=$Id ";Break}
            "style" {$Attributes = $Attributes + "style=`"$Style`" ";Break}
            "src" {$Attributes = $Attributes + "src=$src ";Break}
            "alt" {$Attributes = $Attributes + "alt=`"$alt`" ";Break}
            "height" {$Attributes = $Attributes + "height=`"$height`" ";Break}
            "width" {$Attributes = $Attributes + "width=`"$width`" ";Break}
            default{}
        }
    }

    if($Attributes){
        $return = "<img $Attributes>"  
    }else{
        $return = "<img>"
    }

    return $return


}
