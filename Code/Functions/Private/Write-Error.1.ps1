function Write-Error {
    <#
        .SYNOPSIS
            Proxy function for Write-Error that adds a timestamp and write the message to a log file.
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
                $Type = 'Error'
                $Msgobj = [LogMessage]::new($Message,$Type)
                $FormatedMessage = $Msgobj.ToString()
                Write-PSHTMLLog -message $FormatedMessage -type $Type
                #Microsoft.PowerShell.Utility\Write-Error -Message $FormatedMessage;
                #Overwriting Write-Error would not display message. See https://stackoverflow.com/questions/4998173/how-do-i-write-to-standard-error-in-powershell
                $host.ui.WriteErrorLine($FormatedMessage)
            }
    
        } # end process
    } #end function