---
external help file: pshtml-help.xml
Module Name: PSHTML
online version:
schema: 2.0.0
---

# Caption

## SYNOPSIS
Generates a caption HTML tag.

## SYNTAX

``` powershell
Caption [[-Content] <Object>] [[-Class] <String>] [[-Id] <String>] [[-Style] <String>]
 [[-Attributes] <Hashtable>] [<CommonParameters>]
```

## DESCRIPTION
{{Fill in the Description}}

## EXAMPLES

### EXAMPLE 1

The following examples show cases how to create an empty caption, with a class, an ID, and, custom attributes.

``` powershell
caption -Class "myclass1 MyClass2" -Id myid -Attributes @{"custom1"='val1';custom2='val2'}
```

Generates the following code:

\<caption Class="myclass1 MyClass2" Id="myid" custom1="val1" custom2="val2"  \>
\</caption\>

### EXAMPLE 2

The caption is used in the construction of the HTML table. The following example illustrates how the caption could be used.

``` powershell
table{
            caption "This is a table generated with PSHTML"
            thead {
                tr{
                    th "number1"
                    th "number2"
                    th "number3"
                }
            }
            tbody{
                tr{
                    td "Child 1.1"
                    td "Child 1.2"
                    td "Child 1.3"
                }
                tr{
                    td "Child 2.1"
                    td "Child 2.2"
                    td "Child 2.3"
                }
            }
            tfoot{
                tr{
                    td "Table footer"
                }
            }
        }
    }
```

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
Current version 1.1.0
History:
    2018.04.10;Stephanevg; Added parameters
    2018.04.01;Stephanevg;Creation.

## RELATED LINKS

[Information on the caption HTML tag can be found here --> https://www.w3schools.com/tags/tag_caption.asp](https://www.w3schools.com/tags/tag_caption.asp)