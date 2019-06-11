---
external help file: pshtml-help.xml
Module Name: PSHTML
online version:
schema: 2.0.0
---

# li

## SYNOPSIS
Create a li tag in an HTML document.

## SYNTAX

``` powershell
li [[-Content] <Object>] [[-Class] <String>] [[-Id] <String>] [[-Style] <String>] [[-Attributes] <Hashtable>]
 [[-Value] <Int32>] [<CommonParameters>]
```

## DESCRIPTION
he \<li\> tag defines a list item.

The \<li\> tag is used in ordered lists(\<ol\>), unordered lists (\<ul\>), and in menu lists (\<menu\>).

## EXAMPLES

### EXAMPLE 1

``` powershell
li
```

### EXAMPLE 2

``` powershell
li "woop1" -Class "class"
```

### EXAMPLE 3

``` powershell
li "woop2" -Class "class" -Id "Something"
```

### EXAMPLE 4

``` powershell
li "woop3" -Class "class" -Id "something" -Style "color:red;"
```

### EXAMPLE 5

The following code snippet will get all the 'snoverism' from www.snoverisms.com and put them in an UL.

``` powershell
$Snoverisms += (Invoke-WebRequest -uri "http://snoverisms.com/page/2/").ParsedHtml.getElementsByTagName("p") | ?
{$_.ClassName -ne "site-description"} | Select-Object -Property innerhtml

    ul -id "snoverism-list" -Content {
        Foreach ($snov in $Snoverisms){

            li -Class "snoverism" -content {
                $snov.innerHTML
            }
        }
    }
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

### -Value
{{Fill Value Description}}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Current version 1.1
   History:
    2018.04.14;stephanevg;Added Attributes parameter.
Upgraded to v1.1.1
    2018.04.14;stephanevg;fix Content bug.
Upgraded to v1.1.0
    2018.04.01;bateskevinhanevg;Creation.

## RELATED LINKS

[Information on the li HTML tag can be found here --> https://www.w3schools.com/tags/tag_li.asp](https://www.w3schools.com/tags/tag_li.asp)