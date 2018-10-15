Function Th {
<#
    .LINK
    https://github.com/Stephanevg/PSHTML
#>
    Param(
        [String]
        $Content
    )

    @"
    <th>$Content</th>
"@


}