function Out-PSHTMLDocument {
    <#
    .SYNOPSIS
    Outputs the HTML document to an output location
    .DESCRIPTION
        Output the html string into a file.
    .EXAMPLE
        The following example gets the list of first 5 processes. Converts it into an HTML Table. It outputs the results in a file, and opens the results imédiatley.

        $o = Get-PRocess | select ProcessName,Handles | select -first 5
        $FilePath = "C:\temp\OutputFile.html"
        $E = ConvertTo-HTMLTable -Object $o 
        $e | Out-PSHTMLDocument -OutPath $FilePath -Show

    .INPUTS
        String
    .OUTPUTS
        None
    .NOTES

        Author: Stéphane van Gulick
                
        
    .LINK
        https://github.com/Stephanevg/PSHTML
#>
    [CmdletBinding()]
    param (
        $OutPath = $(Throw "Must provide a path"),

        [Parameter(ValueFromPipeline = $true)]
        $HTMLDocument = $(Throw "HTMLDocument cannot be empty"),

        [Parameter(Mandatory = $False)]
        [Switch]$Show
    )
    
    begin {
        $Writer = [System.IO.StreamWriter]$OutPath
    }
    
    process {
        #[System.IO.TextWriter]
        Foreach ($Line in $HTMLDocument) {
            $writer.WriteLine($Line, "utf8")
        }
    }
    
    end {
        $Writer.Close()
        If ($Show) {
            Invoke-Item -Path $OutPath
        }
    }
}