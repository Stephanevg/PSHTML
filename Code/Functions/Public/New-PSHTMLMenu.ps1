function New-PSHTMLMenu {
    <#
    .SYNOPSIS
        Generate a New Menu.
    .DESCRIPTION
        With this function you can generate a Menubar out of a Hashtable.
    .EXAMPLE 
    Create the Hashtables. You have to use the Names of the Keys
        $Hash1 = @{
            Adress      = "https://testwebsite.com/home"
            LinkStyle   ="Bold"
            LinkId      = "1"
            Text        = "Home"
            LinkClass   = "TestClass1"
        }

        $Hash2 = @{
            Adress      = "https://testwebsite.com/Contact"
            LinkStyle   ="Thic"
            LinkId      = "2"
            Text        = "Contact"
            LinkClass   = "TestClass2"
        }

        $arr = @()
        $arr += $Hash1
        $arr += $Hash2
    .EXAMPLE 
    Create a Menublock
        New-PSHTMLMenu -InputValues $arr -Class "JustAClass" -Id "2" -Style "thin"
    .INPUTS
        Inputs (if any)
    .OUTPUTS
        Output (if any)
    .NOTES
        Author: BatesKevin
    #>
    [CmdletBinding(DefaultParameterSetName='Classic')]
    param (
        [Parameter(Mandatory=$True,ValueFromPipeline=$True)]
        [Array]$InputValues,
        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class = "",
        [String]$Id,
        [AllowEmptyString()]
        [AllowNull()]
        [String]$Style,
        [Hashtable]$Attributes

    )
    
    begin {
        $options = @()
    }
    
    process {

        $BoundParameters = $PSBoundParameters

        Div {

            Foreach($Link in $InputValues){
                a -Content $Link.Text -href $Link.Adress -Class $Link.LinkClass -Id $LInk.LinkId -Style $LInk.LinkStyle
            }

        } -Class $Class -Id $Id -Style $Style -Attributes $Attributes

    }
    
    end {
        $options -join ''
    }
}