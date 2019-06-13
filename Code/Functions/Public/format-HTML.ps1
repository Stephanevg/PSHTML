function format-HTML {
    <#
        .SYNOPSIS
            formats an HTML String, with Line breaks and indents, so that it will be readable
    
        .DESCRIPTION
            formats an HTML String, with Line breaks and indents, so that it will be readable
    
        .PARAMETER HTMLString
    
            This parameter specifies the HTML String which should be formated

            this parameter is mandatory

        .PARMETER Indent

            This integer parameter specifies the indent length (number of spaces at start of the lines)

            this parameter is not mandatory, the default value is 4
    
        .EXAMPLE
            $HTMLString = '<html><head><script>alert(''test'');</script></head><body><p>this is a test</p></body></html>'
            
            format-HTML -HTMLString $HTMLString

            format-HTML -HTMLString $HTMLString -Indent 3
    
    #>
    Param (
        [Parameter(Mandatory = $true)]
        [xml]$HTMLString, 
        [Parameter(Mandatory = $false)]
        [int]$Indent=4
    ) 
    $StringWriter = New-Object System.IO.StringWriter 
    $XmlWriter = New-Object System.XMl.XmlTextWriter $StringWriter 
    $xmlWriter.Formatting = "indented"
    $xmlWriter.Indentation = $Indent 
    $HTMLString.WriteContentTo( $XmlWriter ) 
    $XmlWriter.Flush() 
    $StringWriter.Flush() 

    $formatedHTML = $StringWriter.ToString() 

    $lines = $formatedHTML -split "`r`n"
    
    $Chars = @()
    $Chars += New-Object -TypeName PSObject -Property @{ Value = ';'; Indent = 0 }
    $Chars += New-Object -TypeName PSObject -Property @{ Value = '{'; Indent = 1 }
    $Chars += New-Object -TypeName PSObject -Property @{ Value = '}'; Indent = -1 }

    $ReplacePattern = '(?=(?:[^'']*''[^'']*'')*[^'']*\Z)(?=(?:[^"]*"[^"]*")*[^"]*\Z)'
    $ScriptContentPattern =  '(?i)<script[^>]*>(.*?)<\/script>'

    $NewLines = @()
    foreach ( $line in $lines ) {
        if ( $line -match "<script" ) {
            $LineReg = [regex]::matches( $line, $ScriptContentPattern )
            if ( $LineReg[0].Success ) {
                $LineStart = $Line.Substring( 0, $LineReg.Groups[1].Index )
                $LineEnd = $line.Substring( $LineReg.Groups[1].Index + $LineReg.Groups[1].Length )
                $LineIndent = $LineReg.Index + $Indent
                $ScriptContent = ( [regex]::matches( $line, $ScriptContentPattern ) ).Groups[1].value
    
                $NewScriptContent = $ScriptContent
                foreach ( $Char in $Chars) {
                    $pattern = $Char.Value +$ReplacePattern
                    $NewScriptContent = [regex]::Replace($NewScriptContent, $pattern, "$( $Char.Value )`r`n" )
                }
                $ScriptLines = $NewScriptContent -split "`r`n"
                $NewScriptContent = ''
                $LineCount = @( $ScriptLines ).Count
                $i = 0
                foreach ( $ScriptLine in $ScriptLines ) {
                    $i++
                    if ( $scriptLine.Length -ge 1 ) {
                        $LastChar = $ScriptLine.Substring( ( $ScriptLine.Length - 1 ),1 )

                        if ( $LastChar -in ( $Chars.Value ) ) {
                            $LineIndentChange = ( $Chars | Where-Object { $_.Value -eq $LastChar } ).Indent
                            switch ( $LineIndentChange ) {
                                0 {
                                    $NewScriptContent += ( ' ' * $LineIndent ) + $ScriptLine.TrimStart() + "`r`n"
                                }
                                { $_ -gt 0 } {
                                    $NewScriptContent += ( ' ' * $LineIndent ) + $ScriptLine.TrimStart() + "`r`n"
                                    $LineIndent = $LineIndent + ( $LineIndentChange * $Indent )
                                }
                                { $_ -lt 0 } {
                                    $LineIndent = $LineIndent + ( $LineIndentChange * $Indent )
                                    $NewScriptContent += ( ' ' * $LineIndent ) + $ScriptLine.TrimStart() + "`r`n"
                                }
                            }
                        }
                        else {
                            $NewScriptContent += ( ' ' * $LineIndent ) + $ScriptLine.TrimStart() + "`r`n"
                        }
                    }
                }
                $NewScriptContent = $NewScriptContent + ( ' ' * ( $LineIndent - $Indent ) )
                $NewLine = $LineStart + "`r`n" + $NewScriptContent + $LineEnd
                $NewLines += $NewLine
            }
            else {
                $NewLines += $line    
            }
        }
        else {
            $NewLines += $line
        }
    }
    $NewContent = $NewLines -join "`r`n"

    return $NewContent
}

<#
$formatedHTML = format-HTML -HTMLString $HTMLPage
$formatedHTML 
$formatedHTML | Out-File C:\temp\test.html
#>