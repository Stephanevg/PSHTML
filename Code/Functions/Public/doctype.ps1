Function doctype {
    <#
        .SYNOPSIS
        Generates a html doctype tag.

        .DESCRIPTION

        The <!DOCTYPE> declaration must be the very first thing in your HTML document, before the <html> tag.

        The <!DOCTYPE> declaration is not an HTML tag; it is an instruction to the web browser about what version of HTML the page is written in.



        .EXAMPLE

        doctype

        .NOTES
        Current version 0.1.0
        History:
            2019.07.09;@stephanevg;created

        .LINK
            https://github.com/Stephanevg/PSHTML
    #>

    Param(

    )

    #As described here: https://www.w3schools.com/tags/tag_doctype.asp
    #$tagname = "doctype"
    
    #Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType 'void'
    return "<!DOCTYPE html>"

}
