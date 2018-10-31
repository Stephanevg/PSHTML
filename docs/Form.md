---
external help file: pshtml-help.xml
Module Name: PSHTML
online version:
schema: 2.0.0
---

# Form

## SYNOPSIS
Generates Form HTML tag.

## SYNTAX

``` powershell
Form [-action] <String> [-method] <String> [-target] <String> [[-Class] <String>] [[-Id] <String>]
 [[-Style] <String>] [[-Attributes] <Hashtable>] [[-Content] <ScriptBlock>] [<CommonParameters>]
```

## DESCRIPTION
{{Fill in the Description}}

## EXAMPLES

### EXAMPLE 1

``` powershell
form "/action_Page.php" post _self
```

Generates the following html element: (Not very usefull, we both agree on that)

\<from action="/action_Page.php" method="post" target="_self" \>
\</form\>

### EXAMPLE 2

The following Example show how to pass custom HTML tag and their values

``` powershell
form "/action_Page.php" post _self -attributes @{"Woop"="Wap";"sap"="sop"}
```

## PARAMETERS

### -action
{{Fill action Description}}

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

### -method
{{Fill method Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: Get
Accept pipeline input: False
Accept wildcard characters: False
```

### -target
{{Fill target Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: _self
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
Position: 4
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
Position: 5
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
Position: 6
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
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Content
Allows to add child element(s) inside the current opening and closing HTML tag(s).

```yaml
Type: ScriptBlock
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
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
Current version 0.8
History:
    2018.04.08;Stephanevg; Fixed custom Attributes display bug.
Updated help
    2018.04.01;Stephanevg;Fix disyplay bug.

## RELATED LINKS

[Information on the form HTML tag can be found here --> https://www.w3schools.com/tags/tag_form.asp](https://www.w3schools.com/tags/tag_form.asp)