Function ul {
    <#
    .SYNOPSIS
    Create a ul tag in an HTML document.
     
    .EXAMPLE
    ul

    .EXAMPLE
    ul -Content {li -Content "asdf"}

    .EXAMPLE
    ul -Class "class" -Id "something" -Style "color:red;"

    .NOTES
    Current version 1.1
       History:
           2018.04.14;stephanevg;fix Content bug. Upgraded to v1.1.
           2018.04.01;bateskevinhanevg;Creation.
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [CmdletBinding()]
    Param(

        [Parameter(
            ValueFromPipeline = $false,
            Mandatory = $false,
            Position = 0
        )]
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
        [Switch]$reversed,

        [Parameter(Position = 6)]
        [string]$start
        
    )
    Process{

        $Attr = ""

        if($reversed){
            $Attr += "reversed " 
        }

        $CommonParameters = ("Attributes", "content","reversed") + [System.Management.Automation.PSCmdlet]::CommonParameters + [System.Management.Automation.PSCmdlet]::OptionalCommonParameters
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
            "<ul {0} >"  -f $attr
        }else{
            "<ul>"
        }
        
      

        if($Content){
    
            if($Content -is [System.Management.Automation.ScriptBlock]){
                $Content.Invoke()
            }else{
                $Content
            }
        }
            

        '</ul>'
    }
    
    
}

