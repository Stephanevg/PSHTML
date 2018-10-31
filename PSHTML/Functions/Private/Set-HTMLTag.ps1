Function Set-HtmlTag {
    <#
    .Synopsis
        This function is the base function for all the html elements in pshtml.

    .Description
        although it can be this function is not intended to be used directly.
    .EXAMPLE
    Set-HtmlTag -TagName div -PSBParameters $PSBoundParameters -MyCParametersKeys $MyInvocation.MyCommand.Parameters.Keys

    .EXAMPLE
    Set-HtmlTag -TagName style -PSBParameters $PSBoundParameters -MyCParametersKeys $MyInvocation.MyCommand.Parameters.Keys

    .NOTES
    Current version 0.8
        History:
            2018.10.24;@ChristopheKumor;include tag parameters to version 0.8
            2018.05.07;stephanevg;
            2018.05.07;stephanevg;Creation
    #>
    [Cmdletbinding()]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSProvideCommentHelp", "", Justification = "Manipulation of text")]
    Param(

        #[system.web.ui.HtmlTextWriterTag]
        $TagName,

        $PSBParameters,

        $MyCParametersKeys,

        [ValidateSet('void', 'NonVoid')]
        $TagType,

        $Content
    )

    Begin {
        $CommonParameters = [System.Management.Automation.PSCmdlet]::CommonParameters + [System.Management.Automation.PSCmdlet]::OptionalCommonParameters
    }
    Process {
        $attr = $output = ''
        $outcontent = $false

        foreach ($paramkey in $MyCParametersKeys) {
            $paramvalue = Get-Variable $paramkey -ValueOnly -EA SilentlyContinue
            if ($paramvalue -and !$PSBParameters.ContainsKey($paramkey)) {
                $attr += '{0}="{1}" ' -f $paramkey, $paramvalue
            }
        }
        
        switch ($PSBParameters.Keys) {
            'Content' { 
                if ($PSBParameters[$_] -is [System.Management.Automation.ScriptBlock]) {
                    $outcontent = $PSBParameters[$_].Invoke()
                    continue
                }
                else {
                    $outcontent = $PSBParameters[$_]
                    continue
                }
            }
            'Attributes' { 

                foreach ($entry in $PSBParameters['Attributes'].Keys) {
                    if ($entry -eq 'content' -or $entry -eq 'Attributes') {
                        continue
                    }
                    $attr += '{0}="{1}" ' -f $entry, $Attributes[$Entry]
                }

                if ($Attributes.Attributes) {
                    foreach ($at in $Attributes.Attributes.keys) {

                        $attr += '{0}="{1}" ' -f $at, $Attributes.Attributes[$at]
                    }
                }

                continue
            }
            'httpequiv' {
                $attr += 'http-equiv="{0}" ' -f $PSBParameters[$_]
                continue
            }
            'content_tag' {
                $attr += 'content="{0}" ' -f $PSBParameters[$_]
                continue
            }
            default { 
            
                if ($_ -notin $CommonParameters) {
        
                    if ($PSBParameters[$_].IsPresent) { 
                        $attr += '{0}' -f $_
                    }
                    else {
                        $attr += '{0}="{1}" ' -f $_ , $PSBParameters[$_]
                    }

                }

            }
        }



        if ($TagType -eq 'void') {
            $Closingtag = '/'
            if ($attr) {
                $output += '<{0} {1} {2}>' -f $tagname, $attr, $Closingtag
            }
            else {
                $output += '<{0} {1}>' -f $tagname, $Closingtag
            }
        }
        else {
            #tag is of type "non-void"
            if ($attr) {
                $output += '<{0} {1} >' -f $tagname, $attr
            }
            else {
                $output += '<{0}>' -f $tagname
            }

            if ($outcontent) {
                $output += -join $outcontent 
            }

            $output += '</{0}>' -f $tagname
        }
        $output
    }
}
