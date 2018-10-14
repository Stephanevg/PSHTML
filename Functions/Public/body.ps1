Function Body {
    <#
        .SYNOPSIS
        Generates a Body HTML tag.

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
        The following exapmles show cases how to create an empty Body, with a class, an ID, and, custom attributes.
        Body -Class "myclass1 MyClass2" -Id myid -Attributes @{"custom1"='val1';custom2='val2'}

        Generates the following code:

        <Body Class="myclass1 MyClass2" Id="myid" custom1="val1" custom2="val2"  >
        </Body>


        .NOTES
        Current version 2.0
        History:
            2018.04.10;bateskevin; Updated to version 2.0
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
    Process {

        $CommonParameters = @('tagname') + [System.Management.Automation.PSCmdlet]::CommonParameters + [System.Management.Automation.PSCmdlet]::OptionalCommonParameters
        $CustomParameters = $PSBoundParameters.Keys | ? { $_ -notin $CommonParameters }
        
        $htmltagparams = @{}
        $tagname = "Body"

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
        Set-HtmlTag -TagName $tagname -Attributes $htmltagparams -TagType NonVoid   
    }


}