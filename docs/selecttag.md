---
external help file: pshtml-help.xml
Module Name: PSHTML
online version:
schema: 2.0.0
---

# selecttag

## SYNOPSIS
creates a "select" html tag.

## SYNTAX

``` powershell
selecttag [[-Content] <Object>] [[-Class] <String>] [[-Id] <String>] [[-Attributes] <Hashtable>]
 [<CommonParameters>]
```

## DESCRIPTION
The name of the cmdlet has volontarly been changed from "select" to "selectag" in order to avoid a conflict with
with the built-in powershell alias "select" (which points to Select-object)

## EXAMPLES

### EXAMPLE 1

``` powershell
selecttag
```

### EXAMPLE 2

``` powershell
selecttag "woop1" -Class "class"
```

### EXAMPLE 3

``` powershell

```

\<option value="volvo"\>Volvo\</option\>
    \<option value="saab"\>Saab\</option\>
    \<option value="mercedes"\>Mercedes\</option\>
    \<option value="audi"\>Audi\</option\>
\</select\>

## PARAMETERS

### -Content
{{Fill Content Description}}

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

### -Attributes
{{Fill Attributes Description}}

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
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
    2018.05.09;@Stephanevg; Creation

## RELATED LINKS
