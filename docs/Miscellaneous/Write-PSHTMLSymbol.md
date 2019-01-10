---
external help file: pshtml-help.xml
Module Name: PSHTML
online version:
schema: 2.0.0
---

# Write-PSHTMLSymbol

## SYNOPSIS
A PowerShell cmdlet to add a HTML symbol

## SYNTAX

``` powershell
Write-PSHTMLSymbol [-Name] <String> [<CommonParameters>]
```

## DESCRIPTION
A PowerShell cmdlet to add a HTML symbol. Refer https://www.w3schools.com/html/html_symbols.asp for more information about supported symbols


## EXAMPLES

### EXAMPLE 1

``` powershell
html -Content {
    head -Content {
        Title -Content "Symbol Test"
    }

    body -Content {
        Write-PSHTMLSymbol -Name 'EURO SIGN'
    }
} 
```


### EXAMPLE 2

``` powershell
html -Content {
    head -Content {
        Title -Content "Symbol Test"
    }

    body -Content {
        Write-PSHTMLSymbol -Name 'EURO SIGN' , 'BLACK CLUB SUIT'
    }
} 
```

### EXAMPLE 3

```powershell
html -Content {
    head -Content {
        Title -Content "Symbol Test"
    }

    body -Content {
        'EURO SIGN' , 'BLACK CLUB SUIT' | Write-PSHTMLSymbol
    }
} 
```

## PARAMETERS

### -Name
{{Fill Object Description}}

```yaml
Type: Name
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Current version 0.6
History:
   2018.05.09;stephanevg;Creation.

## RELATED LINKS
