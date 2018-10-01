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
    Version: 1.0.0
    History:
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
        "<hr {0} >"  -f $attr
    }else{
        "<hr>"
    }


}