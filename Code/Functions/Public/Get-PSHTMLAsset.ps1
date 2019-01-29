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
        [String]$Name,
        [ValidateSet("Script","Style")]$Type
    )
    
    begin {
    }
    
    process {
        $Config = (Get-PSHTMLConfiguration)
        If($Name){

            $Config.GetAsset($Name)
        }Elseif($Type){
            $Config.GetAsset($Name,$Type)
        }else{
            $Config.GetAsset()
        }
    }
    
    end {
    }
}