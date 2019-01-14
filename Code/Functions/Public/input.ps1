Function input {
    
    <#
    .SYNOPSIS
    Generates input HTML tag.
    .DESCRIPTION
    The <input> tag specifies an input field where the user can enter data.

    <input> elements are used within a <form> element to declare input controls that allow users to input data.

    An input field can vary in many ways, depending on the type attribute.

    Note: The <input> element is empty, it contains attributes only.

    Tip: Use the <label> element to define labels for <input> elements.

    More info: https://www.w3schools.com/tags/tag_input.asp
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [CmdletBinding()]
    Param(

        #Need to add the other ones from --> https://www.w3schools.com/tags/tag_input.asp
        [Parameter(Mandatory = $true, Position = 0)]
        [ValidateSet("button", "checkbox", "color", "date", "datetime-local", "email", "file", "hidden", "image", "month", "number", "password", "radio", "range", "reset", "search", "submit", "tel", "text", "time", "url", "week")]
        [String]$type,

        [Parameter(Mandatory = $true, Position = 1)]
        [String]$name,

        [Parameter(Mandatory = $false, Position = 2)]
        [switch]$required,

        [Parameter(Mandatory = $false, Position = 3)]
        [switch]$readonly,

        [Parameter(Position = 4)]
        [String]$Class,

        [Parameter(Position = 5)]
        [String]$Id,

        [Parameter(Position = 6)]
        [String]$Style,

        [Parameter(Position = 7)]
        [String]$value,

        [Parameter(Position = 8)]
        [Hashtable]$Attributes
    )

    Process {
        $tagname = "input"
        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType Void
    }

}
