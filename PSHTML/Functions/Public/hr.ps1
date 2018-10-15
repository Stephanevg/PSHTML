Function hr {
    <#
    .SYNOPSIS
    Create a hr title in an HTML document.

    .EXAMPLE

    hr

    #Generates the following code:

    <hr>

    .EXAMPLE

    hr -Attributes @{"Attribute1"="val1";"Attribute2"="val2"}

    Generates the following code

    <hr Attribute1="val1" Attribute2="val2"  >

    .EXAMPLE

    $Style = "font-family: arial; text-align: center;"
    hr -Style $style

    Generates the following code

    <hr Style="font-family: arial; text-align: center;"  >

    .Notes
    Author: Stéphane van Gulick
    Version: 2.0.0
    History:
        2018.04.08;bateskevin; Updated to v2.0 
        2018.04.08;Stephanevg; Updated to version 1.0: Updated content block to support string & ScriptBlock
        2018.03.25;@Stephanevg; Added Styles, ID, CLASS attributes functionality
        2018.03.25;@Stephanevg; Creation
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [Cmdletbinding()]
    Param(

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class,

        [String]$Id,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Style,

        [Hashtable]$Attributes
    )

    Process {

        $CommonParameters = @('tagname') + [System.Management.Automation.PSCmdlet]::CommonParameters + [System.Management.Automation.PSCmdlet]::OptionalCommonParameters
        $CustomParameters = $PSBoundParameters.Keys | ? { $_ -notin $CommonParameters }
        
        $htmltagparams = @{}
        $tagname = "hr"

        if ($CustomParameters) {

            foreach ($entry in $CustomParameters) {


                if ($entry -eq "content") {

                    
                    $htmltagparams.$entry = $PSBoundParameters[$entry]
                }
                else {
                    $htmltagparams.$entry = "{0}" -f $PSBoundParameters[$entry]
                }
                
    
            }

            if ($Attributes) {
                $htmltagparams += $Attributes
            }


        }
        Set-HtmlTag -TagName $tagname -Attributes $htmltagparams -TagType nonVoid
        
    }

}