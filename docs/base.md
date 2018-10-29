---
external help file: pshtml-help.xml
Module Name: PSHTML
online version:
schema: 2.0.0
---

# base

## SYNOPSIS
Create a base title in an HTML document.

## SYNTAX

``` powershell
base [-href] <String> [[-Target] <String>] [[-Class] <String>] [[-Id] <String>] [[-Attributes] <Hashtable>]
 [<CommonParameters>]
```

## DESCRIPTION
The \<base\> tag specifies the base URL/target for all relative URLs in a document.

There can be at maximum one \<base\> element in a document, and it must be inside the \<head\> element.

## EXAMPLES

### EXAMPLE 1

``` powershell
base
```

### EXAMPLE 2

``` powershell
base "woop1" -Class "class"
```

### EXAMPLE 3

## PARAMETERS

### -href
{{Fill href Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Target
{{Fill Target Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: _self
Accept pipeline input: False
Accept wildcard characters: False
```

### -Class
{{Fill Class Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
{{Fill Id Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
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
Position: 5
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
Author: St ©phane van Gulick
Version: 1.0.1
History:
    2018.05.11;@Stephanevg; fixed minor bugs
    2018.05.09;@Stephanevg; Creation

## RELATED LINKS

[Information on the base HTML tag can be found here --> https://www.w3schools.com/tags/tag_base.asp](https://www.w3schools.com/tags/tag_base.asp)