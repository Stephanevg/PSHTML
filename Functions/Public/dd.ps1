Function dd {
    <#
    .SYNOPSIS
    Create a dd tag in an HTML document.
    
    .EXAMPLE

    dd 
    .EXAMPLE
    dd "woop1" -Class "class"

    .EXAMPLE
    dd "woop2" -Class "class" -Id "Something"

    .EXAMPLE
    dd "woop3" -Class "class" -Id "something" -Style "color:red;"

    .NOTES
    Current version 1.0
       History:
           2018.04.01;bateskevinhanevg;Creation.

    #>
    [Cmdletbinding()]
    Param(
        [Parameter(Mandatory=$true)]
        [AllowEmptyString()]
        [AllowNull()]
        [String]
        $Content,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class="",

        [String]$Id,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Style,

        [String]$value
    )

        $attr = ""
        $CommonParameters = ("Attributes", "content") + [System.Management.Automation.PSCmdlet]::CommonParameters + [System.Management.Automation.PSCmdlet]::OptionalCommonParameters
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
    $return = @"
    <dd $attr>$Content</dd>
"@

}else{

    $return =     @"
    <dd>$Content</dd>
"@
}

return $return

}