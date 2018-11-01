#!/usr/bin/env powershell
Function Set-HtmlTag {
    <#
    .Synopsis
        This function is the base function for all the html elements in pshtml.

    .Description
        although it can be this function is not intended to be used directly.
    .EXAMPLE
    Set-HtmlTag -TagName div -PSBParameters $PSBoundParameters -MyInvocationParametersKeys $MyInvocation.MyCommand.Parameters.Keys

    .EXAMPLE
    Set-HtmlTag -TagName style -PSBParameters $PSBoundParameters -MyInvocationParametersKeys $MyInvocation.MyCommand.Parameters.Keys

    .NOTES
    Current version 0.8
        History:
            2018.10.24;@ChristopheKumor;include tag parameters to version 0.8
            2018.05.07;stephanevg;
            2018.05.07;stephanevg;Creation
    #>
    [Cmdletbinding()]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSProvideCommentHelp', '', Justification = 'Manipulation of text')]
    Param(

        #[system.web.ui.HtmlTextWriterTag]
        $TagName,

        $Parameters,

        $MyInvocationParametersKeys,

        [ValidateSet('void', 'NonVoid')]
        $TagType,

        $Content
    )

    Begin {
        $CommonParameters = [System.Management.Automation.PSCmdlet]::CommonParameters + [System.Management.Automation.PSCmdlet]::OptionalCommonParameters
    }
    Process {
        $attr = ''
        $outcontent = $false

        foreach ($paramkey in $MyInvocationParametersKeys) {
            $paramvalue = Get-Variable $paramkey -ValueOnly -EA SilentlyContinue
            if ($paramvalue -and !$Parameters.ContainsKey($paramkey)) {
                $attr += '{0}="{1}" ' -f $paramkey, $paramvalue
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
                        write-verbose ('[Set-HTMLTAG] attribute {0} is a reserved value, and should not be passed in the Attributes HashTable' -f ($entry))
                        continue
                    }
                    $attr += '{0}="{1}" ' -f $entry, $_[$Entry]
                }

                if ($_.Attributes) {
                    foreach ($at in $_.Attributes.keys) {

                        $attr += '{0}="{1}" ' -f $at, $_.Attributes[$at]
                    }
                }

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
