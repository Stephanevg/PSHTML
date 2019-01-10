---
external help file: pshtml-help.xml
Module Name: PSHTML
online version:
schema: 2.0.0
---

# strong

## SYNOPSIS
Generates strong HTML tag.

## SYNTAX

``` powershell
strong [-Content] <Object> [[-Class] <String>] [[-Id] <String>] [[-Style] <String>] [[-Attributes] <Hashtable>]
 [<CommonParameters>]
```

## DESCRIPTION
This tag is a "Textual semantic" tag.
To use it in a "P" tag, be sure to prefix it with a semicolon (";").
See example for more details.

## EXAMPLES

### EXAMPLE 1

``` powershell
p{
    "This is";strong {"cool"}
}
```

Will generate the following code:

\<p\>
    This is
    \<strong\>
    cool
    \</strong\>
\</p\>

## PARAMETERS

### -Content
{{Fill Content Description}}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Class
{{Fill Class Description}}

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

### -Id
{{Fill Id Description}}

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

### -Style
{{Fill Style Description}}

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
Version: 2.0.0
History:
    2018.05.23;@Stephanevg; Updated function to use New-HTMLTag
    2018.05.09;@Stephanevg; Creation

## RELATED LINKS

[Information on the strong HTML tag can be found here --> https://www.w3schools.com/tags/tag_strong.asp](https://www.w3schools.com/tags/tag_strong.asp)