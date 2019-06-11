Function Keygen {
    <#
    .SYNOPSIS
    Create a Keygen tag in an HTML document.

    .DESCRIPTION

    The name attribute specifies the name of a <keygen> element.

    The name attribute of the <keygen> element is used to reference form data after the form has been submitted.

    .EXAMPLE

     keygen -Name "Secure"

     Returns:

    <Keygen Name="Secure"  />

    .NOTES
    Current version 3.1
       History:
       2018.10.30;@ChristopheKumor;Updated to version 3.0
            2018.10.10;Stephanevg;Creation.
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [Cmdletbinding()]
    Param(
        
        [AllowEmptyString()]
        [AllowNull()]
        [String]$Name = "",

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

    Process {
        $tagname = "Keygen"

        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType Void
    }
}
