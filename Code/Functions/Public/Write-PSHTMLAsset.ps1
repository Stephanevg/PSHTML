function Write-PSHTMLAsset {
    <#
    .SYNOPSIS
      Add script references to your PSHTML scripts.
    .DESCRIPTION
        Write-PSHTML will scan the 'Assets' folders in the PSHTML module folder, and 

    .EXAMPLE
        Write-PSHTMLAsset -Type Script -Name ChartJs

        Generates the following results:
        
        <Script src='Chartjs/Chart.bundle.min.js'></Script

    .EXAMPLE
        Write-PSHTMLAsset -Type Style -Name Bootstrap

        Generates the following results:
        
        <Link src='BootStrap/bootstrap.min.css'></Link>

    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [CmdletBinding()]
    param (
        [ValidateSet("Script","Style")]$Type

    )

    DynamicParam {
        $ParameterName = 'Name'
        if($Type){

            $SelectedAsset = (Get-PSHTMLConfiguration).GetAsset([AssetType]$Type)
        }Else{
            $SelectedAsset = (Get-PSHTMLConfiguration).GetAsset()
        }
        

        $AssetNames = $SelectedAsset.Name
 
        $AssetAttribute = New-Object System.Management.Automation.ParameterAttribute
        $AssetAttribute.Position = 2
        $AssetAttribute.Mandatory = $true
        $AssetAttribute.HelpMessage = 'Select the asset to add'
 
        $AssetCollection = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
        $AssetCollection.add($AssetAttribute)
 
        $AssetValidateSet = New-Object System.Management.Automation.ValidateSetAttribute($AssetNames)
        $AssetCollection.add($AssetValidateSet)
 
        $AssetParam = New-Object System.Management.Automation.RuntimeDefinedParameter($ParameterName, [string], $AssetCollection)
 
        $AssetDictionary = New-Object System.Management.Automation.RuntimeDefinedParameterDictionary
        $AssetDictionary.Add($ParameterName, $AssetParam)
        return $AssetDictionary
 
    }
    
    begin {
        $Name = $PsBoundParameters[$ParameterName]
    }
    
    process {
        if($Type){
            $Asset = (Get-PSHTMLConfiguration).GetAsset($Name,[AssetType]$Type)
        }Else{
            $Asset = (Get-PSHTMLConfiguration).GetAsset($Name)
        }

        Foreach($A in $Asset){
            $A.ToString()
        }
        
    }
    
    end {
    }
}