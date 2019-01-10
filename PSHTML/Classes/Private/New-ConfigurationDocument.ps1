
function New-ConfigurationDocument {
    [CmdletBinding()]
    param (
        [System.IO.FileInfo]$Path,
        [Switch]$Force
    )
    
    begin {
    }
    
    process {
        if($Path){
            [ConfigurationFile]::New($Path)
        }Else{

            [ConfigurationFile]::New()
        }
    }
    
    end {
    }
}
