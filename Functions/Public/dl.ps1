Function dl {
    <#
    .SYNOPSIS
    Create a dl tag in an HTML document.
     
    .EXAMPLE
    dl

    .EXAMPLE
    dl -Content {dt -Content "Coffe";dl -Content "Black hot drink"}

    .EXAMPLE
    dl -Class "class" -Id "something" -Style "color:red;"

    .NOTES
    Current version 1.0
       History:
            2018.05.01;Removed reversed as this is not supported.
            2018.04.01;bateskevinhanevg;Creation.
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [CmdletBinding()]
    Param(

        [Parameter(Mandatory=$false,position=0)]
        [AllowEmptyString()]
        [AllowNull()]
        [String]
        $Content,

        [Parameter(Position = 1)]
        [String]$Class,

        [Parameter(Position = 2)]
        [String]$Id,

        [Parameter(Position = 3)]
        [String]$Style,

        [Parameter(Position = 4)]
        [Hashtable]$Attributes,

        [Parameter(Position = 5)]
        [string]$start

    )
    Process{

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
            "<dl {0} >"  -f $attr
        }else{
            "<dl>"
        }
        
      
    
        if($Content){
    
            if($Content -is [System.Management.Automation.ScriptBlock]){
                $Content.Invoke()
            }else{
                $Content
            }
        }
            
    
        '</dl>'
    }
    
    
}
