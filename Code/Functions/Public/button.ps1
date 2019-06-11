Function button {
    <#
    .SYNOPSIS
    Creates a <button> html tag.

    .DESCRIPTION
    Should be used in conjunction with a form attribute.


    .EXAMPLE

    button
    .EXAMPLE
    button "woop1" -Class "class"

    .EXAMPLE

    <form>
    <fieldset>
        <button>Personalia:</button>
        Name: <input type="text" size="30"><br>
        Email: <input type="text" size="30"><br>
        Date of birth: <input type="text" size="10">
    </fieldset>
    </form>

    .Notes
    Author: Stéphane van Gulick
    Version: 3.1
    History:
        2018.11.1; Stephanevg;Updated to version 3.1
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

        [String]$Id,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class,

        

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Style,

        [Hashtable]$Attributes
    )


    $tagname = "button"

    Set-htmltag -TagName $tagName -Parameters $PSBoundParameters -TagType nonVoid




}
