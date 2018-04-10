Function dl {
    <#
    .SYNOPSIS
    Create a ol tag in an HTML document.
     
    .EXAMPLE
    dl

    .EXAMPLE
    dl -Content {dt -Content "Coffe";dd -Content "Black hot drink"}

    .EXAMPLE
    dl -Class "class" -Id "something" -Style "color:red;"

    .Notes
    Author: Kevin Bates
    Version: 0.1.0
    History:
        @bateskevin;v0.1.0;40/10/2018;creation

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
            "<dl {0} >"  -f $attr
        }else{
            "<dl>"
        }
        
      

        if($Content){
            $Content.Invoke()
        }
            

        '</dl>'
    }
    
    
}

