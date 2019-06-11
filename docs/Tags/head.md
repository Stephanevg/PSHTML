---
external help file: pshtml-help.xml
Module Name: PSHTML
online version:
schema: 2.0.0
---

# head

## SYNOPSIS
Generates a head HTML tag.

## SYNTAX

``` powershell
head [[-Content] <Object>] [[-Class] <String>] [[-Id] <String>] [[-Style] <String>] [[-Attributes] <Hashtable>]
 [<CommonParameters>]
```

## DESCRIPTION
The \<head\> element is a container for all the head elements.

The \<head\> element can include a title for the document, scripts, styles, meta information, and more.

The following elements can go inside the \<head\> element:

\<title\> (this element is required in an HTML document)
\<style\>
\<base\>
\<link\>
\<meta\>
\<script\>
\<noscript\>

(Source --\> https://www.w3schools.com/tags/tag_head.asp)

## EXAMPLES

### EXAMPLE 1

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

[Information on the head HTML tag can be found here --> https://www.w3schools.com/tags/tag_head.asp](https://www.w3schools.com/tags/tag_head.asp)