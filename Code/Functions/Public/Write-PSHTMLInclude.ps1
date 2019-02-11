Function Write-PSHTMLInclude {
    <#
    .SYNOPSIS
    Include parts of your PSHTML documents that is identical across pages.

    .DESCRIPTION
    Write the HTML content of an include file. Write-PSHTMLInclude has an well known alias called: 'include'.

    .PARAMETER Name

    Specifiy the name of an include file. 
    The name of an include file is the name of the powershell script containing the code, without the extension.
    Example: Footer.ps1 The name will be 'Footer'

    This parameter is a dynamic parameter, and you can tab through the different values up until you find the one you wish to use.


    .Example



html{
    Body{

        include -name body

    }
    Footer{
        Include -Name Footer
    }
}

#Generates the following HTML code

        <html>
            <body>

            h2 "This comes a Include file"
            </body>
            <footer>
            div {
                h4 "This is the footer from a Include"
                p{
                    CopyRight from Include
                }
            }
            </footer>
        </html>
#>
    [CmdletBinding()]
    Param(
        
    )

    DynamicParam {
        $ParameterName = 'Name'

        $Includes = (Get-PSHTMLConfiguration).GetInclude()
        If($Includes){
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

    Begin{
        $Name = $PsBoundParameters[$ParameterName]
    }
    Process{

        If($Name){
            $Includes = (Get-PSHTMLConfiguration).GetInclude($Name)
        }else{
           $Includes = (Get-PSHTMLConfiguration).GetInclude()
        }
    
        Foreach($Include in $Includes){
            $Include.ToString()
        }

    }
    End{}

}
