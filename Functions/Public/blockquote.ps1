Function blockquote {
    <#
    .SYNOPSIS
    Create a blockquote tag in an HTML document.

    .EXAMPLE
    blockquote -cite "https://www.google.com" -Content @"
        Google is a
        great website
        to search for information
    "@

    .EXAMPLE
    blockquote -cite "https://www.google.com" -class "classy" -style "stylish" -Content @"
        Google is a
        great website
        to search for information
    "@

    .NOTES
    Current version 1.0
       History:
            2018.05.07;stephanevg;updated to version 1.0
            2018.04.01;bateskevinhanevg;Creation.
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [Cmdletbinding()]
    Param(
        [Parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [AllowNull()]
        [String]
        $Content,

        [string]$cite,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class="",

        [String]$Id,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Style,

        [String]$title,

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
            "<blockquote {0} >"  -f $attr
        }else{
            "<blockquote>"
        }



        if($Content){
            $Content.Invoke()
        }


        '</blockquote>'

}