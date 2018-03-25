Function Get-Link {
    Param(
        [int]
        $span,

        [string]
        $style
    )

    [String]$String = ""
    if ($span){
        $string = "span=$span"
    }

    if ($style){
        $string = $string +  "style= $style"
    }
    @"
    <col  $string>
    
"@


}
