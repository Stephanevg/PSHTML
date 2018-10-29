---
external help file: pshtml-help.xml
Module Name: PSHTML
online version:
schema: 2.0.0
---

# dd

## SYNOPSIS
Create a dd tag in an HTML document.

## SYNTAX

``` powershell
dd [-Content] <String> [[-Class] <String>] [[-Id] <String>] [[-Style] <String>] [[-value] <String>]
 [[-Attributes] <Hashtable>] [<CommonParameters>]
```

## DESCRIPTION
{{Fill in the Description}}

## EXAMPLES

### EXAMPLE 1

``` powershell
dd
```

### EXAMPLE 2

``` powershell
dd "woop1" -Class "class"
```

### EXAMPLE 3

``` powershell
dd "woop2" -Class "class" -Id "Something"
```

### EXAMPLE 4

``` powershell
dd "woop3" -Class "class" -Id "something" -Style "color:red;"
```

## PARAMETERS

### -Content
{{Fill Content Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
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

### -value
{{Fill value Description}}

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
       2018.04.01;bateskevinhanevg;Creation.

## RELATED LINKS

[Information on the dd HTML tag can be found here --> https://www.w3schools.com/tags/tag_dd.asp](https://www.w3schools.com/tags/tag_dd.asp)