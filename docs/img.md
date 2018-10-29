---
external help file: pshtml-help.xml
Module Name: PSHTML
online version:
schema: 2.0.0
---

# img

## SYNOPSIS
Generates a html img tag.

## SYNTAX

``` powershell
img [-src] <String> [-alt] <String> [[-height] <String>] [[-width] <String>] [[-Class] <String>]
 [[-Id] <String>] [[-Style] <String>] [[-Attributes] <Hashtable>] [<CommonParameters>]
```

## DESCRIPTION
The \<img\> tag defines an image in an HTML page.

The \<img\> tag has two required attributes: src and alt.

## EXAMPLES

### EXAMPLE 1

## PARAMETERS

### -src
Defines the source location of the image

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

### -alt
Alternative display when the image cannot be displayed.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -height
{{Fill height Description}}

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

### -width
{{Fill width Description}}

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

### -Class
Allows to specify one (or more) class(es) to assign the img element.
More then one class can be assigned by seperating them with a white space.

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

### -Id
Allows to specify an id to assign the img element.

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

### -Style
Allows to specify in line CSS style to assign the img element.

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

### -Attributes
{{Fill Attributes Description}}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
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
Current version 1.0
History:
    2018.05.07;Stephanevg; Updated code to version 1.0
    2018.04.01;Stephanevg;Creation.

## RELATED LINKS

[Information on the img HTML tag can be found here --> https://www.w3schools.com/tags/tag_img.asp](https://www.w3schools.com/tags/tag_img.asp)