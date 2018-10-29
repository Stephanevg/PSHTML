---
external help file: pshtml-help.xml
Module Name: PSHTML
online version:
schema: 2.0.0
---

# Link

## SYNOPSIS
Create a link title in an HTML document.

## SYNTAX

``` powershell
Link [-href] <String> [[-type] <Object>] [-rel] <String> [[-Integrity] <String>] [[-CrossOrigin] <String>]
 [[-Class] <String>] [[-Id] <String>] [[-Style] <String>] [[-Attributes] <Hashtable>] [<CommonParameters>]
```

## DESCRIPTION
{{Fill in the Description}}

## EXAMPLES

### EXAMPLE 1

``` powershell
link
```

Generates the following code:

\<link\>

### EXAMPLE 2

``` powershell
link -Attributes @{"Attribute1"="val1";"Attribute2"="val2"}
```

Generates the following code:

\<link Attribute1="val1" Attribute2="val2"  \>

### EXAMPLE 3

``` powershell
$Style = "font-family: arial; text-align: center;"
link -Style $style
```

Generates the following code:

\<link Style="font-family: arial; text-align: center;"  \>

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

### -type
{{Fill type Description}}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -rel
{{Fill rel Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Integrity
{{Fill Integrity Description}}

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

### -CrossOrigin
{{Fill CrossOrigin Description}}

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

### -Class
{{Fill Class Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
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
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Style
{{Fill Style Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
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
Position: 9
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
    2018.04.08;Stephanevg; Updated to version 1.0: Updated content block to support string & ScriptBlock
    2018.03.25;@Stephanevg; Added Styles, ID, CLASS attributes functionality
    2018.03.25;@Stephanevg; Creation

## RELATED LINKS

[Information on the link HTML tag can be found here --> https://www.w3schools.com/tags/tag_link.asp](https://www.w3schools.com/tags/tag_link.asp)