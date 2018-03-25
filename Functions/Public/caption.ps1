Function Get-Caption {
    Param(
        [String]
        $Content
    )

    @"
    <caption>$Content</caption>
"@


}