Function pre {
    <#
    .SYNOPSIS
    Create a pre tag in an HTML document.
    
    .EXAMPLE

    pre 
    .EXAMPLE
    pre -Content @"

        whatever 
        it       is

        you ne  ed
    "@

    .EXAMPLE
    pre -class "classy" -style "stylish" -Content @"

        whatever 
        it       is

        you ne  ed
    "@

    .NOTES
    Current version 1.0
       History:
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
    <pre $attr>
        $Content
    </pre>
"@

}else{

    $return =     @"
    <pre>
        $Content
    </pre>
"@
}

return $return

}