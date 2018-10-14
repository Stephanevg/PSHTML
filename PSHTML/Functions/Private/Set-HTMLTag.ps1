Function Set-HtmlTag {
    <#
    .Synopsis
        This function is the base function for all the html elements in pshtml.

    .Description
        although it can be this function is not intended to be used directly.
    .EXAMPLE
    Set-HtmlTag -TagName div -Attributes @{"Class"="myClass123"}

    .EXAMPLE
    Set-HtmlTag -TagName style -Attributes @{"Class"="myClass123"}

    .NOTES
    Current version 0.7
       History:
            2018.05.07;stephanevg;Creation
    #>
    [Cmdletbinding()]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSProvideCommentHelp", "", Justification="Manipulation of text")]
    Param(

        #[system.web.ui.HtmlTextWriterTag]
        $TagName,

        [HashTable]
        $Attributes,

        [ValidateSet("void","NonVoid")]
        $TagType,


        $Content
    )

        $attr = ""
        $CommonParameters = ("Attributes", "Content","tagname","tagtype") + [System.Management.Automation.PSCmdlet]::CommonParameters + [System.Management.Automation.PSCmdlet]::OptionalCommonParameters
        $CustomParameters = $PSBoundParameters.Keys | Where-Object -FilterScript { $_ -notin $CommonParameters }
        $par = $PSBoundParameters
        if($CustomParameters){

            foreach ($entry in $CustomParameters){


                $Attr += "{0}=`"{1}`" " -f $entry,$PSBoundParameters[$entry]

            }

        }

        if($Attributes){
            foreach($entry in $Attributes.Keys){
                if($entry -eq "content" -or $entry -eq "Attributes"){
                    continue
                }
                $attr += "{0}=`"{1}`" " -f $entry,$Attributes[$Entry]
            }
        }

        if($Attributes.Attributes){
            foreach($at in $Attributes.Attributes.keys){

                $attr += "{0}=`"{1}`" " -f $at,$Attributes.Attributes[$at]
            }
        }

        if($TagType -eq "void"){
            $Closingtag = "/"
            if($attr){
                "<{0} {1} {2}>"  -f $tagname,$attr,$Closingtag
            }else{
                "<{0} {1}>" -f $tagname,$Closingtag
            }
        }else{
            #tag is of type "non-void"

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





}
