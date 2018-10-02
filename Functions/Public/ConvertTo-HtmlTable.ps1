Function ConvertTo-HTMLTable {
    <#

        .SYNOPSIS
        Converts a powershell object to a HTML table.

        .DESCRIPTION
        This cmdlet is intended to be used when powershell objects should be rendered in an HTML table format.

        .EXAMPLE
        $service = Get-Service -Name Sens,wsearch,wscsvc | Select-Object -Property DisplayName,Status,StartType
        ConvertTo-HTMLtable -Object $service

        .EXAMPLE

        $proc = Get-Process | Select-Object -First 2
        ConvertTo-HTMLtable -Object $proc 
        
        .EXAMPLE

        $proc = Get-Process | Select-Object -First 2
        ConvertTo-HTMLtable -Object $proc -properties name,handles

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
        $Object,
        [String[]]$Properties
    )


    if($Properties){
        $HeaderNames = $Properties
    }else{
        $props = $Object | Get-Member -MemberType Properties | Select-Object Name
        $HeaderNames = @()
        foreach($i in $props){$HeaderNames += $i.name.tostring()}
    }

    Table{

        thead {
            tr{


                foreach($Name in $HeaderNames){

                    td{
                        $Name
                    }
                }
            }
        }
        Tbody{
            foreach($item in $Headernames){
                tr{


                    foreach($propertyName in $Object.$item){

                        td {
                            $propertyName
                        }

                    }
                }
            }
        }
    }
}
