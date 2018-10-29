---
external help file: pshtml-help.xml
Module Name: PSHTML
online version:
schema: 2.0.0
---

# address

## SYNOPSIS
Generates address HTML tag.

## SYNTAX

``` powershell
address [[-Content] <ScriptBlock>] [[-Class] <String>] [[-Id] <String>] [[-Style] <String>]
 [[-Attributes] <Hashtable>] [<CommonParameters>]
```

## DESCRIPTION
{{Fill in the Description}}

## EXAMPLES

### EXAMPLE 1


``` powershell
address {
    $twitterLink = a -href "http://twitter/stephanevg" -Target _blank -ChildItem {"@stephanevg"}
    $bloglink = a -href "http://www.powershelldistrict.com" -Target _blank -ChildItem {"www.powershelldistrict.com"}
    "written by: Stephane van Gulick"
    "blog: $($bloglink)";
    "twitter: $($twitterLink)"
}
```

Generates the following code:

\<address\>
    written by: Stephane van Gulick
    blog: \<a href=http://www.powershelldistrict.com target="_blank" \> www.powershelldistrict.com \</a\>
    twitter: \<a href=http://twitter/stephanevg target="_blank" \> @stephanevg \</a\>
\</address\>

## PARAMETERS

### -Content
Allows to add child element(s) inside the current opening and closing HTML tag(s).

```yaml
Type: ScriptBlock
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

[Information on the address HTML tag can be found here --> https://www.w3schools.com/tags/tag_address.asp](https://www.w3schools.com/tags/tag_address.asp)