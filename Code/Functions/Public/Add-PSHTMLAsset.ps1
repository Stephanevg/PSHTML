function Add-PSHTMLAsset {
    <#
    .SYNOPSIS
      Add script references to your PSHTML scripts.
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
        [Switch]$Simple

    )

    Dynamicparam{
        $ParamAttrib = New-Object  System.Management.Automation.ParameterAttribute
        $ParamAttrib.Mandatory = $true
        $ParamAttrib.ParameterSetName = '__AllParameterSets'

        $AttribColl = New-Object  System.Collections.ObjectModel.Collection[System.Attribute]
        $AttribColl.Add($ParamAttrib)
        $configurationFileNames = Get-ChildItem -Path  'C:\ConfigurationFiles' | Select-Object -ExpandProperty Name
        $AttribColl.Add((New-Object  System.Management.Automation.ValidateSetAttribute($configurationFileNames)))
        $RuntimeParam = New-Object  System.Management.Automation.RuntimeDefinedParameter('Name', [string],  $AttribColl)
    }
    
    begin {
    }
    
    process {

    }
    
    end {
    }
}