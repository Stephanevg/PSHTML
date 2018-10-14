Function ConvertTo-HTMLTable {
    <#
.SYNOPSIS
    Converts a powershell object to a HTML table.

.DESCRIPTION
    This cmdlet is intended to be used when powershell objects should be rendered in an HTML table format.

.PARAMETER Object
    Specifies the object to use

.PARAMETER Properties
    Properties you want as table headernames

.PARAMETER Inline
    Force the ouput to be inline. By default output is by column

.EXAMPLE
    $service = Get-Service -Name Sens,wsearch,wscsvc | Select-Object -Property DisplayName,Status,StartType
    ConvertTo-HTMLtable -Object $service

.EXAMPLE
    $proc = Get-Process | Select-Object -First 2
    ConvertTo-HTMLtable -Object $proc 

.EXAMPLE
    $proc = Get-Process | Select-Object -First 2
    ConvertTo-HTMLtable -Object $proc -properties name,handles

    Returns the following HTML code

    <table>
        <thead>
            <tr><td>name</td><td>handles</td></tr></thead>
        <tbody>
            <tr><td>AccelerometerSt</td><td>AgentService</td></tr>
            <tr><td>155</td><td>190</td></tr>
        </tbody>
    </Table>

.EXAMPLE
    $proc = Get-Process | Select-Object -First 2
    ConvertTo-HTMLtable -Object $proc -properties name,handles -Inline

    Returns the following HTML code

    <table>
        <thead>
            <tr>
                <td>name</td>
                <td>handles</td>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>AccelerometerSt</td>
                <td>155</td>
            </tr>
            <tr>
                <td>AgentService</td>
                <td>190</td>
            </tr>
        </tbody>
    </table>

.NOTES
        Current version 0.7
        History:
        2018.05.09;stephanevg;Creation.
        2018.10.14;Christophe Kumor;Update.

.LINK
    https://github.com/Stephanevg/PSHTML
#>
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        $Object,
        [String[]]$Properties,
        [Switch]$Inline
    )


    if ($Properties) {
        $HeaderNames = $Properties
    }
    else {
        $props = $Object | Get-Member -MemberType Properties | Select-Object Name
        $HeaderNames = @()
        foreach ($i in $props) {
            $HeaderNames += $i.name.tostring()
        }
    }

    table {

        thead {

            tr {

                foreach ($Name in $HeaderNames) {

                    td {
                        $Name
                    }

                }

            }

        }

        tbody {

            if ($PSBoundParameters['Inline']) {
                foreach ($item in $Object) {

                    tr {

                        foreach ($propertyName in $HeaderNames) {

                            td {
                                $item.$propertyName
                            }

                        }

                    }
                }
            }
            else {
                foreach ($item in $Headernames) {

                    tr {

                        foreach ($propertyName in $Object.$item) {

                            td {
                                $propertyName
                            }

                        }

                    }
                }
            }

        }
    }
}



