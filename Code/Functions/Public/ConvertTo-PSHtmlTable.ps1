function ConvertTo-PSHTMLTable {
    
    <#
    .SYNOPSIS
        Converts a powershell object to a HTML table.
    
    .DESCRIPTION
        This cmdlet is intended to be used when powershell objects should be rendered in an HTML table format.
    
    .PARAMETER Object
        Specifies the object to use
    
    .PARAMETER Properties
        Properties you want as table headernames
    
    .EXAMPLE
        $service = Get-Service -Name Sens,wsearch,wscsvc | Select-Object -Property DisplayName,Status,StartType
        ConvertTo-PSHTMLtable -Object $service
    
    .EXAMPLE
        $proc = Get-Process | Select-Object -First 2
        ConvertTo-PSHTMLtable -Object $proc 
    
    .EXAMPLE
        $proc = Get-Process | Select-Object -First 2
        ConvertTo-PSHTMLtable -Object $proc -properties name,handles
    
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
            Current version 0.7.1
            History:
            2019.02.14;LxLeChat;Miaou
            2018.05.09;stephanevg;Made Linux compatible (changed Get-Serv).
            2018.10.14;Christophe Kumor;Update.
            2018.05.09;stephanevg;Creation.
            
    
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        $Object,
        [String[]]$Properties,
        [String]$Caption,

        [String]$TableID,
        [String]$TableClass,
        [String]$TableStyle,
        [HashTable]$TableAttributes,

        [String]$TheadId,
        [String]$TheadClass,
        [String]$TheadStyle,
        [HashTable]$TheadAttributes,

        [String]$TBodyId,
        [String]$TBodyClass,
        [String]$TBodyStyle,
        [HashTable]$TBodyAttributes
    )
    
    begin {
        ## Creation of hastable to store the thead, caption, and trs generated in the process
        ## caption and thead will be generated onlyc one.
        $Hashtable = @{
            caption = $null
            thead   = $null
            trs     = $null
            properties = @()
        }
    }
    
    process {
        
        Foreach ($item in $Object) {
            
            ## thead is null, it means we are in the first iteration, this condition will never be met after the first iteration
            If ( $null -eq $Hashtable.thead ) {
                if ($Properties) {
                    $HeaderNames = $Properties
                    $Hashtable.properties = $properties
                }
                else {
                    $props = $item | Get-Member -MemberType Properties | Select-Object Name
                    $HeaderNames = @()
                    foreach ($i in $props) {
                        $HeaderNames += $i.name.tostring()
                        $Hashtable.properties += $i.name.tostring()
                    }
                }

                if ($Caption) {
                    $Hashtable.caption = Caption -Content {
                        $Caption
                    }
                }

                ## Thead Params
                $TheadParams = @{}

                if ($TheadId) {
                    $TheadParams.id = $TheadId
                }
            
                if ($TheadClass) {
                    $TheadParams.Class = $TheadClass
                }
            
                if ($TheadStyle) {
                    $TheadParams.Style = $TheadStyle
                }
            
                if ($TheadAttributes) {
                    $TheadParams.Attributes = $TheadAttributes
                }
                
                $Hashtable.thead = Thead @TheadParams -content {
            
                    tr {
            
                        foreach ($Name in $HeaderNames) {
            
                            td {
                                $Name
                            }
            
                        }
            
                    }
            
                }
            } ## end of the thead is null
            
            ## Trs must be  generated for every iteration
            $tr = tr {
                        
                foreach ($propertyName in $Hashtable.properties) {
                    
                    th {
                        $item.$propertyName
                    }
                    
                }

            }

            $Hashtable.TRs = $Hashtable.TRs + $tr
            
        }
    }
    
    end {

        ## No need to generate TableParams in the process block
        $TableParams = @{}
        if ($TableID) {
            $TableParams.Id = $TableID
        }
    
        if ($TableClass) {
            $TableParams.Class = $TableClass
        }
    
        if ($TableStyle) {
            $TableParams.Style = $TableStyle
        }

        ## TBodyParams
        $TBodyParams = @{}

        if ($TBodyId) {
            $TBodyParams.Id = $TBodyId
        }
    
        if ($TBodyClass) {
            $TBodyParams.Class = $TBodyClass
        }
    
        If ($TBodyStyle) {
            $TBodyParams.Style = $TBodyStyle
        }
    
        If ($TBodyAttributes) {
            $TBodyParams.Attributes = $TBodyAttributes
        }
        
        Table @TableParams -Content { $Hashtable.caption + $Hashtable.thead + (Tbody @TBodyParams {$Hashtable.trs} ) }
    }
}
