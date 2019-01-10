---
external help file: pshtml-help.xml
Module Name: PSHTML
online version:
schema: 2.0.0
---

# style

## SYNOPSIS
Create a style title in an HTML document.

## SYNTAX

``` powershell
style [[-Content] <Object>] [[-media] <String>] [[-Type] <String>] [[-Class] <String>] [[-Id] <String>]
 [[-Attributes] <Hashtable>] [<CommonParameters>]
```

## DESCRIPTION
{{Fill in the Description}}

## EXAMPLES

### EXAMPLE 1

``` powershell
style
```

### EXAMPLE 2

``` powershell
style "woop1" -Class "class"
```

### EXAMPLE 3

``` powershell
$css = @"
"p {color:green;}
    h1 {color:orange;}"
"@
style {$css} -media "print" -type "text/css"
```

## PARAMETERS

### -Content
{{Fill Content Description}}

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

### -media
{{Fill media Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Type
{{Fill Type Description}}

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

### -Class
{{Fill Class Description}}

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

### -Id
{{Fill Id Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
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
Position: 6
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
Version: 1.0.0
History:
    2018.05.09;@Stephanevg; Creation

## RELATED LINKS

[Information on the style HTML tag can be found here --> https://www.w3schools.com/tags/tag_style.asp](https://www.w3schools.com/tags/tag_style.asp)