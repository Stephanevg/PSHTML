function Write-Verbose {
    <#
        .SYNOPSIS
            Proxy function for Write-verbose that adds a timestamp and write the message to a log file.
    #>
        [CmdletBinding()]
        param (
            [Parameter(ValueFromPipeline, ValueFromPipelineByPropertyName)]
            [AllowNull()]
            [System.String] $Message
        )
        process {
    
            if (-not [System.String]::IsNullOrEmpty($Message)) {
    
                #$Message = Get-FormattedMessage -Message $Message;
                $Type = 'Information'
                $Msgobj = [LogMessage]::new($Message,$Type)
                $FormatedMessage = $Msgobj.ToString()
                Write-PSHTMLLog -message $FormatedMessage -type $Type
                Microsoft.PowerShell.Utility\Write-Verbose -Message $FormatedMessage;
            }
    
        } # end process
    } #end function