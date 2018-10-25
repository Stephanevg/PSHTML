Function SUB {
    <#
    .SYNOPSIS
        Create a SUB tag in an HTML document.
    .DESCRIPTION
        The <sub> tag defines subscript text. 
        Subscript text appears half a character below the normal line, and is sometimes rendered in a smaller font. 
        Subscript text can be used for chemical formulas, like H2O. 
    .EXAMPLE
        p -content {
            "The Chemical Formula for water is H"
            SUB -Content {
                2
            }
            "O"
        } 
        The above example renders the html as illustrated below
        <p>
        The Chemical Formula for water is H
        <SUB>
            2
        </SUB>
        O
        </p>
    .NOTES
        Current version 2.1
        History:
                2018.10.24;@ChristopheKumor;Modified $htmltagparams filling to version 2.1
                2018.10.18;@ChendrayanV;Updated to version 2.0
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
        $tagname = "SUB"
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
