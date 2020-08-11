
Class Htmltag {
    [String]$TagName
    #[Object]$Content
    [String]$id
    [String]$Class
    [System.Collections.ArrayList] $Children = [System.Collections.ArrayList]@()

    
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

        return  $StartTag + " {0}" -f '>'

        
    }

    [String]SetEndTag() {

        return "</{0}>" -f $this.TagName
        

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

    [object[]] GetChildren(){
        $a = @()
        foreach( $child in $this.Children ) {
            $a+=$child
            If ( !($child -is [String]) ) {
                $a+=$child.GetChildren()
            }
            
        }
        return $a
    }

    AddChild($Child){
        $this.Children.Add($Child)
    }

    RemoveChild([htmltag]$Child){
        $this.Children.Remove($Child)
    }

    [htmltag]SetContent($Content){
        #$this.Content = $Content
        #$this.AddChild($Content.invoke())
        $Content.Invoke().foreach({
            $this.AddChild($_)
        })
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
    
    ## New Method to return HTML
    [String]GetHtml(){
        $html = $this.SetStartTag()
        Foreach( $child in $this.Children ){
            If ( $child -is [String] ) {
                If ( $html -match '\>$') {
                    $html = $html + $child
                }
            } Else {
                $html = $html+$child.gethtml()
            }
        }
        $html = $html + $this.SetEndTag()
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

function Get-pshtmlOutputPreference {
    return 'static'
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

    If((Get-pshtmlOutputPreference) -eq 'dynamic'){
        return $tag.getHtml()
    }Else{
        #Is static
        return $tag
    }

    

    
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



#Prototype with OutputPreference

$b = div -id "test dynamic" -Class "dynamic" -Content {"Plop"}

$b

$e = div -id 'TopheaderDiv' -Class "class1 class2" -Content {

        div -id "niv2.0" -Class "aaa bbb" -Content {

            p -id "niv3" -Class "ccc eee" -content {
                "11111" 
            }

            p -id "niv3" -Class "ccc eee" -content {
                "22222" 
            }

            p -id "niv3" -Class "ccc eee" -content {
                "333333" 
            }
        }
        div -id "niv2.1" -Class "ccc eee" -content {
            "level 2.1" 
        }
} 

$e
$e.GetChildren()
#$e.generatehtml()

## TRY NEW METHOD
$e.GetHtml()

$array = @(1,2,3,5,67,88,32,33,76)
$a = div -id 'TopheaderDiv' -Class "class1 class2" -Content {

    div -id "niv2.0" -Class "aaa bbb" -Content {


        Foreach($val in $Array){


            p -id "niv_$($val)" -Class "ccc eee" -content {
                "Favorite number is: $($val)" 
            }
        }


        
    }
    div -id "niv2.1" -Class "ccc eee" -content {
        "level 2.1" 
    }
} 

<#

#For some strange reason, this doesn't work:
# $e.Children[1]
$e.Children # Contains two entries but it is not an array: Why??


#>

