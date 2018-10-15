Function Get-HTMLTemplate{
    <#
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

            h2 "This comes a template file"
            </body>
            <footer>
            div {
                h4 "This is the footer from a template"
                p{
                    CopyRight from template
                }
            }
            </footer>
        </html>
    #>
    [CmdletBinding()]
    Param(
        $Name
    )

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

}
