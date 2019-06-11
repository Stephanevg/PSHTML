---
external help file: pshtml-help.xml
Module Name: PSHTML
online version:
schema: 2.0.0
---

# header

## SYNOPSIS
Generates a header HTML tag.

## SYNTAX

``` powershell
header [[-Content] <Object>] [[-Class] <String>] [[-Id] <String>] [[-Style] <String>]
 [[-Attributes] <Hashtable>] [<CommonParameters>]
```

## DESCRIPTION
The \<header\> element represents a container for introductory content or a set of navigational links.

A \<header\> element typically contains:

one or more heading elements (\<h1\> - \<h6\>)
logo or icon
authorship information
You can have several \<header\> elements in one document.

(Source -\> https://www.w3schools.com/tags/tag_header.asp)

## EXAMPLES

### EXAMPLE 1

``` powershell
header {
h1 "This is h1 Title in header"
        h2 "This is h2 Title in header"
        p "Some text in paragraph"
}
```

Generates the following code:

\<header\>
    \<h1\>
    This is h1 Title in header
    \</h1\>
    \<h2\>
    This is h2 Title in header
    \</h2\>
    \<p\>
    Some text in paragraph
    \</p\>
\</header\>

## PARAMETERS

### -Content
Allows to add child element(s) inside the current opening and closing HTML tag(s).

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
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
    2018.04.10;Stephanevg; Added parameters
    2018.04.01;Stephanevg;Creation.

## RELATED LINKS

[Information on the header HTML tag can be found here --> https://www.w3schools.com/tags/tag_header.asp](https://www.w3schools.com/tags/tag_header.asp)