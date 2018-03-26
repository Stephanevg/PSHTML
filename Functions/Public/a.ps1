Function Get-a {
    Param(

        [scriptblock]
        $ChildItem,

        [Parameter(Mandatory = $true)]
        [String]$href,

        [String]$Class,

        [String]$Id,

        [String]$Style,

        [ValidateSet("_self","_blank","_parent","_top")]
        [String]$Target = "_self"
    )

    $Attributes = ""
    foreach ($entry in $PSBoundParameters.Keys){
        switch($entry){
            "Class" {$Attributes = $Attributes + "Class=$class ";Break}
            "id" {$Attributes = $Attributes + "Id=$Id ";Break}
            "style" {$Attributes = $Attributes + "style=`"$Style`" ";Break}
            "href" {$Attributes = $Attributes + "href=$href ";Break}
            "target" {$Attributes = $Attributes + "target=`"$target`" ";Break}
            default{}
        }
    }

    if($Attributes){
        "<a $Attributes>"  
    }else{
        "<a>"
    }
if($ChildItem){

    $ChildItem.Invoke() 
}

    '</a>'


}