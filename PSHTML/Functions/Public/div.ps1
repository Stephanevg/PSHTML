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
        Current version 2.1
        History:
            2018.10.24;@ChristopheKumor;Modified $htmltagparams filling to version 2.1
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
        [scriptblock]
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
    Begin {
        $CommonParameters = [System.Management.Automation.PSCmdlet]::CommonParameters + [System.Management.Automation.PSCmdlet]::OptionalCommonParameters
        $htmltagparams = @{}
        $tagname = "div"
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

        Set-HtmlTag -TagName $tagname -Attributes $htmltagparams -TagType NonVoid   
    }


}