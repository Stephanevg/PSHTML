# PSHTML
Module to generate HTML markup language within a DSL

# Example

PSHTML allow people to write a HTML document using powershell-like syntax, which makes building a webpage easier, and less cumbersome.

## A few Basic examples

### Basic page

```Powershell

html {

    head{

        title "woop title"
        link "css/normalize.css" "stylesheet"
    }

    body{

        Header {
            h1 "This is h1 Title in header"
            div {
                p {
                    "This is simply a paragraph in a div."
                }
            }
        }
    
        
            p {
                h1 "This is h1"
                h2 "This is h2"
                h3 "This is h3"
                h4 "This is h4"
                h5 "This is h5"
                h6 "This is h6"
                strong "plop";"Woop"
            }
    }
    
}

```

### Generating a (very) basic form

```PowerShell
form "MyPage.php" post _self -Content {

    input "text" "FirstName"
    input "text" "LastName"
    input submit "MySubmit"
}
```

Which generates the following code:

```html
<form action="MyPage.php" method="post" target="_self" >
<input type="text" name="FirstName" >
<input type="text" name="LastName" >
<input type="submit" name="MySubmit" >
</form>
```


# Todo List

There is a lot to accomplish before making this module available to the public. 

I plan the following most important milestones:

 - [ ] Provide basic functionality (Generating an HTML document) using the DSL. The following sections are the highest priority:
    - [X] Root
    - [ ] Sections
    - [X] Tables
    - [ ] blocs
    - [ ] Forms
    - [ ] Textual semantic

In parallel to this, I want to add the support for the following attributes (as a first step):
- [ ] Class
- [ ] Id
- [ ] Style


Eventually, the following components will also be added:
 - [ ] Scripts
 - [ ] Include Sections
 - [ ] Interactive Data




## Root
- [X] ```<html>```
    - [ ] Add support for lang attribute
## MetdaData
- [X] ```<head>```
- [X] ```<title>```
- [ ] ```<base>```
- [X] ```<link>```
- [ ] ```<meta>```
- [ ] ```<style>```

## Scripts

- [X] ```<script>```
- [X] ```<noscript>```	

## Sections
- [X] ```<body>```
- [ ] ```<section>```
- [ ] ```<nav>```
- [ ] ```<article>```
- [ ] ```<aside>```
- [X] ```<h1>```
- [X] ```<h2>```
- [X] ```<h3>```
- [X] ```<h4>```
- [X] ```<h5>```
- [X] ```<h6>```
- [ ] ```<hgroup>``` (Really needed?)
- [X] ```<header>```
- [X] ```<footer>```
- [ ] ```<address>```

## blocs
- [X] ```<div>```
- [ ] ```<p>```
    - [ ] Add support for title attribute
- [ ] ```<hr>```
- [ ] ```<pre>```
- [ ] ```<blockquote>```
- [ ] ```<ol>```
- [ ] ```<ul>```
- [ ] ```<li>```
- [ ] ```<dl>```
- [ ] ```<dt>```
- [ ] ```<dd>```
- [ ] ```<figure>```
- [ ] ```<figcaption>```


## Tables
- [X] ```<table>```
- [X] ```<tbody>```
- [X] ```<thead>```
- [X] ```<tfoot>```
- [X] ```<tr>```
- [X] ```<td>```
- [X] ```<th>```
- [X] ```<caption>```
- [X] ```<colgroup>```
- [X] ```<col>```

## Textual semantic
- [X] ```<a>```
- [ ] ```<em>```
- [ ] ```<strong>```
- [ ] ```<small>```
- [ ] ```<s>```
- [ ] ```<cite>```
- [ ] ```<q>```
- [ ] ```<dfn>```
- [ ] ```<abbr>```
- [ ] ```<data>```
- [ ] ```<time>```
- [ ] ```<code>```
- [ ] ```<var>```
- [ ] ```<samp>```
- [ ] ```<kbd>```
- [ ] ```<sub>```
- [ ] ```<sup>```
- [ ] ```<i>```
- [ ] ```<b>```
- [ ] ```<u>```
- [ ] ```<mark>```
- [ ] ```<ruby>```
- [ ] ```<rt>```
- [ ] ```<bdi>```
- [ ] ```<bdo>```
- [ ] ```<span>```
- [ ] ```<br>```
- [ ] ```<wbr>```


## include sections
- [X] ```<img>```
- [ ] ```<iframe>```
- [ ] ```<object>```
- [ ] ```<param>```
- [ ] ```<video>```
- [ ] ```<audio>```
- [ ] ```<source>```
- [ ] ```<track>```
- [ ] ```<canvas>```
- [X] ```<map>```
- [X] ```<area>```
- [ ] ```<svg>```
- [ ] ```<math>```

## Forms
- [X] ```<form>```
- [ ] ```<fieldset>```
- [ ] ```<legend>```
- [ ] ```<label>```
- [X] ```<input>```
    - [ ] Add support for disabled attribut
- [ ] ```<button>```
- [ ] ```<select>```
- [ ] ```<datalist>```
- [ ] ```<optgroup>```
- [ ] ```<option>```
- [ ] ```<textarea>```
- [ ] ```<keyben>```
- [ ] ```<output>```
- [ ] ```<progress>```
- [ ] ```<meter>```

## Interactive data

- [ ] ```<detail>```
- [ ] ```<command>```
- [ ] ~~```<menu>```~~ --> This feature will not be implemented, since this feature is only avaible in Firefox.

## Function Design:


### Passing attributes

Every HTML tag (PSHTML Function) should have 'at least' the following attributes available:
- Class
- ID
- Style

these are - in my opinion- the most commonly used attributes in HTML.

### Additional Attributes

Each function will have an additional parameter called: ```Attributes``` of type HashTable.
It will allow to add ad