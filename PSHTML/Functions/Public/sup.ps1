Function SUP {
    <#
    .SYNOPSIS
        Create a SUP tag in an HTML document.
    .DESCRIPTION
        The <sup> tag defines superscript text. 
        Superscript text appears half a character above the normal line, and is sometimes rendered in a smaller font. 
        Superscript text can be used for footnotes, like WWW[1].
    .EXAMPLE
        $Power = 3
        p -content {
            "The Value of 2"
            SUP $Power
            "is {0}" -f ([Math]::Pow(2,$Power))
        } 
        The above example renderes the HTML code as illustrated below
        <p>
        The Value of 2
        <SUP>
            3
        </SUP>
        is 8
        </p>
    .NOTES
        Current version 2.0
        History:
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
            [String]$Class = "",
    
            [String]$Id,
    
            [AllowEmptyString()]
            [AllowNull()]
            [String]$Style,
    
            [String]$title,
    
            [Hashtable]$Attributes
        )
    
        Begin {
            
            $htmltagparams = @{}
            $tagname = "SUP"
        }
        
        Process {       
            $CommonParameters = @('tagname') + [System.Management.Automation.PSCmdlet]::CommonParameters + [System.Management.Automation.PSCmdlet]::OptionalCommonParameters
            $CustomParameters = $PSBoundParameters.Keys | ? { $_ -notin $CommonParameters }
            
            if ($CustomParameters) {
    
                Switch ($CustomParameters) {
                    {($_ -eq 'content') -and ($null -eq $htmltagparams.$_)} {
                        $htmltagparams.$_ = @($PSBoundParameters[$_])
                        continue
                    }
                    {$_ -eq 'content'} {
                        $htmltagparams.$_ += $PSBoundParameters[$_]
                        continue
                    }
                    default {$htmltagparams.$_ = "{0}" -f $PSBoundParameters[$_]}
                }
            }
        }
        
        End {
            if ($Attributes) {
                $htmltagparams += $Attributes
            }
            Set-HtmlTag -TagName $tagname -Attributes $htmltagparams -TagType NonVoid 
        }
        
    }
