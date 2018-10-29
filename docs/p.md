---
external help file: pshtml-help.xml
Module Name: PSHTML
online version:
schema: 2.0.0
---

# p

## SYNOPSIS
Create a p tag in an HTML document.

## SYNTAX

``` powershell
p [[-Content] <Object>] [[-Class] <String>] [[-Id] <String>] [[-Style] <String>] [[-title] <String>]
 [[-Attributes] <Hashtable>] [<CommonParameters>]
```

## DESCRIPTION
{{Fill in the Description}}

## EXAMPLES

### EXAMPLE 1

``` powershell
p
```

### EXAMPLE 2

``` powershell
p "woop1" -Class "class"
```

### EXAMPLE 3

``` powershell
p "woop2" -Class "class" -Id "Something"
```

### EXAMPLE 4

``` powershell
p "woop3" -Class "class" -Id "something" -Style "color:red;"
```

### EXAMPLE 5

``` powershell
p {
    $Important = strong{"This is REALLY important"}
    "This is regular test in a paragraph " + $Important
}
```

Generates the following code:

\<p\>
This is regular test in a paragraph \<strong\>"This is REALLY important"\</strong\>
\</p\>

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

### -title
{{Fill title Description}}

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
Current version 1.1.0
   History:
       2018.04.10;Stephanevg;Updated content (removed string, added if for selection between scriptblock and string).
       2018.04.01;bateskevinhanevg;Creation.

## RELATED LINKS

[Information on the p HTML tag can be found here --> https://www.w3schools.com/tags/tag_p.asp](https://www.w3schools.com/tags/tag_p.asp)