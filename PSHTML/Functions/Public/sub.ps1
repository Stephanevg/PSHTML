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
            $tagname = "SUB"
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
