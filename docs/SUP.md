---
external help file: PSHTML-help.xml
Module Name: PSHTML
online version: https://github.com/Stephanevg/PSHTML
schema: 2.0.0
---

# SUP

## SYNOPSIS
Create a SUP title in an HTML document.

## SYNTAX

```
SUP [[-Content] <Object>] [[-Class] <String>] [[-Id] <String>] [[-Style] <String>] [[-Attributes] <Hashtable>]
 [<CommonParameters>]
```

## DESCRIPTION
{{Fill in the Description}}

## EXAMPLES

### EXAMPLE 1
```
SUP
```

### EXAMPLE 2
```
SUP "woop1" -Class "class"
```

### EXAMPLE 3
```
SUP "woop2" -Class "class" -Id "MainTitle"
```

### EXAMPLE 4
```
SUP {"woop3"} -Class "class" -Id "MaintTitle" -Style "color:red;"
```

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Author: Chendrayan Venkatesan (Chen V)
Version: 1.0.0
History:
    2018.10.17;@ChendrayanV; New Version 1.0.0

## RELATED LINKS

[https://github.com/Stephanevg/PSHTML](https://github.com/Stephanevg/PSHTML)

