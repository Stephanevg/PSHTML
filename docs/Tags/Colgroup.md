---
external help file: pshtml-help.xml
Module Name: PSHTML
online version:
schema: 2.0.0
---

# Colgroup

## SYNOPSIS
Generates colgroup HTML tag.

## SYNTAX

``` powershell
Colgroup [[-Content] <ScriptBlock>] [[-span] <Int32>] [[-Class] <String>] [[-Id] <String>] [[-Style] <String>]
 [[-Attributes] <Hashtable>] [<CommonParameters>]
```

## DESCRIPTION
The \<colgroup\> tag is useful for applying styles to entire columns, instead of repeating the styles for each cell, for each row.

## EXAMPLES

### EXAMPLE 1

``` powershell
Colgroup {
    col -span 2
}
```
Generates the following code

\<colgroup\>
    \<col span="2"  \>
\</colgroup\>

### EXAMPLE 2

``` powershell
Colgroup {
    col -span 3 -Style "Background-color:red"
    col -Style "Backgroung-color:yellow"
}
```

Generates the following code

\<colgroup\>
    \<col span="3" Style="Background-color:red"  \>
    \<col Style="Backgroung-color:yellow"  \>
\</colgroup\>

## PARAMETERS

### -Content
{{Fill Content Description}}

```yaml
Type: ScriptBlock
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -span
{{Fill span Description}}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: 0
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
Position: 3
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
Position: 4
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
Current version 1.0
History:
    2018.04.08;Stephanvg; Updated to version 1.0
    2018.04.01;Stephanevg;Fix disyplay bug.

## RELATED LINKS

[Information on the colgroup HTML tag can be found here --> https://www.w3schools.com/tags/tag_colgroup.asp](https://www.w3schools.com/tags/tag_colgroup.asp)