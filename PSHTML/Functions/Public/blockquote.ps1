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
    Current version 2.0
       History:
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
        $tagname = "blockquote"
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
