---
external help file: pshtml-help.xml
Module Name: PSHTML
online version:
schema: 2.0.0
---

# section

## SYNOPSIS
Generates section HTML tag.

## SYNTAX

``` powershell
section [[-Class] <String>] [[-Id] <String>] [[-Style] <String>] [[-Attributes] <Hashtable>]
 [[-Content] <ScriptBlock>] [<CommonParameters>]
```

## DESCRIPTION
{{Fill in the Description}}

## EXAMPLES

### EXAMPLE 1

``` powershell
section -Attributes @{"class"="MyClass";"id"="myid"} -Content {
    h1 "This is a h1"
    P{
        "This paragraph is part of a section with id 'myid'"
    }
}
```

Generates the following code:

\<section class="MyClass" id="myid" \>
    \<h1\>This is a h1\</h1\>
    \<p\>
        This paragraph is part of a section with id 'myid'
    \</p\>
\</section\>

### EXAMPLE 2

``` powershell
section -Class "myclass" -Style "section {border:1px dotted black;}" -Content {
h1 "This is a h1"
    P{
        "This paragraph is part of section with id 'myid'"
    }
}
```

Generates the following code:

\<section Class="myclass" Style="section {border:1px dotted black;}" \>
\<h1\>This is a h1\</h1\>
    \<p\>
    This paragraph is part of section with id 'myid'
    \</p\>
\</section\>

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

[Information on the section HTML tag can be found here --> https://www.w3schools.com/tags/tag_section.asp](https://www.w3schools.com/tags/tag_section.asp)