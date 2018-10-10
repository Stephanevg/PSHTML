Function header {
    <#
    .SYNOPSIS
    Generates a header HTML tag.

    .DESCRIPTION


    The <header> element represents a container for introductory content or a set of navigational links.

    A <header> element typically contains:

    one or more heading elements (<h1> - <h6>)
    logo or icon
    authorship information
    You can have several <header> elements in one document.

    (Source -> https://www.w3schools.com/tags/tag_header.asp)

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
    header {
            h1 "This is h1 Title in header"
            h2 "This is h2 Title in header"
            p "Some text in paragraph"
    }

    Generates the following code

    <header>
        <h1>
        This is h1 Title in header
        </h1>
        <h2>
        This is h2 Title in header
        </h2>
        <p>
        Some text in paragraph
        </p>
    </header>


    .NOTES
    Current version 1.0
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
    $Content,

    [Parameter(Position = 1)]
    [String]$Class,

    [Parameter(Position = 2)]
    [String]$Id,

    [Parameter(Position = 3)]
    [String]$Style,

    [Parameter(Position = 4)]
    [Hashtable]$Attributes
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
        "<header {0} >"  -f $attr
    }else{
        "<header>"
    }



    if($Content){

        if($Content -is [System.Management.Automation.ScriptBlock]){
            $Content.Invoke()
        }else{
            $Content
        }
    }


    '</header>'


}
