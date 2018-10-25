Function img {
    <#
        .SYNOPSIS
        Generates a html img tag.

        .DESCRIPTION

        The <img> tag defines an image in an HTML page.

        The <img> tag has two required attributes: src and alt.

        .PARAMETER SRC

        Defines the source location of the image

        .PARAMETER ALT

        Alternative display when the image cannot be displayed.

        .PARAMETER Class
        Allows to specify one (or more) class(es) to assign the img element.
        More then one class can be assigned by seperating them with a white space.

        .PARAMETER Id
        Allows to specify an id to assign the img element.

        .PARAMETER Style
        Allows to specify in line CSS style to assign the img element.

        .PARAMETER Content
        Allows to add child element(s) inside the current opening and closing img tag(s).


        .EXAMPLE


        .NOTES
        Current version 2.1
        History:
            2018.10.24;@ChristopheKumor;Modified $htmltagparams filling to version 2.1
            2018.10.10;Stephanevg; Updated code to version 2.0
            2018.05.07;Stephanevg; Updated code to version 1.0
            2018.04.01;Stephanevg;Creation.
        .LINK
            https://github.com/Stephanevg/PSHTML
    #>

    Param(

        [Parameter(Mandatory = $true)]
        [String]
        $src,

        [Parameter(Mandatory = $true)]
        [string]
        $alt,

        [Parameter(Mandatory = $false)]
        [string]
        $height,

        [Parameter(Mandatory = $false)]
        [string]
        $width,

        [String]$Class,

        [String]$Id,

        [String]$Style,

        [Hashtable]$Attributes
    )


    Begin {
        $CommonParameters = [System.Management.Automation.PSCmdlet]::CommonParameters + [System.Management.Automation.PSCmdlet]::OptionalCommonParameters
        $htmltagparams = @{}
        $tagname = "img"
    }
    Process { 
        foreach ($paramkey in $MyInvocation.MyCommand.Parameters.Keys) {
            $paramvalue = Get-Variable $paramkey -ValueOnly -EA SilentlyContinue
            if ($paramvalue -and !$PSBoundParameters.ContainsKey($paramkey)) {
                $htmltagparams.$paramkey = $paramvalue
            }
        }
    
        switch ($PSBoundParameters.Keys) {
            'content' { 
                if ($PSBoundParameters['content'] -is [System.Management.Automation.ScriptBlock]) {
                    $htmltagparams.$_ = $PSBoundParameters[$_]
                    continue
                }
                elseif ($null -eq $htmltagparams.$_) {
                    $htmltagparams.$_ = @($PSBoundParameters[$_])
                    continue   
                }
                else {
                    $htmltagparams.$_ += $PSBoundParameters[$_] 
                    continue
                }
            }
            'Attributes' { 
                if ($null -eq $htmltagparams.$_) {
                    $htmltagparams.$_ += $PSBoundParameters[$_]
                }
                continue
            }
            default { 
                if ($_ -notin $CommonParameters) {
            
                    if ($PSBoundParameters[$_].IsPresent) { 
                    $htmltagparams.$_ = $null
                }
                else {
                    $htmltagparams.$_ = '{0}' -f $PSBoundParameters[$_]
                }

            }
            }
        }
    }
    End { 
        Set-HtmlTag -TagName $tagname -Attributes $htmltagparams -TagType Void
    }

}
