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
    Version: 1.0.0
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


    $tagname = "button"

    Set-HtmlTag -TagName $tagname -PSBParameters $PSBoundParameters -MyCParametersKeys $MyInvocation.MyCommand.Parameters.Keys -TagType nonVoid




}
