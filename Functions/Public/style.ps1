Function style {
    <#
    .SYNOPSIS
    Create a style title in an HTML document.
    
    .EXAMPLE

    style 
    .EXAMPLE
    style "woop1" -Class "class"

    .EXAMPLE
    $css = @"
        "p {color:green;} 
        h1 {color:orange;}"
    "@
    style {$css} -media "print" -type "text/css"

    .Notes
    Author: Stéphane van Gulick
    Version: 1.0.0
    History:
        2018.05.09;@Stephanevg; Creation

    #>
    [Cmdletbinding()]
    Param(
        [Parameter(Mandatory=$false)]
        [AllowEmptyString()]
        [AllowNull()]
        $Content,

        [String]$media,

        [String]$Type,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class,

        [String]$Id,
        
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
        "<style {0} >"  -f $attr
    }else{
        "<style>"
    }
    
  
    if($Content){

        if($Content -is [System.Management.Automation.ScriptBlock]){
            $Content.Invoke()
        }else{
            $Content
        }
    }
        

    '</style>'

}