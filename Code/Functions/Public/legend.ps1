Function legend {
    <#
    .SYNOPSIS
    The <legend> tag defines a caption for the <fieldset> element.


    .EXAMPLE

    legend
    .EXAMPLE
    legend "woop1" -Class "class"

    .EXAMPLE

    <form>
    <fieldset>
        <legend>Personalia:</legend>
        Name: <input type="text" size="30"><br>
        Email: <input type="text" size="30"><br>
        Date of birth: <input type="text" size="10">
    </fieldset>
    </form>

    .Notes
    Author: Stéphane van Gulick
    Version: 3.1.0
    History:
    2018.10.30;@ChristopheKumor;Updated to version 3.0
        2018.05.09;@Stephanevg; Creation
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
        [String]$Class,

        [String]$Id,

        [Hashtable]$Attributes
    )

    $tagname = "legend"

    Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid



}
