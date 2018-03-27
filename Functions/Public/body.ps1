Function Body {
    Param(
        [scriptblock]
        $ChildItem
    )

    @"
    <body>
"@
if($ChildItem){

    $ChildItem.Invoke() 
}

    '</body>'


}