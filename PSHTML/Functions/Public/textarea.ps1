Function textarea {
    <#
    .SYNOPSIS
    Create a textarea tag in an HTML document.

    .DESCRIPTION

    The <textarea> tag defines a multi-line text input control.

    A text area can hold an unlimited number of characters, and the text renders in a fixed-width font (usually Courier).

    The size of a text area can be specified by the cols and rows attributes, or even better; through CSS' height and width properties.

    .EXAMPLE
    
    textarea -Rows 3 -Cols 4 -Content "Please fill in text here and press ok"
    
    Returns:

    <textarea Cols="4" Rows="3"  >
    Please fill in text here and press ok
    </textarea>

    .EXAMPLE
   

    .NOTES
    Current version 2.0
       History:
           
            2018.04.01;stephanevg;Creation.
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [Cmdletbinding()]
    Param(
        [Parameter(Mandatory = $false)]
        [AllowEmptyString()]
        [AllowNull()]
        $Content,
        
        [AllowEmptyString()]
        [AllowNull()]
        [String]$Name = "",

        [AllowEmptyString()]
        [AllowNull()]
        [int]$Rows = "",

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Cols = "",


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

        $CommonParameters = @('tagname') + [System.Management.Automation.PSCmdlet]::CommonParameters + [System.Management.Automation.PSCmdlet]::OptionalCommonParameters
        $CustomParameters = $PSBoundParameters.Keys | ? { $_ -notin $CommonParameters }
        
        $htmltagparams = @{}
        $tagname = "textarea"

        if ($CustomParameters) {

            foreach ($entry in $CustomParameters) {


                if ($entry -eq "content") {

                    
                    $htmltagparams.$entry = $PSBoundParameters[$entry]
                }
                else {
                    $htmltagparams.$entry = "{0}" -f $PSBoundParameters[$entry]
                }
                
    
            }

            if ($Attributes) {
                $htmltagparams += $Attributes
            }


        }
        Set-HtmlTag -TagName $tagname -Attributes $htmltagparams -TagType NonVoid
    }
}
