Function nav {
    <#
    .SYNOPSIS
    Generates nav HTML tag.

    .EXAMPLE

    nav -Content {
        a -href "\home.html" -Target _blank
        a -href "\about.html" -Target _blank
        a -href "\blog.html" -Target _blank
        a -href "\contact.html" -Target _blank
    }

    Generates the following code:

    <nav>
        <a href=\home.html target="_blank" ></a>
        <a href=\about.html target="_blank" ></a>
        <a href=\blog.html target="_blank" ></a>
        <a href=\contact.html target="_blank" ></a>
    </nav>

    .EXAMPLE

    It is also possible to use regular powershell logic inside a scriptblock. The example below, generates a nav element
    based on values located in a array. The various links are build using a foreach loop.

    $Pages = "home.html","login.html","about.html"
    nav -Content {
        foreach($page in $pages){
            a -href "\$($page)" -Target _blank
        }

    } -Class "mainnavigation" -Style "border 1px"

    Generates the following code:

    <nav Class="mainnavigation" Style="border 1px" >
        <a href=\home.html target="_blank" >
        </a>
        <a href=\login.html target="_blank" >
        </a>
        <a href=\about.html target="_blank" >
        </a>
    </nav>

    .Notes
    Author: Stéphane van Gulick
    Version: 2.0.0
    History:
        2018.05.09;@Stephanevg; Creation
        2018.05.21;@Stephanevg; Updated function to use New-HTMLTag

    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [CmdletBinding()]
    Param(

        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $true,
            Position = 0
        )]
        [scriptblock]$Content,

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
    $tagname = "nav"
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


