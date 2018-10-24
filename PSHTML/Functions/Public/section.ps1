Function section {
    <#
    .SYNOPSIS
    Generates section HTML tag.

    .EXAMPLE

    section -Attributes @{"class"="MyClass";"id"="myid"} -Content {
        h1 "This is a h1"
        P{
            "This paragraph is part of a section with id 'myid'"
        }
    }

    Generates the following code:

    <section class="MyClass" id="myid" >
        <h1>This is a h1</h1>
        <p>
            This paragraph is part of a section with id 'myid'
        </p>
    </section>

    .EXAMPLE

    section -Class "myclass" -Style "section {border:1px dotted black;}" -Content {
        h1 "This is a h1"
        P{
            "This paragraph is part of section with id 'myid'"
        }
    }

    Generates the following code:

    <section Class="myclass" Style="section {border:1px dotted black;}" >
    <h1>This is a h1</h1>
        <p>
        This paragraph is part of section with id 'myid'
        </p>
    </section>
    .LINK
        https://github.com/Stephanevg/PSHTML

    .NOTES
        Current version 2.1
        History:
            2018.10.24;@ChristopheKumor;Modified $htmltagparams filling to version 2.1
            2018.04.10;bateskevin; Updated to version 2.0
            2018.04.10;Stephanevg; Added parameters
            2018.04.01;Stephanevg;Creation.

    #>
    [CmdletBinding()]
    Param(


        [Parameter(Position = 1)]
        [String]$Class,

        [Parameter(Position = 2)]
        [String]$Id,

        [Parameter(Position = 3)]
        [String]$Style,

        [Parameter(Position = 4)]
        [Hashtable]$Attributes,

        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $false,
            Position = 5
        )]
        [scriptblock]
        $Content
    )

    Begin {
        $htmltagparams = @{}
        $tagname = "Section"
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
                if ($PSBoundParameters[$_].IsPresent) { 
                    $htmltagparams.$_ = $null
                }
                else {
                    $htmltagparams.$_ = '{0}' -f $PSBoundParameters[$_]
                }
            }
        }
    }
    End {

        Set-HtmlTag -TagName $tagname -Attributes $htmltagparams -TagType nonVoid
        
    }


}
