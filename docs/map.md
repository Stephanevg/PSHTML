---
external help file: pshtml-help.xml
Module Name: PSHTML
online version:
schema: 2.0.0
---

# map

## SYNOPSIS
Generates map HTML tag.

## SYNTAX

``` powershell
map [[-Class] <String>] [[-Id] <String>] [[-Style] <String>] [[-Attributes] <Hashtable>]
 [[-Content] <ScriptBlock>] [<CommonParameters>]
```

## DESCRIPTION
The map must be used in conjunction with area.
Pass an 'area' parameter with its arguments in the 'Content' parameter

## EXAMPLES

### EXAMPLE 1

``` powershell
map -Content {area -href "map.png" -coords "0,0,50,50" -shape circle -target top }
```

Generates the following code

\<map\>
    \<area href="map.png" coords="0,0,50,50" shape="circle" target="top" \>
\</map\>

### EXAMPLE 2

## PARAMETERS

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

### -Content
{{Fill Content Description}}

```yaml
Type: ScriptBlock
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
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

## RELATED LINKS

[Information on the map HTML tag can be found here --> https://www.w3schools.com/tags/tag_map.asp](https://www.w3schools.com/tags/tag_map.asp)