Function Get-PSHTMLInclude {
    <#
    .SYNOPSIS
    Retrieve the list of available PSHTML include files.

    .Example

    Get-PSHTMLInclude
#>
    [CmdletBinding()]
    Param(
        
    )

    DynamicParam {
        $ParameterName = 'Name'

        $Includes = (Get-PSHTMLConfiguration).GetInclude()

        $Names = $Includes.Name
 
        $Attribute = New-Object System.Management.Automation.ParameterAttribute
        $Attribute.Position = 1
        $Attribute.Mandatory = $False
        $Attribute.HelpMessage = 'Select which file to include'
 
        $Collection = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
        $Collection.add($Attribute)
 
        $ValidateSet = New-Object System.Management.Automation.ValidateSetAttribute($Names)
        $Collection.add($ValidateSet)
 
        $Param = New-Object System.Management.Automation.RuntimeDefinedParameter($ParameterName, [string], $Collection)
 
        $Dictionary = New-Object System.Management.Automation.RuntimeDefinedParameterDictionary
        $Dictionary.Add($ParameterName, $Param)
        return $Dictionary
 
    }

    Begin{
        $Name = $PsBoundParameters[$ParameterName]
    }
    Process{

        If($Name){
            $Includes = (Get-PSHTMLConfiguration).GetInclude($Name)
        }else{
           $Includes = (Get-PSHTMLConfiguration).GetInclude()
        }
    
        

    }
    End{

        return $Includes
    }

}
