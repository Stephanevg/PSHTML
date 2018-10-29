---
external help file: pshtml-help.xml
Module Name: PSHTML
online version:
schema: 2.0.0
---

# hr

## SYNOPSIS
Create a hr title in an HTML document.

## SYNTAX

``` powershell
hr [[-Class] <String>] [[-Id] <String>] [[-Style] <String>] [[-Attributes] <Hashtable>] [<CommonParameters>]
```

## DESCRIPTION
{{Fill in the Description}}

## EXAMPLES

### EXAMPLE 1

``` powershell
hr
```

Generates the following code:

\<hr\>

### EXAMPLE 2

``` powershell
hr -Attributes @{"Attribute1"="val1";"Attribute2"="val2"}
```

Generates the following code:

\<hr Attribute1="val1" Attribute2="val2"  \>

### EXAMPLE 3

``` powershell
$Style = "font-family: arial; text-align: center;"
hr -Style $style
```

Generates the following code

\<hr Style="font-family: arial; text-align: center;"  \>

## PARAMETERS

### -Class
{{Fill Class Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
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
Position: 2
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
Position: 3
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
Position: 4
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

[Information on the hr HTML tag can be found here --> https://www.w3schools.com/tags/tag_hr.asp](https://www.w3schools.com/tags/tag_hr.asp)