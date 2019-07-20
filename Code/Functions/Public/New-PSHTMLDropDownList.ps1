function New-PSHTMLDropDownList {
    <#
    .SYNOPSIS
        Generate a New Drop Down List.
    .DESCRIPTION
        Generate a New Drop Down List.
    .EXAMPLE
        PS C:\> Get-Service | New-DropDownList -Property Name
        Create a dropdownlist of service names
    .EXAMPLE
        PS C:\> $items = 'apples','oranges','tomatoes','blueberries'
        PS C:\> New-PSHTMLDropDownList -Items $Items
        Create new simple dropdownlist, array based
    .EXAMPLE
        PS C:\> $ArrayOfDropDownOptions = @()
        PS C:\> $items = 'apples','oranges','tomatoes','blueberries'
        PS C:\> Foreach ( $item in $items ) { $ArrayOfDropDownOptions += New-PSHTMLDropDownListItem -value $item -content $item }
        PS C:\> New-PSHTMLDropDownList -Items $ArrayOfDropDownOptions
        Create new simple dropdownlist, array based
    .INPUTS
        Array
    .OUTPUTS
        Output (if any)
    .NOTES
        Issue #201: https://github.com/Stephanevg/PSHTML/issues/201
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$False,ValueFromPipeline=$True)]
        [AllowNull()]
        [Array]
        $Items,
        [Parameter(Mandatory = $False)]
        [String]$Property,
        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class,
        [String]$Id,
        [Hashtable]$Attributes
    )
    
    begin {
        $Option = @()
    }
    
    process {
        If ( $null -ne $items ) {

            ## Assuming its coming from New-DropDownListItem
            If ( $items[0] -match '^<option') {
                $Option += $items
            } Else {
                If ( $Property) {
                    $Option += New-PSHTMLDropDownListItem -Items $items -Property $Property
                } Else {
                    foreach ( $item in $items ) {
                        $Option += New-PSHTMLDropDownListItem -Content $item -value $item
                    }
                }
            }
        }
    }
    
    end {
        selecttag -Content {
            $option
        } -Class $Class -Id $Id -Attributes $Attributes
    }
}
