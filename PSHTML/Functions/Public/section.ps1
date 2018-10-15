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
        Current version 2.0
        History:
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
    Process {

        $CommonParameters = @('tagname') + [System.Management.Automation.PSCmdlet]::CommonParameters + [System.Management.Automation.PSCmdlet]::OptionalCommonParameters
        $CustomParameters = $PSBoundParameters.Keys | ? { $_ -notin $CommonParameters }
        
        $htmltagparams = @{}
        $tagname = "Section"

        if ($CustomParameters) {

            foreach ($entry in $CustomParameters) {


                if ($entry -eq "content") {

                    
                    $htmltagparams.$entry = $PSBoundParameters[$entry]
                }
                else {
                    $htmltagparams.$entry = "{0}" -f $PSBoundParameters[$entry]
                }
                
    
            }

            if ($Attributes) {
                $htmltagparams += $Attributes
            }


        }
        Set-HtmlTag -TagName $tagname -Attributes $htmltagparams -TagType nonVoid
        
    }


}
