function Get-PSHTMLAsset {
    <#
    .SYNOPSIS
        Returns existing PSHTML assets
    .DESCRIPTION
        Long description
    .EXAMPLE
        PS C:\> <example usage>
        Explanation of what the example does
    .INPUTS
        Inputs (if any)
    .OUTPUTS
        Output (if any)
    .NOTES
        General notes
    #>
    [CmdletBinding()]
    param (
        $Name
    )
    
    begin {
    }
    
    process {
        $Config = (Get-PSHTMLConfiguration)
        If($Name){

            $Config.GetAssetRelativePath($Name)
        }Else{
            $Config.GetAsset()
        }
    }
    
    end {
    }
}