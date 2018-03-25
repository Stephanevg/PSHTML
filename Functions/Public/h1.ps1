Function Get-H1 {
    <#
    .SYNOPSIS
    Create a h1 title in an HTML document.
    
    .EXAMPLE

    h1 
    .EXAMPLE
    h1 "woop1" -Class "class"

    .EXAMPLE
    h1 "woop2" -Class "class" -Id "MainTitle"

    .EXAMPLE
    h1 "woop3" -Class "class" -Id "MaintTitle" -Style "color:red;"

    .Notes
    Author: Stéphane van Gulick
    Version: 0.3.0
    History:
        @stephanevg;v0.1.0;03/25/2018;creation
        @stephanevg;v0.3.0;03/25/2018;Added Styles, ID, CLASS attributes functionality

    #>
    [Cmdletbinding()]
    Param(
        [Parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [AllowNull()]
        [String]
        $Content,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class="",

        [String]$Id,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Style
    )

    $Attributes = ""
    $psparams = $PSBoundParameters

    foreach ($entry in $psparams.Keys){
        switch($entry){
            "Class" {$Attributes = $Attributes + "Class=$class ";Break}
            "id" {$Attributes = $Attributes + "Id=$Id ";Break}
            "style" {$Attributes = $Attributes + "Style=`"$Style`" ";Break}
            default{}
        }
    }


if($Attributes){
    $return = @"
    <h1 $attributes>$Content</h1>
"@

}else{

    $return =     @"
    <h1>$Content</h1>
"@
}

return $return

}