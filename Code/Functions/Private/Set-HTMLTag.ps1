Function Set-HtmlTag {
    <#
    .Synopsis
        This function is the base function for all the html elements in pshtml.

    .Description
        although it can be this function is not intended to be used directly.
    .EXAMPLE
    Set-HtmlTag -TagName div -PSBParameters $PSBoundParameters -MyCParametersKeys $MyInvocation.MyCommand.Parameters.Keys

    .EXAMPLE
    Set-HtmlTag -TagName style -PSBParameters $PSBoundParameters -MyCParametersKeys $MyInvocation.MyCommand.Parameters.Keys

    .NOTES
    Current version 3.1
        History:
            2018.10.24;@ChristopheKumor;include tag parameters to version 3.0
            2018.05.07;stephanevg;
            2018.05.07;stephanevg;Creation
    #>
    [Cmdletbinding()]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSProvideCommentHelp", "", Justification = "Manipulation of text")]
    Param(

        [Parameter(Mandatory=$True)]
        $TagName,

        [Parameter(Mandatory=$True)]
        $Parameters,

        [Parameter(Mandatory=$true)]
        [ValidateSet('void', 'NonVoid')]
        $TagType,

        [Parameter(Mandatory=$False)]
        $Content
    )

    Begin {

        Function GetCustomParameters {
            [CmdletBinding()]
            Param(
                [HashTable]$Parameters
            )
    
            $CommonParameters = [System.Management.Automation.PSCmdlet]::CommonParameters + [System.Management.Automation.PSCmdlet]::OptionalCommonParameters
            $CleanedHash = @{}
            foreach($key in $Parameters.Keys){
                if(!($key -in $CommonParameters)){
                    $CleanedHash.$Key = $Parameters[$key]
                }
            }
            if(!($CleanedHash)){
                write-verbose "[GetCustomParameters] No custom parameters passed."
            }
            Return $cleanedHash
    }
        $CommonParameters = [System.Management.Automation.PSCmdlet]::CommonParameters + [System.Management.Automation.PSCmdlet]::OptionalCommonParameters
    }
    Process {
        $attr = $output = ''
        $outcontent = ''

        $AttributesToSkip = "Content","Attributes","httpequiv","content_tag"


        $Attributes = GetCustomParameters -parameters $Parameters


        $KeysToPostProcess = @()
        foreach ($key in $Attributes.Keys) {
            if($key -notin $AttributesToSkip){

                $attr += '{0}="{1}" ' -f $key, $Attributes[$key]
            }else{
                $KeysToPostProcess += $Key 
            }
        }

        

        foreach($PostKey in $KeysToPostProcess){

            switch ($PostKey) {
                'Content' { 
                    if ($Parameters[$($PostKey)] -is [System.Management.Automation.ScriptBlock]) {
                        $outcontent = $Parameters[$($PostKey)].Invoke()
                        break
                    }
                    else {
                        $outcontent = $Parameters[$($PostKey)]
                        break
                    }
                }
                'Attributes' { 
    
                    foreach ($entry in $Parameters['Attributes'].Keys) {
                        if ($entry -eq 'content' -or $entry -eq 'Attributes') {
                            write-verbose "[Set-HTMLTAG] attribute $($entry) is a reserved value, and should not be passed in the Attributes HashTable"
                            continue
                        }
                        $attr += '{0}="{1}" ' -f $entry, $Parameters['Attributes'].$entry
                    }

                    continue
                }
                'httpequiv' {
                    $attr += 'http-equiv="{0}" ' -f $Parameters[$PostKey]
                    continue
                }
                'content_tag' {
                    $attr += 'content="{0}" ' -f $Parameters[$PostKey]
                    continue
                }
                default { 
                
                    write-verbose "[SET-HTMLTAG] Not found"
    
                }
            }
        }




    #Generating OutPut string
        #$TagBegin - TagAttributes - <TagContent> - TagEnd
        

        $TagBegin = '<{0}' -f $TagName

    
        if($tagType -eq 'nonvoid'){
            $ClosingFirstTag = ">"
            $TagEnd = '</{0}>' -f $tagname
        }else{
            $ClosingFirstTag = "/>"
        }
        
        
        if($attr){

            $TagAttributes = ' {0} {1} ' -f  $attr,$ClosingFirstTag
        }else{
            $TagAttributes = ' {0}' -f  $ClosingFirstTag
        }

        #Fix to avoid a additional space before the content
        $TagAttributes = $TagAttributes.TrimEnd(" ")
    
        if($null -ne $outcontent){

            $TagContent = -join $outcontent 
        }

        $Data = $TagBegin + $TagAttributes + $TagContent + $TagEnd


        return $Data

    }
}
