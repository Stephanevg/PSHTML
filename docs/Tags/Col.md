---
external help file: pshtml-help.xml
Module Name: PSHTML
online version:
schema: 2.0.0
---

# Col

## SYNOPSIS
Generates col HTML tag.

## SYNTAX

``` powershell
Col [[-span] <Int32>] [[-Class] <String>] [[-Id] <String>] [[-Style] <String>] [[-Attributes] <Hashtable>]
 [<CommonParameters>]
```

## DESCRIPTION
The \<col\> tag specifies column properties for each column within a \<colgroup\> element.
The \<col\> tag is useful for applying styles to entire columns, instead of repeating the styles for each cell, for each row.

## EXAMPLES

### EXAMPLE 1

``` powershell
col -span 3 -Class "Table1"
```

Generates the following code

\<col span="3" Class="Table1"  \>

### EXAMPLE 2

Col is often used in conjunction with 'colgroup'. See below for an example using colgroup and two col

``` powershell
Colgroup {
    col -span 3 -Style "Background-color:red"
    col -Style "Backgroung-color:yellow"
}

Generates the following code
\<colgroup\>
    \<col span="3" Style="Background-color:red"  \>
    \<col Style="Backgroung-color:yellow"  \>
\</colgroup\>
```

## PARAMETERS

### -span
{{Fill span Description}}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
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
Position: 2
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
Position: 3
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
Current version 1.0
History:
    2018.04.08;Stephanvg; Updated to version 1.0
    2018.04.01;Stephanevg;Fix disyplay bug.

## RELATED LINKS

[Information on the col HTML tag can be found here --> https://www.w3schools.com/tags/tag_col.asp](https://www.w3schools.com/tags/tag_col.asp)