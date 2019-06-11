Function datalist {
    <#
    .SYNOPSIS
    Create a datalist tag in an HTML document.

    .DESCRIPTION

    The <datalist> tag specifies a list of pre-defined options for an <input> element.

    The <datalist> tag is used to provide an "autocomplete" feature on <input> elements. Users will see a drop-down list of pre-defined options as they input data.

    Use the <input> element's list attribute to bind it together with a <datalist> element.

    .EXAMPLE
    
    datalist {
        option -value "Volvo" -Content "Volvo" 
        option -value Saab -Content "saab"
    }


    Generates the following code:

    <datalist>
        <option value="Volvo"  >volvo</option>
        <option value="Saab"  >saab</option>
    </datalist>
    .EXAMPLE
    

    .NOTES
    Current version 3.1
       History:
       2018.10.30;@ChristopheKumor;Updated to version 3.0
            2018.10.05;@stephanevg;Creation.
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
        [String]$Class = "",

        [String]$Id,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Style,

        [String]$title,

        [Hashtable]$Attributes
    )

    Process {

        $tagname = "datalist"

        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid
    }
}
