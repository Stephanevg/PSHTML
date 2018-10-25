Function blockquote {
    <#
    .SYNOPSIS
    Create a blockquote tag in an HTML document.

    .EXAMPLE
    blockquote -cite "https://www.google.com" -Content @"
        Google is a
        great website
        to search for information
    "@

    .EXAMPLE
    blockquote -cite "https://www.google.com" -class "classy" -style "stylish" -Content @"
        Google is a
        great website
        to search for information
    "@

    .NOTES
    Current version 2.3
       History:
            2018.10.24;@ChristopheKumor;Modified $htmltagparams filling to version 2.3
            2018.10.24;@ChristopheKumor;Fixed no pipeline support bug. to version 2.2
            2018.10.02;@NicolasBaudin;Fixed pipeline support bug. to version 2.1
            2018.10.02;@stephanevg;Fixed error when no content passed. to version 2.0
            2018.10.02;bateskevin;updated to version 2.0
            2018.05.07;stephanevg;updated to version 1.0
            2018.04.01;bateskevinhanevg;Creation.
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [Cmdletbinding()]
    Param(

        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $false,
            Position = 0
        )]
        [AllowEmptyString()]
        [AllowNull()]
        $Content,

        [string]$cite,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class,

        [String]$Id,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Style,

        [String]$title,

        [Hashtable]$Attributes
    )


    Begin {
        $CommonParameters = [System.Management.Automation.PSCmdlet]::CommonParameters + [System.Management.Automation.PSCmdlet]::OptionalCommonParameters
        $htmltagparams = @{}
        $tagname = "blockquote"
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
        Set-HtmlTag -TagName $tagname -Attributes $htmltagparams -TagType NonVoid 
    }
    
}
