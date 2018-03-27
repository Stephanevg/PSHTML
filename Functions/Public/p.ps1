Function P {
    <#
    .SYNOPSIS
    Creates a p (Paragraph) html element
    
    .EXAMPLE
    p {"woop"} -Id "MyId" -Class "MyClass" -Style "MyStyle" 
    
    Generates the following html element:

    <p Id=MyId Class=MyClass style="MyStyle" >
        woop
    </p>

    .EXAMPLE
    $Attributes = @{"hidden"=$true;"lang"="fr"}
    p {
        "woop"
    } -Id "MyId" -Class "MyClass" -Style "MyStyle" -Attributes $Attributes
    
    #>
    [CmdletBinding()]
    Param(
        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $false,
            Position = 0
        )]
        [scriptblock]
        $ChildItem,

        [Parameter(Position = 1)]
        [String]$Class,

        [Parameter(Position = 2)]
        [String]$Id,

        [Parameter(Position = 3)]
        [String]$Style,

        [Parameter(Position = 4)]
        [String]$Title,

        [Hashtable]$Attributes
    )
    Process{

        

        $attr = ""
        foreach ($entry in $PSBoundParameters.Keys){
            switch($entry){
                "Class" {$attr += "Class=$class ";Break}
                "id" {$attr += "Id=$Id ";Break}
                "style" {$attr += "style=`"$Style`" ";Break}
                "Title" {$attr += "title=`"$Title`" ";Break}
                "CustomAttributes" {

                    Foreach($key in $Attributes.Keys){

                        $attr += "$($key)=$($Attributes[$key]) "
             
                    }

                }
                default{}
            }
        }

        

        if($Attributes){
            "<p $Attributes>" 
        }else{
            "<p>"
        }

        if($ChildItem){
            $ChildItem.Invoke()
        }
            

        '</p>'
    }
    
    
}

