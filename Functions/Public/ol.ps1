Function ol {
    <#
    .SYNOPSIS
    Create a ol tag in an HTML document.
     
    .EXAMPLE
    ol

    .EXAMPLE
    ol -Content {li -Content "asdf"}

    .EXAMPLE
    ol -Class "class" -Id "something" -Style "color:red;"

    .NOTES
    Current version 1.0
       History:
           2018.04.01;bateskevinhanevg;Creation.

    #>
    [CmdletBinding()]
    Param(

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
        [string]$start,

        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $false,
            Position = 7
        )]
        [scriptblock]
        $Content
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
            "<ol {0} >"  -f $attr
        }else{
            "<ol>"
        }
        
      

        if($Content){
            $Content.Invoke()
        }
            

        '</ol>'
    }
    
    
}

