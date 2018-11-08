Function template {
    <#
        .SYNOPSIS
        Generates a html template tag.

        .DESCRIPTION

        The <template> tag defines an image in an HTML page.

        The <template> tag has two required attributes: src and alt.

        .PARAMETER XY

        .PARAMETER XYZ

        .PARAMETER Class
        Allows to specify one (or more) class(es) to assign the html element.
        More then one class can be assigned by seperating them with a white space.

        .PARAMETER Id
        Allows to specify an id to assign the html element.

        .PARAMETER Style
        Allows to specify in line CSS style to assign the html element.

        .PARAMETER Content
        Allows to add child element(s) inside the current opening and closing tag(s).


        .EXAMPLE

        .EXAMPLE

        .NOTES
        Current version 2.0
        History:
            2018.10.10;Stephanevg; Updated code to version 2.0
            2018.05.07;Stephanevg; Updated code to version 1.0
            2018.04.01;Stephanevg;Creation.
        .LINK
            https://github.com/Stephanevg/PSHTML
    #>

    Param(

        #Add custom parameters here





        #End of custom parameters
       

        [String]$Class,

        [String]$Id,

        [String]$Style,

        [Hashtable]$Attributes
    )
    $attr = ""
    $CommonParameters = "tagname" + [System.Management.Automation.PSCmdlet]::CommonParameters + [System.Management.Automation.PSCmdlet]::OptionalCommonParameters
    $CustomParameters = $PSBoundParameters.Keys | Where-Object -FilterScript { $_ -notin $CommonParameters }

    $htmltagparams = @{}
    $tagname = "template"
    if($CustomParameters){

        foreach ($entry in $CustomParameters){

            if($entry -eq "content"){


                $htmltagparams.$entry = $PSBoundParameters[$entry]
            }else{
                $htmltagparams.$entry = "{0}" -f $PSBoundParameters[$entry]
            }


        }

        if($Attributes){
            $htmltagparams += $Attributes
        }

    }
    Set-HtmlTag -TagName $tagname -Attributes $htmltagparams -TagType Void

}
