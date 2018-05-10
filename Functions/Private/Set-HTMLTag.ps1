Function Set-HtmlTag {
    <#
    
    .EXAMPLE
    Set-HtmlTag -TagName div -Attributes @{"Class"="myClass123"}

    .NOTES
    Current version 0.7
       History:
            2018.05.07;stephanevg;Creation

    #>
    [Cmdletbinding()]
    Param(
        
        [system.web.ui.HtmlTextWriterTag]
        $TagName,
        
        [HashTable]
        $Attributes,

        [ValidateSet("block","Inline")]
        $TagType,


        $Content
    )

        $attr = ""
        $CommonParameters = ("Attributes", "Content","tagname") + [System.Management.Automation.PSCmdlet]::CommonParameters + [System.Management.Automation.PSCmdlet]::OptionalCommonParameters
        $CustomParameters = $PSBoundParameters.Keys | ? { $_ -notin $CommonParameters }
        
        if($CustomParameters){
            
            foreach ($entry in $CustomParameters){

                
                $Attr += "{0}=`"{1}`" " -f $entry,$PSBoundParameters[$entry]
    
            }
                
        }

        if($Attributes){
            foreach($entry in $Attributes.Keys){
                if($entry -eq "content"){
                    continue
                }
                $attr += "{0}=`"{1}`" " -f $entry,$Attributes[$Entry]
            }
        }

        if($attr){
            "<{0} {1} >"  -f $tagname,$attr
        }else{
            "<{0}>" -f $tagname
        }
        
      

        if($Attributes.Keys -contains "content"){

            if($Attributes['content'] -is [System.Management.Automation.ScriptBlock]){
                $Attributes['content'].Invoke()
            }else{
                $Attributes['content']
            }
        }
            

        "</{0}>" -f $tagname

}