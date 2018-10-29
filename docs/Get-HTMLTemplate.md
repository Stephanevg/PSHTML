---
external help file: pshtml-help.xml
Module Name: PSHTML
online version:
schema: 2.0.0
---

# Get-HTMLTemplate

## SYNOPSIS

## SYNTAX

``` powershell
Get-HTMLTemplate [[-Name] <Object>] [<CommonParameters>]
```

## DESCRIPTION
{{Fill in the Description}}

## EXAMPLES

### EXAMPLE 1

``` powershell
html{
    Body{

        include -name body

    }
    Footer{
        Include -Name Footer
    }
}
```

Generates the following HTML code:

        \<html\>
            \<body\>

            h2 "This comes a template file"
            \</body\>
            \<footer\>
            div {
                h4 "This is the footer from a template"
                p{
                    CopyRight from template
                }
            }
            \</footer\>
        \</html\>

## PARAMETERS

### -Name
{{Fill Name Description}}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
