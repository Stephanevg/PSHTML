---
external help file: pshtml-help.xml
Module Name: PSHTML
online version:
schema: 2.0.0
---

# meta

## SYNOPSIS
Create a meta title in an HTML document.

## SYNTAX

``` powershell
meta [[-content] <String>] [[-charset] <String>] [[-httpequiv] <String>] [[-name] <String>]
 [[-scheme] <String>] [[-class] <String>] [[-id] <String>] [[-Style] <String>] [[-Attributes] <Hashtable>]
 [<CommonParameters>]
```

## DESCRIPTION
Metadata is data (information) about data.

The \<meta\> tag provides metadata about the HTML document.
Metadata will not be displayed on the page, but will be machine parsable.

Meta elements are typically used to specify page description, keywords, author of the document, last modified, and other metadata.

The metadata can be used by browsers (how to display content or reload page), search engines (keywords), or other web services.

(source --\> https://www.w3schools.com/tags/tag_meta.asp)

## EXAMPLES

### EXAMPLE 1

``` powershell
meta
```

### EXAMPLE 2

``` powershell
meta "woop1" -Class "class"
```

### EXAMPLE 3

``` powershell
meta "woop2" -Class "class" -Id "MainTitle"
```

### EXAMPLE 4

``` powershell
meta {"woop3"} -Class "class" -Id "MaintTitle" -Style "color:red;"
```

### EXAMPLE 5

``` powershell
meta -name author -content "Stephane van Gulick"
```

Generates the following code:

\<meta name="author" content="Stephane van Gulick"  \>

## PARAMETERS

### -content
{{Fill content Description}}

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

### -charset
{{Fill charset Description}}

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

### -httpequiv
{{Fill httpequiv Description}}

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

### -name
{{Fill name Description}}

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

### -scheme
{{Fill scheme Description}}

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

### -class
{{Fill class Description}}

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

### -id
{{Fill id Description}}

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
    2018.04.14;@Stephanevg; Creation

## RELATED LINKS

[Information on the meta HTML tag can be found here --> https://www.w3schools.com/tags/tag_meta.asp](https://www.w3schools.com/tags/tag_meta.asp)