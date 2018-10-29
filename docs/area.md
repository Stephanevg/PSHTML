---
external help file: pshtml-help.xml
Module Name: PSHTML
online version:
schema: 2.0.0
---

# area

## SYNOPSIS
Generates area HTML tag.

## SYNTAX

``` powershell
area [[-href] <String>] [[-alt] <String>] [[-coords] <String>] [[-shape] <String>] [[-target] <String>]
 [[-type] <String>] [[-Class] <String>] [[-Id] <String>] [[-Style] <String>] [[-Attributes] <Hashtable>]
 [<CommonParameters>]
```

## DESCRIPTION
The are tag must be used in a \<map\> element (Use the 'map' function)

## EXAMPLES

### EXAMPLE 1

``` powershell
area -href "link.php" -alt "alternate description" -coords "0,0,10,10"
```

Generates the following code:

\<area href="link.php" alt="alternate description" coords="0,0,10,10" \>

### EXAMPLE 2
```
area -href image.png -coords "0,0,20,20" -shape rect
```

Generates the following code:

\<area href="image.png"coords="0,0,20,20"shape="rect" \>

## PARAMETERS

### -href
{{Fill href Description}}

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

### -alt
{{Fill alt Description}}

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

### -coords
{{Fill coords Description}}

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

### -shape
{{Fill shape Description}}

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

### -target
{{Fill target Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: _Blank
Accept pipeline input: False
Accept wildcard characters: False
```

### -type
{{Fill type Description}}

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

### -Class
Allows to specify one (or more) class(es) to assign the html element.
More then one class can be assigned by seperating them with a white space.

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

### -Id
Allows to specify an id to assign the html element.

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

### -Style
Allows to specify in line CSS style to assign the html element.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
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
Position: 10
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
       2018.04.10;Stephanevg; Added parameters
       2018.04.01;Stephanevg;Creation.

## RELATED LINKS

[Information on the area HTML tag can be found here --> https://www.w3schools.com/tags/tag_area.asp](https://www.w3schools.com/tags/tag_area.asp)