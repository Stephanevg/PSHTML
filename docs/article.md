---
external help file: pshtml-help.xml
Module Name: PSHTML
online version:
schema: 2.0.0
---

# article

## SYNOPSIS
Generates article HTML tag.

## SYNTAX

``` powershell
article [[-Content] <ScriptBlock>] [[-Class] <String>] [[-Id] <String>] [[-Style] <String>]
 [[-Attributes] <Hashtable>] [<CommonParameters>]
```

## DESCRIPTION
{{Fill in the Description}}

## EXAMPLES

### EXAMPLE 1

``` powershell
article {
    h1 "This is blog post number 1"
    p {
        "This is content of blog post 1"
    }
}
```

Generates the following code:

\<article\>
    \<h1\>This is blog post number 1\</h1\>
    \<p\>
        This is content of blog post 1
    \</p\>
\</article\>

### EXAMPLE 2
```
It is also possible to use regular powershell logic inside a scriptblock. The example below, generates a article element
```

based on values located in a powershell object.
The content is generated dynamically through the usage of a foreach loop.

$objs = @()
$objs += new-object psobject -property @{"title"="this is title 2";content="this is the content of article 2"}
$objs += new-object psobject -property @{"title"="this is title 3";content="this is the content of article 3"}
$objs += new-object psobject -property @{"title"="this is title 4";content="this is the content of article 4"}
$objs += new-object psobject -property @{"title"="this is title 5";content="this is the content of article 5"}
$objs += new-object psobject -property @{"title"="this is title 6";content="this is the content of article 6"}

body {

    foreach ($article in $objs){
        article {
            h2 $article.title
            p{
                $article.content
            }
        }
    }
}

Generates the following code:

    \<body\>
        \<article\>
            \<h2\>this is title 2\</h2\>
            \<p\>
            this is the content of article 2
            \</p\>
        \</article\>
        \<article\>
            \<h2\>this is title 3\</h2\>
            \<p\>
            this is the content of article 3
            \</p\>
        \</article\>
        \<article\>
            \<h2\>this is title 4\</h2\>
            \<p\>
            this is the content of article 4
            \</p\>
        \</article\>
        \<article\>
            \<h2\>this is title 5\</h2\>
            \<p\>
            this is the content of article 5
            \</p\>
        \</article\>
        \<article\>
            \<h2\>this is title 6\</h2\>
            \<p\>
            this is the content of article 6
            \</p\>
        \</article\>
    \</body\>

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

[Information on the article HTML tag can be found here --> https://www.w3schools.com/tags/tag_article.asp](https://www.w3schools.com/tags/tag_article.asp)