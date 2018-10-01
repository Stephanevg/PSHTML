Function img {
    <#
        .SYNOPSIS
        Generates a html img tag.

        .DESCRIPTION

        The <img> tag defines an image in an HTML page.

        The <img> tag has two required attributes: src and alt.

        .PARAMETER SRC

        Defines the source location of the image

        .PARAMETER ALT

        Alternative display when the image cannot be displayed.

        .PARAMETER Class
        Allows to specify one (or more) class(es) to assign the img element.
        More then one class can be assigned by seperating them with a white space.

        .PARAMETER Id
        Allows to specify an id to assign the img element.

        .PARAMETER Style
        Allows to specify in line CSS style to assign the img element.

        .PARAMETER Content
        Allows to add child element(s) inside the current opening and closing img tag(s).


        .EXAMPLE


        .NOTES
        Current version 1.0
        History:
            2018.05.07;Stephanevg; Updated code to version 1.0
            2018.04.01;Stephanevg;Creation.
        .LINK
            https://github.com/Stephanevg/PSHTML
    #>

    Param(

        [Parameter(Mandatory=$true)]
        [String]
        $src="",

        [Parameter(Mandatory=$true)]
        [string]
        $alt = "",

        [Parameter(Mandatory=$false)]
        [string]
        $height,

        [Parameter(Mandatory=$false)]
        [string]
        $width,

        [String]$Class,

        [String]$Id,

        [String]$Style,

        [Hashtable]$Attributes
    )


    $attr = ""
    $CommonParameters = ("Attributes", "Content") + [System.Management.Automation.PSCmdlet]::CommonParameters + [System.Management.Automation.PSCmdlet]::OptionalCommonParameters
    $CustomParameters = $PSBoundParameters.Keys | ? { $_ -notin $CommonParameters }

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
        "<img {0} />"  -f $attr
    }else{
        "<img />"
    }

}
