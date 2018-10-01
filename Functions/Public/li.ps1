Function li {
    <#
    .SYNOPSIS
    Create a li tag in an HTML document.
    
    .DESCRIPTION
        he <li> tag defines a list item.

        The <li> tag is used in ordered lists(<ol>), unordered lists (<ul>), and in menu lists (<menu>).
    .EXAMPLE

    li 
    .EXAMPLE
    li "woop1" -Class "class"

    .EXAMPLE
    li "woop2" -Class "class" -Id "Something"

    .EXAMPLE
    li "woop3" -Class "class" -Id "something" -Style "color:red;"

    .EXAMPLE

    The following code snippet will get all the 'snoverism' from www.snoverisms.com and put them in an UL.

        $Snoverisms += (Invoke-WebRequest -uri "http://snoverisms.com/page/2/").ParsedHtml.getElementsByTagName("p") | ? {$_.ClassName -ne "site-description"} | select innerhtml

        ul -id "snoverism-list" -Content {
            Foreach ($snov in $Snoverisms){
            
                li -Class "snoverism" -content {
                    $snov.innerHTML
                }
            } 
        }


    .NOTES
    Current version 1.1
       History:
        2018.04.14;stephanevg;Added Attributes parameter. Upgraded to v1.1.1
        2018.04.14;stephanevg;fix Content bug. Upgraded to v1.1.0
        2018.04.01;bateskevinhanevg;Creation.
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [Cmdletbinding()]
    Param(
        
        [Parameter(Mandatory=$false,Position=0)]
        [AllowEmptyString()]
        [AllowNull()]
        $Content,

        [Parameter(Position = 1)]
        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class="",

        [Parameter(Position = 2)]
        [String]$Id,

        [Parameter(Position = 3)]
        [AllowEmptyString()]
        [AllowNull()]
        [String]$Style,

        [Parameter(Position = 4)]
        [Hashtable]$Attributes,

        [Parameter(Position = 5)]
        [int]$Value
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
            "<li {0} >"  -f $attr
        }else{
            "<li>"
        }
        
      
        if($Content){
    
            if($Content -is [System.Management.Automation.ScriptBlock]){
                $Content.Invoke()
            }else{
                $Content
            }
        }
            
    
        '</li>'



}