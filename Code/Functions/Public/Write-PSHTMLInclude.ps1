Function Write-PSHTMLInclude {
    <#
    .SYNOPSIS
    Include parts of your PSHTML documents that is identical across pages.

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
    
        Foreach($Include in $Includes){
            $Include.Get()
        }

    }
    End{}

    <#
    $callstack = Get-PSCallStack
    $ScriptCaller = $callstack[-1].ScriptName
    $ScriptPath = Split-Path $ScriptCaller -Parent
    $TemplatesFolder = join-path $ScriptPath -ChildPath "Templates"

    if(!(test-path $TemplatesFolder)){
        throw "The folder templates was not found at $($TemplatesFolder)"
    }
    if(!($Name.EndsWith(".ps1"))){
        $Name = $name + ".ps1"
    }
    $Template = get-childItem -Path $templatesFolder -filter "$($Name)"

    if ($template.count -ge 2){
        throw "One or more files with the same template name $($name) where found, please be more specefic, or rename the templates"
    }
    if(!($template)){
        throw "No template file with the name '$($Name)' could be found in the templates folder."
    }

    if($template.count -eq 1){
        write-verbose "Template file found at $($Template.FullName)"
    }

    $Rawcontent = Get-Content $Template.FullName -Raw
    $Content = [scriptBlock]::Create($Rawcontent).Invoke()
    return $content
    #>
    
}
