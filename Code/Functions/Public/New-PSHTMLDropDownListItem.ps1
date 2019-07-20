function New-PSHTMLDropDownListItem {
    <#
    .SYNOPSIS
        Generate a New Drop Down Item.
    .DESCRIPTION
        Generate a New Drop Down Item.
    .EXAMPLE
        PS C:\> Get-Service | New-PSHTMLDropDownListItem -Property Name
        Create a String representing a list of drop down items representing service name.
    .EXAMPLE
        PS C:\> $Services = Get-Service
        PS C:\> New-PSHTMLDropDownListItem -Items $Services -Property Name
        Create a String representing a list of drop down items representing service name.
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
    [CmdletBinding(DefaultParameterSetName='Classic')]
    param (
        [Parameter(Mandatory=$True,ValueFromPipeline=$True,ParameterSetName='Items')]
        [Array]$Items,
        [Parameter(Mandatory=$True,ParameterSetName='Items')]
        [string]$Property,
        [Parameter(Mandatory=$false,ParameterSetName='Classic')]
        [AllowEmptyString()]
        [AllowNull()]
        $Content = '',
        [Parameter(Mandatory=$false,ParameterSetName='Classic')]
        [AllowEmptyString()]
        [AllowNull()]
        [string]$value = '',
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
        $options = @()
    }
    
    process {

        $BoundParameters = $PSBoundParameters

        Switch ( $PSCmdlet.ParameterSetName ) {

            'Items' {

                If ( @($items | get-member -name $property).Count -eq 0  ) {
                    Throw ("Please specify an existing property. {0} does not exist ...." -f $property)
                } 

                Foreach ( $item in $items ) {

                    $Content = ($Item | Select-Object -Property $property).$property
                    $value = $Property

                    $BoundParameters.Remove('Items') | out-null
                    $BoundParameters.Remove('Property') | out-null
                    $BoundParameters.Value = $value
                    $BoundParameters.Content = $Content

                    $options += option @BoundParameters
                }
            }

            'Classic' {
                $options += option @PSBoundParameters
            }

            Default {
            }
        }
    }
    
    end {
        $options -join ''
    }
}