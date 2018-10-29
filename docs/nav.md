---
external help file: pshtml-help.xml
Module Name: PSHTML
online version:
schema: 2.0.0
---

# nav

## SYNOPSIS
Generates nav HTML tag.

## SYNTAX

``` powershell
nav [-Content] <ScriptBlock> [[-Class] <String>] [[-Id] <String>] [[-Style] <String>]
 [[-Attributes] <Hashtable>] [<CommonParameters>]
```

## DESCRIPTION
{{Fill in the Description}}

## EXAMPLES

### EXAMPLE 1

``` powershell
nav -Content {
a -href "\home.html" -Target _blank
    a -href "\about.html" -Target _blank
    a -href "\blog.html" -Target _blank
    a -href "\contact.html" -Target _blank
}
```

Generates the following code:

\<nav\>
    \<a href=\home.html target="_blank" \>\</a\>
    \<a href=\about.html target="_blank" \>\</a\>
    \<a href=\blog.html target="_blank" \>\</a\>
    \<a href=\contact.html target="_blank" \>\</a\>
\</nav\>

### EXAMPLE 2

It is also possible to use regular powershell logic inside a scriptblock. The example below, generates a nav element based on values located in a array. The various links are build using a foreach loop.

``` powershell
$Pages = "home.html","login.html","about.html"
nav -Content {
    foreach($page in $pages){
        a -href "\$($page)" -Target _blank
    }

} -Class "mainnavigation" -Style "border 1px"
```

Generates the following code:

\<nav Class="mainnavigation" Style="border 1px" \>
    \<a href=\home.html target="_blank" \>
    \</a\>
    \<a href=\login.html target="_blank" \>
    \</a\>
    \<a href=\about.html target="_blank" \>
    \</a\>
\</nav\>

## PARAMETERS

### -Content
{{Fill Content Description}}

```yaml
Type: ScriptBlock
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
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
Author: St ©phane van Gulick
Version: 2.0.0
History:
    2018.05.09;@Stephanevg; Creation
    2018.05.21;@Stephanevg; Updated function to use New-HTMLTag

## RELATED LINKS

[Information on the nav HTML tag can be found here --> https://www.w3schools.com/tags/tag_nav.asp](https://www.w3schools.com/tags/tag_nav.asp)