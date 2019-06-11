Function Get-PSHTMLInclude {
    <#
    .SYNOPSIS
    Retrieve the list of available PSHTML include files.

    .DESCRIPTION
    Allows to list the current existing include documents available to use.

    .PARAMETER Name

    Specifiy the name of an include file. (The name of an include file is the name of the powershell script containing the code, without the extension.)
    Example: Footer.ps1 The name will be 'Footer'

    This parameter is a dynamic parameter, and you can tab through the different values up until you find the one you wish to use.

    .Example

    Get-PSHTMLInclude

    .Example

    Get-PSHTMLInclude -Name Footer
#>
    [CmdletBinding()]
    Param(
        
    )

    DynamicParam {
        $ParameterName = 'Name'

        $Includes = (Get-PSHTMLConfiguration).GetInclude()

        if ($Includes) {
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
        
 
    }

    Begin {
        $Name = $PsBoundParameters[$ParameterName]
    }
    Process {

        If ($Name) {
            $Includes = (Get-PSHTMLConfiguration).GetInclude($Name)
        }
        else {
            $Includes = (Get-PSHTMLConfiguration).GetInclude()
        }
    
        

    }
    End {

        return $Includes
    }

}
