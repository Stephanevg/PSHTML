function Write-PSHTMLAsset {
    <#
    .SYNOPSIS
        Add asset references to your PSHTML scripts.
    .DESCRIPTION
        Write-PSHTML will scan the 'Assets' folders in the PSHTML module folder, and 
        One can Use Write-PSHTML (Without any parameter) to add dynamically a link / script tag for every asset that is available in the Asset Folder.

    .PARAMETER Name

    Specify the name of an Asset. This is a dynamic parameter, and calculates the names based on the content of Assets folder.

    .PARAMETER Type

    Allows to specifiy what type of Asset to return. Script (.js) or Style (.css) are the currently supported ones.

    .EXAMPLE
        Write-PSHTMLAsset

        Will generate all the asset tags, regardless of their type.

    .EXAMPLE
        Write-PSHTMLAsset -Type Script -Name ChartJs

        Generates the following results:
        
        <Script src='Chartjs/Chart.bundle.min.js'></Script

    .EXAMPLE
        Write-PSHTMLAsset -Type Style -Name Bootstrap

        Generates the following results:
        
        <Link src='BootStrap/bootstrap.min.css'></Link>

    .EXAMPLE
        Write-PSHTMLAsset -Name Bootstrap

        Generates all the links regardless of their type.


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
        $AssetAttribute.Mandatory = $False
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
        if($Type -and $Name){
            $Asset = (Get-PSHTMLConfiguration).GetAsset($Name,[AssetType]$Type)
        }ElseIf($Name){
            $Asset = (Get-PSHTMLConfiguration).GetAsset($Name)
        }ElseIf($Type){
            $Asset = (Get-PSHTMLConfiguration).GetAsset([AssetType]$Type)
        }
        Else{
            $Asset = (Get-PSHTMLConfiguration).GetAsset()
        }

        Foreach($A in $Asset){
            $A.ToString()
        }
        
    }
    
    end {
    }
}