Function html {
    <#
    .SYNOPSIS
    Generates a html HTML tag.

    .DESCRIPTION

    The <html> tag tells the browser that this is an HTML document.

    The <html> tag represents the root of an HTML document.

    The <html> tag is the container for all other HTML elements (except for the <!DOCTYPE> tag).

    .PARAMETER Class
    Allows to specify one (or more) class(es) to assign the html element.
    More then one class can be assigned by seperating them with a white space.

    .PARAMETER Id
    Allows to specify an id to assign the html element.

    .PARAMETER Style
    Allows to specify in line CSS style to assign the html element.

    .PARAMETER Content
    Allows to add child element(s) inside the current opening and closing HTML tag(s).


    .EXAMPLE


    .NOTES
    Current version 1.1.0
    History:
        2018.04.10;Stephanevg; Added parameters
        2018.04.01;Stephanevg;Creation.
    .LINK
        https://github.com/Stephanevg/PSHTML
#>
Param(

    [Parameter(
        ValueFromPipeline = $true,
        Mandatory = $false,
        Position = 0
    )]
    [AllowEmptyString()]
    [AllowNull()]
    $Content,

    [Parameter(Position = 1)]
    [String]$Class,

    [Parameter(Position = 2)]
    [String]$Id,

    [Parameter(Position = 3)]
    [String]$Style,

    [Parameter(Position = 4)]
    [Hashtable]$Attributes,

    [String]$xmlns
)
    $attr = ""
    $CommonParameters = ("Attributes", "Content") + [System.Management.Automation.PSCmdlet]::CommonParameters + [System.Management.Automation.PSCmdlet]::OptionalCommonParameters
    $CustomParameters = $PSBoundParameters.Keys | Where-Object -FilterScript { $_ -notin $CommonParameters }

    if($CustomParameters){

        foreach ($entry in $CustomParameters){


            $Attr += "{0}=`"{1}`" " -f $entry,$PSBoundParameters[$entry]

        }

    }

    if($Attributes){
        foreach($entry in $Attributes.Keys){

            $attr += "{0}=`"{1}`" " -f $entry,$Attributes[$Entry]
        }
    }

    if($attr){
        "<html {0} >"  -f $attr
    }else{
        "<html>"
    }



    if($Content){

        if($Content -is [System.Management.Automation.ScriptBlock]){
            $Content.Invoke()
        }else{
            $Content
        }
    }


    '</html>'


}