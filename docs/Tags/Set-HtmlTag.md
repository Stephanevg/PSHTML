---
external help file: PSHTML-help.xml
Module Name: PSHTML
online version:
schema: 2.0.0
---

# Set-HtmlTag

## SYNOPSIS
This function is the base function for all the html elements in pshtml.

## SYNTAX

``` powershell
Set-HtmlTag [[-TagName] <Object>] [[-Attributes] <Hashtable>] [[-TagType] <Object>] [[-Content] <Object>]
 [<CommonParameters>]
```

## DESCRIPTION
although it can be this function is not intended to be used directly.

## EXAMPLES

### EXAMPLE 1

``` powershell
Set-HtmlTag -TagName div -Attributes @{"Class"="myClass123"}
```

### EXAMPLE 2

``` powershell
Set-HtmlTag -TagName style -Attributes @{"Class"="myClass123"}
```

## PARAMETERS

### -TagName
\[system.web.ui.HtmlTextWriterTag\]

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

### -Attributes
{{Fill Attributes Description}}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TagType
{{Fill TagType Description}}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Content
{{Fill Content Description}}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Current version 0.7
   History:
        2018.05.07;stephanevg;Creation

## RELATED LINKS
