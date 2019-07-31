
Class Htmltag {
    [String]$TagName
    #[Object]$Content
    [String]$id
    [String]$Class
    [System.Collections.ArrayList] $Children = [System.Collections.ArrayList]::new()

    
    htmltag(){

    }

    htmltag([String]$TagName){
        $this.TagName = $TagName
    }

    GetChildren(){

    }

    SetTagName([String]$TagName){
        $this.TagName = $TagName
    }

    [String]SetStartTag(){
        
        $StartTag = "<{0}" -f $this.TagName

        If($this.Id){

            $StartTag = $StartTag + " id='{0}'" -f $this.id
        }

        If($this.Class){

            $StartTag = $StartTag + " class='{0}'" -f $this.class
        }

        return  $StartTag + " {0}" -f '/>'

        
    }

    [String]SetEndTag() {

        return "</{0}>" -f $this.TagName
        

    }

    [htmltag]SetContent($Content){
        $this.Content = $Content
        
        return $this
    }

    [htmltag]SetId($Id){
        $this.Id = $Id
        return $this
    }

    [htmltag]SetClass($Class){
        $this.Class = $Class
        return $this
    }



    [String]GenerateHTML(){
        Throw "Must be inherited"
    }
}

Class htmlParentElement : Htmltag {


    [object] GetChildren(){
        return $this.Children.GetEnumerator()
    }

    AddChild($Child){
        $this.Children.Add($Child)
        #$this.Children += $Child
    
    }

    RemoveChild([htmltag]$Child){
        $this.Children.Remove($Child)
    }

    [htmltag]SetContent($Content){
        #$this.Content = $Content
        $this.AddChild($Content.invoke())
        return $this
    }

    [String]GenerateHtml(){
        
        $html = ''
        
        if($html){

            $Html = $html + $this.SetStartTag()
        }else{
            $Html = $this.SetStartTag()
        }
        
        $arr = $this.GetChildren()

        foreach($Child in $arr){
            
            if($html){

                $Html = $html + $this.SetStartTag()
            }else{
                $Html = $this.SetStartTag()
            }

            If($Child -is [scriptblock]){
                
                $invokedcontent = $Child.Invoke()
                if($html){
                    $html = $html + $invokedcontent
                }else{
                    $html = $invokedcontent
                }
            }elseif($child[0] -is [string]){
                $html = $html + $Child
            }
            Else{
               $html = $Child.GenerateHtml() 
            }

            

        }#end foreach child

        if($html){

            $Html = $html + $this.SetEndTag()
        }else{
            $Html = $this.SetEndTag()
        }

        return $html


    }
}

Class HtmlElement : Htmltag {

    [String]GenerateHtml(){
        $html = ''
        if($html){

            $Html = $html + $this.SetStartTag()
        }else{
            $Html = $this.SetStartTag()
        }

        #$html = $html + $this.Content

        $html = $html + $this.SetEndTag()

        return $html

    }
}


function div {
    Param(
        
        $Content,
        $id,
        $Class
    )

    $TagName = 'div'

    If($Content -is [scriptblock]){
        #Create a parent HTMLElement
        $tag = [htmlParentElement]::New()
    }Else{
        
        $tag = [HtmlElement]::New()
        
    }

    $tag.SetTagName($TagName)

    if($id){
        $tag = $tag.SetId($id)
    }

    if($Class){
        $tag = $tag.SetClass($Class)
    }

    if($Content){
        $tag = $tag.SetContent($Content)
    }


    return $tag

    
}

function p {
    Param(
        
        $Content,
        $id,
        $Class
    )

    $TagName = 'p'

    If($Content -is [scriptblock]){
        #Create a parent HTMLElement
        $tag = [htmlParentElement]::New()
    }Else{
        
        $tag = [HtmlElement]::New()
        
    }

    $tag.SetTagName($TagName)

    if($id){
        $tag = $tag.SetId($id)
    }

    if($Class){
        $tag = $tag.SetClass($Class)
    }

    if($Content){
        $tag = $tag.SetContent($Content)
    }


    return $tag

    
}

<#

The following two examples work well. 
But we have 'ScriptBlocks' as child elements and not HTMLTag.
The nested functionality doesn't work yet as I would like to

#>
#div -id 'rr' -Content "my string div content" -Class "eee rrer"
$e = div -id 'TopheaderDiv' -Class "class1 class2" -Content {

        div -id "niv2.0" -Class "aaa bbb" -Content {

            p id "niv3" -Class "ccc eee" -content {
                "11111" 
            }

            p id "niv3" -Class "ccc eee" -content {
                "22222" 
            }

            p id "niv3" -Class "ccc eee" -content {
                "333333" 
            }
        }
        div -id "niv2.1" -Class "ccc eee" -content {
            "level 2.1" 
        }
} 

$e
$e.GetChildren()
$e.generatehtml()

<#

#For some strange reason, this doesn't work:
# $e.Children[1]
$e.Children # Contains two entries but it is not an array: Why??


#>