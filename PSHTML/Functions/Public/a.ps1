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
        Current version 2.1
        History:
            2018.10.24;@ChristopheKumor;Modified $htmltagparams filling to version 2.1
            2018.09.30;Stephanevg;Updated to version 2.0
            2018.04.10;Stephanevg; Added parameters
            2018.04.01;Stephanevg;Creation.
        .LINK
            https://github.com/Stephanevg/PSHTML
    #>

    Param(

        [Parameter(Mandatory = $false, Position = 0)]
        [AllowEmptyString()]
        [AllowNull()]
        $Content,

        [Parameter(Mandatory = $true)]
        [String]$href,

        [ValidateSet("_self", "_blank", "_parent", "_top")]
        [String]$Target = "_self",

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class,

        [String]$Id,
        
        [String]$Style,

        [Hashtable]$Attributes

    )
    Begin {
        $CommonParameters = [System.Management.Automation.PSCmdlet]::CommonParameters + [System.Management.Automation.PSCmdlet]::OptionalCommonParameters
        $htmltagparams = @{}
        $tagname = "a"
    }
    Process {



        foreach ($paramkey in $MyInvocation.MyCommand.Parameters.Keys) {
            $paramvalue = Get-Variable $paramkey -ValueOnly -EA SilentlyContinue
            if ($paramvalue -and !$PSBoundParameters.ContainsKey($paramkey)) {
                $htmltagparams.$paramkey = $paramvalue
            }
        }
        
        switch ($PSBoundParameters.Keys) {
            'content' { 
                if ($PSBoundParameters['content'] -is [System.Management.Automation.ScriptBlock]) {
                    $htmltagparams.$_ = $PSBoundParameters[$_]
                    continue
                }
                elseif ($null -eq $htmltagparams.$_) {
                    $htmltagparams.$_ = @($PSBoundParameters[$_])
                    continue   
                }
                else {
                    $htmltagparams.$_ += $PSBoundParameters[$_] 
                    continue
                }
            }
            'Attributes' { 
                if ($null -eq $htmltagparams.$_) {
                    $htmltagparams.$_ += $PSBoundParameters[$_]
                }
                continue
            }
            default { 
                if ($_ -notin $CommonParameters) {
            
                    if ($PSBoundParameters[$_].IsPresent) { 
                    $htmltagparams.$_ = $null
                }
                else {
                    $htmltagparams.$_ = '{0}' -f $PSBoundParameters[$_]
                }

            }
            }
        }
    }
    End {

        Set-HtmlTag -TagName $tagname -Attributes $htmltagparams -TagType nonVoid

    }
}
