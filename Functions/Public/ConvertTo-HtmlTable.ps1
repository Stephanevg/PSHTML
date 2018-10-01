Function ConvertTo-HTMLTable {
    <#

        .SYNOPSIS
        Converts a powershell object to a HTML table.

        .DESCRIPTION
        This cmdlet is intended to be used when powershell objects should be rendered in an HTML table format.

        .EXAMPLE
        $service = Get-Service -Name Sens,wsearch,wscsvc | select DisplayName,Status,StartType
        ConvertTo-HTMLtable -Object $service 

        .EXAMPLE

        $proc = Get-Process | select -First 2
        ConvertTo-HTMLtable -Object $proc

        .NOTES
        Current version 0.6
        History:
           2018.05.09;stephanevg;Creation.
        .LINK
            https://github.com/Stephanevg/PSHTML
    #>
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true,
                ValueFromPipeline=$true
        )]
        $Object
    )

    
    Table{
        
        $Properties = $object | get-member | where-Object -FilterScript {$_.MemberType -eq 'property' -or $_.MemberType -eq 'NoteProperty'}

        thead {
            tr{


                foreach($prop in $Properties.Name){
            
                    td{ 
                        $prop
                    }
                }
            }
        }
        Tbody{
            foreach($item in $object){
                tr{
    
                    
                    foreach($propertyName in $Properties.Name){
        
                        td {
                            $item.$propertyName
                        }
                
                    }
                }
            }
        }
    }
}
