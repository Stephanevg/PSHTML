Function ConvertTo-HTMLTable {

    <#
    .SYNOPSIS
        This cmdlet is deprecated. Use ConvertTo-PSHTMLTable instead.
    
    
            
    
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        $Object,
        [String[]]$Properties
    )
    Write-Warning "ConvertTo-HTMLTable is deprecated and will be removed in a future version. Please use ConvertTo-PSHTMLTable instead"
    ConvertTo-PSHTMLTable @PSBoundParameters
}

