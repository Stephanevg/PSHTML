Function Set-HtmlTag {
    <#
    .Synopsis
        This function is the base function for all the html elements in pshtml.

    .Description
        although it can be this function is not intended to be used directly.
    .EXAMPLE
    Set-HtmlTag -TagName div -TagType NonVoid -Cmdlet $PSCmdlet

    .EXAMPLE
    Set-HtmlTag -TagName style TagType NonVoid -Cmdlet $PSCmdlet

    .NOTES
    Current version 3.2
        History:
            2018.11.11;@ChristopheKumor;use $PSCmdlet to version 3.2
            2018.10.24;@ChristopheKumor;include tag parameters to version 3.0
            2018.05.07;stephanevg;
            2018.05.07;stephanevg;Creation
    #>
    [Cmdletbinding()]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSProvideCommentHelp', '', Justification = 'Manipulation of text')]
    Param(

        #[system.web.ui.HtmlTextWriterTag]
        [Parameter(Mandatory = $true)]
        [String]$TagName,

        [Parameter(Mandatory = $true)]
        [System.Management.Automation.PSCmdlet]$Cmdlet,
        
        [Parameter(Mandatory = $true)]
        [ValidateSet('void', 'NonVoid')]
        $TagType,

        $Content
    )

    Begin {
        $CommonParameters = [System.Management.Automation.PSCmdlet]::CommonParameters + [System.Management.Automation.PSCmdlet]::OptionalCommonParameters

        $Parameters = $Cmdlet.MyInvocation.BoundParameters
        $InvocationParametersKeys = $Cmdlet.MyInvocation.MyCommand.Parameters.Keys

    }
    Process {
        $attr = ''
        $outcontent = $false

        foreach ($paramkey in $InvocationParametersKeys) {
            if (!$Parameters.ContainsKey($paramkey) -and !$CommonParameters.Contains($paramkey)) {
                write-verbose -Message ('[Set-HTMLTAG] Key {0} : searching for a default value' -f $paramkey)
                $paramvalue = $PSCmdlet.SessionState.PSVariable.Get($paramkey).Value
                if ($paramvalue) {
                    write-verbose -Message ('[Set-HTMLTAG] Key {0} : default value is {1}' -f $paramkey, $paramvalue)
                    $attr += '{0}="{1}" ' -f $paramkey, $paramvalue
                }
                else {
                    write-verbose -Message ('[Set-HTMLTAG] Key {0} : no default value' -f $paramkey)
                }
            }
        }
        
        switch ($Parameters.Keys) {
            'Content' { 
                if ($Parameters[$_] -is [System.Management.Automation.ScriptBlock]) {
                    $outcontent = $Parameters[$_].Invoke()
                    continue
                }
                else {
                    $outcontent = $Parameters[$_]
                    continue
                }
            }
            'Attributes' { 
                foreach ($entry in $Parameters['Attributes'].Keys) {
                    if ($entry -eq 'content' -or $entry -eq 'Attributes') {
                        write-verbose -Message ('[Set-HTMLTAG] attribute {0} is a reserved value, and should not be passed in the Attributes HashTable' -f ($entry))
                        continue
                    }
                    $attr += '{0}="{1}" ' -f $entry, $Attributes[$Entry]
                }
                #! Come from old Set-HTMLTag version, keep it ?
<#                 if ($Attributes.Attributes) {
                    foreach ($at in $Attributes.Attributes.keys) {

                        $attr += '{0}="{1}" ' -f $at, $Attributes.Attributes[$at]
                    }
                } #>
                continue
            }
            'httpequiv' {
                $attr += 'http-equiv="{0}" ' -f $Parameters[$_]
                continue
            }
            'content_tag' {
                $attr += 'content="{0}" ' -f $Parameters[$_]
                continue
            }
            default { 
            
                if ($_ -notin $CommonParameters) {
        
                    if ($Parameters[$_].IsPresent) { 
                        $attr += '{0}' -f $_
                    }
                    else {
                        $attr += '{0}="{1}" ' -f $_ , $Parameters[$_]
                    }

                }

            }
        }


        #Generating OutPut string
        #$TagBegin - TagAttributes - <TagContent> - TagEnd
        $TagBegin = '<{0}' -f $TagName

        if ($tagType -eq 'nonvoid') {
            $ClosingFirstTag = '>'
            $TagEnd = '</{0}>' -f $tagname
        }
        else {
            $ClosingFirstTag = '/>'
            $TagEnd = ''
        }

        if ($attr) {

            $TagAttributes = ' {0}{1}' -f $attr.trim(), $ClosingFirstTag
        }
        else {
            $TagAttributes = '{0}' -f $ClosingFirstTag
        }

        if ($outcontent) {

            $TagContent = (-join $outcontent ).trim()
        }

        $Data = $TagBegin + $TagAttributes + $TagContent + $TagEnd

        return $Data
    }
}
