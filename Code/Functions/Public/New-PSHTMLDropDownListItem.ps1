function New-PSHTMLDropDownListItem {
    <#
    .SYNOPSIS
        Generate a New Drop Down Items.
    .DESCRIPTION
        Generate a New Drop Down Items.
    .EXAMPLE
        PS C:\> New-PSHTMLDropDownListItem -value 'aaaa' -content 'aaaaaaa'
        Create a new dropdown option
    .INPUTS
        Inputs (if any)
    .OUTPUTS
        Output (if any)
    .NOTES
        Issue #201: https://github.com/Stephanevg/PSHTML/issues/201
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [AllowEmptyString()]
        [AllowNull()]
        $Content,
        [string]$value,
        [string]$label,
        [Switch]$Disabled,
        [Switch]$Selected,
        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class = "",
        [String]$Id,
        [AllowEmptyString()]
        [AllowNull()]
        [String]$Style,
        [String]$title,
        [Hashtable]$Attributes

    )
    
    begin {
    }
    
    process {
        option @PSBoundParameters
    }
    
    end {
    }
}