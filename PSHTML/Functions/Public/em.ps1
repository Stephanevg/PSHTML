Function em {
    <#
    .SYNOPSIS
    Generates em HTML tag.

    .Description
    This tag is a phrase tag. It renders as emphasized text.

    .EXAMPLE
    p{
        "This is";em {"cool"}
    }

    Will generate the following code

    <p>
        This is
        <em>
        cool
        </em>
    </p>

    .Notes
    Author: Andrew Wickham
    Version: 2.0.0
    History:
        2018.10.04;@awickham10; Creation

    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [CmdletBinding()]
    Param(

        [Parameter(
            ValueFromPipeline = $true,
            Position = 0
        )]
        [object]$Content,

        [Parameter(Position = 1)]
        [String]$Class,

        [Parameter(Position = 2)]
        [String]$Id,

        [Parameter(Position = 3)]
        [String]$Style,

        [Parameter(Position = 4)]
        [Hashtable]$Attributes

    )
    $CommonParameters = @('tagname') + [System.Management.Automation.PSCmdlet]::CommonParameters + [System.Management.Automation.PSCmdlet]::OptionalCommonParameters
    $CustomParameters = $PSBoundParameters.Keys | Where-Object -FilterScript { $_ -notin $CommonParameters }


    $htmltagparams = @{}
    $tagname = "em"
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