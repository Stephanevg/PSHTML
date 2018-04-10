Function area {
    <#
    .SYNOPSIS
    Generates area HTML tag.

    .DESCRIPTION
    The are tag must be used in a <map> element (Use the 'map' function)
    
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
    area -href "link.php" -alt "alternate description" -coords "0,0,10,10"
    
   Generates the following code: 

    <area href="link.php" alt="alternate description" coords="0,0,10,10" >
    
    .EXAMPLE
    area -href image.png -coords "0,0,20,20" -shape rect

    Generates the following code: 

    <area href="image.png"coords="0,0,20,20"shape="rect" >

    .NOTES
     Current version 1.0
        History:
            2018.04.10;Stephanevg; Added parameters
            2018.04.01;Stephanevg;Creation.

    #>
    [CmdletBinding()]
    Param(

        
        [Parameter(Position =0)]
        [String]$href,

        [Parameter(Position =1)]
        [String]$alt,

        [Parameter(Position =2)]
        [String]$coords,

        [Parameter(Position =3)]
        [validateset("default","rect","circle","poly")]
        [String]$shape,

        [Parameter(Mandatory=$false,Position = 4)]
        [ValidateSet("_blank","_self","_parent","top")]
        [String]$target = "_Blank",

        [Parameter(Position =5)]
        [String]$type,

        [Parameter(Position =6)]
        [String]$Class,

        [Parameter(Position = 7)]
        [String]$Id,

        [Parameter(Position =8)]
        [String]$Style,

        [Parameter(Position = 9)]
        [Hashtable]$Attributes


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
            "<area {0} >"  -f $attr
        }else{
            "<area>"
        }
        
      

        if($Content){
            $Content.Invoke()
        }
            

        '</area>'
        

        
    }#End process
    
    
}
