Function doctype {
    <#
    .SYNOPSIS
    Generates doctype HTML5 tag.

    .PARAMETER Content
    Allows to add child element(s) after doctype tag

    .NOTES
    Current version 0.1
    History:
        2018.10.22;Christophe Kumor;
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [Cmdletbinding()]
    Param(
        [Parameter(Mandatory=$false)]
        [AllowEmptyString()]
        [AllowNull()]
        $Content
    )
    
'<!DOCTYPE html>'

if($Content){

    if($Content -is [System.Management.Automation.ScriptBlock]){
        $Content.Invoke()
    }else{
        $Content
    }
}
    }