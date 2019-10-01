function Write-PSHTMLMenu {
    <#
    .SYNOPSIS
        Generate a New Menu.
    .DESCRIPTION
        With this function you can generate a Menubar out of a Hashtable.
    .EXAMPLE 
    Create the Hashtables. You have to use the Names of the Keys
        $Hash1 = @{
            Content        = "top"
            href      = "https://plop.com/Home"
            Style   ="Height: 5px;"
            Id      = "nav_home_top"
            Class   = "TestClass2"
            Target      = "_self"
        }

        $Hash2 = @{
            Content        = "Contact"
            href      = "https://testwebsite.com/Contact"
            Style   ="Height: 5px;"
            Id      = "nav_home_contact"
            Class   = "Class001"
            Target      = "_Parent"
            Attributes = @{
                'Plop' = 'rop'
                'wep'  = 'sep'
            }
        }

        $arr = @()
        $arr += $Hash1
        $arr += $Hash2

    #Create a Menublock
        New-PSHTMLMenu -InputValues $arr -NavClass "JustAClass" -NavId "Menu_top" -NavStyle "display:block;"
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
        [String]$NavClass,
        [String]$NavId,
        [AllowEmptyString()]
        [AllowNull()]
        [String]$NavStyle,
        [Hashtable]$NavAttributes,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$ulClass,
        [String]$ulId,
        [AllowEmptyString()]
        [AllowNull()]
        [String]$ulStyle,
        [Hashtable]$ulAttributes,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$LiClass,
        [String]$liId,
        [AllowEmptyString()]
        [AllowNull()]
        [String]$liStyle,
        [Hashtable]$liAttributes


    )
    
    begin {
        $options = @()
    }
    
    process {

        $BoundParameters = $PSBoundParameters

        nav -Content {

            ul -Content {

                Foreach($Link in $InputValues){
                    li -Content {

                        a @link
                    }
                } 
            } -Class $ulClass -Id $ulId -Style $ulStyle -Attributes $ulAttributes

        } -Class $NavClass -Id $NavId -Style $NavStyle -Attributes $NavAttributes

    }
    
    end {
        $options -join ''
    }
}