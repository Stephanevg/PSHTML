Function area {
    <#
    .SYNOPSIS
    Generates <area> HTML tag.

    .DESCRIPTION
    The are tag must be used in a <map> element (Use the 'map' function)

    The <area> element is always nested inside a <map> tag.

    More information can be found here --> https://www.w3schools.com/tags/tag_area.asp


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
    area -href "link.php" -alt "alternate description" -coords "0,0,10,10"

   Generates the following code:

    <area href="link.php" alt="alternate description" coords="0,0,10,10" >

    .EXAMPLE
    area -href image.png -coords "0,0,20,20" -shape rect

    Generates the following code:

    <area href="image.png"coords="0,0,20,20"shape="rect" >

    .NOTES
     Current version 2.1
        History:
            2018.10.24;@ChristopheKumor;Modified $htmltagparams filling to version 2.1
            2018.04.10;Stephanevg; Added parameters
            2018.04.01;Stephanevg;Creation.
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [CmdletBinding()]
    Param(


        [Parameter(Position = 0)]
        [String]$href,

        [Parameter(Position = 1)]
        [String]$alt,

        [Parameter(Position = 2)]
        [String]$coords,

        [Parameter(Position = 3)]
        [validateset("default", "rect", "circle", "poly")]
        [String]$shape,

        [Parameter(Mandatory = $false, Position = 4)]
        [ValidateSet("_blank", "_self", "_parent", "top")]
        [String]$target = "_Blank",

        [Parameter(Position = 5)]
        [String]$type,

        [Parameter(Position = 6)]
        [String]$Class,

        [Parameter(Position = 7)]
        [String]$Id,

        [Parameter(Position = 8)]
        [String]$Style,

        [Parameter(Position = 9)]
        [Hashtable]$Attributes


    )
    Begin {
        $CommonParameters = [System.Management.Automation.PSCmdlet]::CommonParameters + [System.Management.Automation.PSCmdlet]::OptionalCommonParameters
        $htmltagparams = @{}
        $tagname = "area"
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

        Set-HtmlTag -TagName $tagname -Attributes $htmltagparams -TagType void

    }#End process


}
