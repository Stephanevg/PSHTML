Function address {
    <#
    .SYNOPSIS

    Generates <address> HTML tag.
    
    
    .DESCRIPTION
    The <address> tag defines the contact information for the author/owner of a document or an article.

    If the <address> element is inside the <body> element, it represents contact information for the document.

    If the <address> element is inside an <article> element, it represents contact information for that article.

    The text in the <address> element usually renders in italic. Most browsers will add a line break before and after the address element.


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

    address {
        $twitterLink = a -href "http://twitter/stephanevg" -Target _blank -ChildItem {"@stephanevg"}
        $bloglink = a -href "http://www.powershelldistrict.com" -Target _blank -ChildItem {"www.powershelldistrict.com"}
        "written by: Stephane van Gulick"
        "blog: $($bloglink)";
        "twitter: $($twitterLink)"
    }

    Generates the following code:

    <address>
        written by: Stephane van Gulick
        blog: <a href=http://www.powershelldistrict.com target="_blank" > www.powershelldistrict.com </a>
        twitter: <a href=http://twitter/stephanevg target="_blank" > @stephanevg </a>
    </address>

    .NOTES
     Current version 2.0
        History:
            2018.09.30;Stephanevg; Updated to version 2.0
            2018.04.10;Stephanevg; Added parameters
            2018.04.01;Stephanevg;Creation.
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [CmdletBinding()]
    Param(

        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $false,
            Position = 0
        )]
        [scriptblock]
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
    Process{


        $CommonParameters = @('tagname') + [System.Management.Automation.PSCmdlet]::CommonParameters + [System.Management.Automation.PSCmdlet]::OptionalCommonParameters
        $CustomParameters = $PSBoundParameters.Keys | ? { $_ -notin $CommonParameters }
        
        $htmltagparams = @{}
        $tagname = "address"

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
        Set-HtmlTag -TagName $tagname -Attributes $htmltagparams -TagType nonVoid


    }


}
