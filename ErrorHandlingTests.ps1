<#

I have modified the below tags so that they contain try catch around their Set-htmlTag calls.

#>

class ParameterNotFound : Exception {
    ParameterNotFound() {}
    ParameterNotFound([string]$Message) : base($Message) {}
}

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
                        Try{
                            $outcontent = $Parameters[$($PostKey)].Invoke()

                        }Catch{
                            
 
                            $Exception = [Exception]::new("error message")
                            $ErrorRecord = [System.Management.Automation.ErrorRecord]::new(
                                $Exception,
                                "errorID",
                                [System.Management.Automation.ErrorCategory]::NotSpecified,
                                $TargetObject # usually the object that triggered the error, if possible
                            )
#plop
                            $PSCmdlet.ThrowTerminatingError($_)
                        }
                        break
                        
                    }
                    else {
                        Try{
                            $outcontent = $Parameters[$($PostKey)]
                        }Catch{
                            $PSCmdlet.ThrowTerminatingError($_)
                        }
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

Function Div {
    <#
        .SYNOPSIS
        Generates a DIV HTML tag.

        .EXAMPLE
        The following exapmles show cases how to create an empty div, with a class, an ID, and, custom attributes.
        div -Class "myclass1 MyClass2" -Id myid -Attributes @{"custom1"='val1';custom2='val2'}

        Generates the following code:

        <div Class="myclass1 MyClass2" Id="myid" custom1="val1" custom2="val2"  >
        </div>


        .NOTES
        Current version 2.0
        History:
        2018.10.30;@ChristopheKumor;Updated to version 3.0
            2018.10.02;bateskevin; Updated to v2.0
            2018.04.10;Stephanevg; Added parameters
            2018.04.01;Stephanevg;Creation.
        .LINK
            https://github.com/Stephanevg/PSHTML
    #>

    Param(

        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $false,
            Position = 0
        )]
        $Content,

        [Parameter(Position = 1)]
        [String]$Class,

        [Parameter(Position = 2)]
        [String]$Id,

        [Parameter(Position = 3)]
        [String]$Style,

        [Parameter(Position = 4)]
        [Hashtable]$Attributes
    )
    Process {

        $tagname = "div"

        Try{
            Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid -ErrorAction Stop

        }Catch{
            $PSCmdlet.ThrowTerminatingError($_)

        }
    }


}

Function a {
    <#
        .SYNOPSIS

        Generates a <a> HTML tag.
        The <a> tag defines a hyperlink, which is used to link from one page to another.
        
        .DESCRIPTION

        The most important attribute of the <a> element is the href attribute, which indicates the link's destination.

        .PARAMETER HREF
            Specify where the link should point to (Destination).

        .PARAMETER TARGET
        
        Specify where the new page should open to.
        
        Should be one of the following values:
        "_self","_blank","_parent","_top"


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
        The following exapmles show cases how to create an empty a, with a class, an ID, and, custom attributes.
        
        a -Class "myclass1 MyClass2" -Id myid -Attributes @{"custom1"='val1';custom2='val2'}

        Generates the following code:

        <a Class="myclass1 MyClass2" Id="myid" custom1="val1" custom2="val2"  >
        </a>


        .NOTES
        Current version 3.1
        History:
            2018.10.30;@Stephanevg;Updated to version 3.1
            2018.10.30;@ChristopheKumor;Updated to version 3.0
            2018.09.30;Stephanevg;Updated to version 2.0
            2018.04.10;Stephanevg; Added parameters
            2018.04.01;Stephanevg;Creation.
        .LINK
            https://github.com/Stephanevg/PSHTML
    #>

    Param(

        [Parameter(Mandatory = $false)]
        [AllowEmptyString()]
        [AllowNull()]
        $Content,

        [Parameter(Mandatory = $true)]
        [String]$href,

        [ValidateSet("_self", "_blank", "_parent", "_top")]
        [String]$Target,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class,

        [String]$Id,
        
        [String]$Style,

        [Hashtable]$Attributes

    )
    $tagname = "a"

    if(!($Target)){
          
        $PSBoundParameters.Target = "_self"
    }

    Try{
        Set-htmltag -TagName $tagName -Parameters $PSBoundParameters -TagType NonVoid -ErrorAction Stop

    }CAtch{
        $PSCmdlet.ThrowTerminatingError($_)
    }
    
    

}

Function p {
    <#
    .SYNOPSIS
    Create a p tag in an HTML document.

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

    p
    .EXAMPLE
    p "woop1" -Class "class"

    .EXAMPLE
    p "woop2" -Class "class" -Id "Something"

    .EXAMPLE
    p "woop3" -Class "class" -Id "something" -Style "color:red;"

    .EXAMPLE
    p {
        $Important = strong{"This is REALLY important"}
        "This is regular test in a paragraph " + $Important
    }

    Generates the following code

    <p>
    This is regular test in a paragraph <strong>"This is REALLY important"</strong>
    </p>

    .NOTES
    Current version 3.1.0
       History:
            2018.11.1; Stephanevg;Updated to version 3.1
            2018.10.30;@ChristopheKumor;Updated to version 3.0
            2018.04.10;Stephanevg;Updated content (removed string, added if for selection between scriptblock and string).
            2018.04.01;bateskevinhanevg;Creation.
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [Cmdletbinding()]
    Param(
        [Parameter(Mandatory = $false)]
        [AllowEmptyString()]
        [AllowNull()]
        $Content,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class,

        [String]$Id,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Style,

        [String]$title,

        [Hashtable]$Attributes
    )
    
    $tagname = "p"
 
    try{
        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType NonVoid -ErrorAction Stop

    }CAtch{
        $PSCmdlet.ThrowTerminatingError($_)
    }

}

div{

    div {
        p{
            a -href "eee" -Content {1/0} -ErrorAction Stop
            try{
    
            }Catch {
                $PSCmdlet.ThrowTerminatingError($_)
            }
            
        }
    }
}