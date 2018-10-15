# PSHTML

Module to generate HTML markup language within a DSL.

# Summary

`PSHTML` allow people to write a HTML document(s) using `powershell-like` syntax, which makes building webpages easier, and less cumbersome for 'native' powersheller's.

`PSHTML` offers the flexibility of the PowerShell language, and allows to add logic in ```powershell``` directly in the ```HTML``` structure. This open the possibility to add loops, conditional statements, switchs, functions, classes, calling external modules etc.. all that directly from the same editor.

`PSHTML` comes with a templating functionality which allows one to `include` parts of webpages that are identical throughout the web page Eg: footer, Header,Menu etc..


Usinng PSHTML, offers code completition and syntax highliting from the the default powershell langauge. As PSHTML respects the W3C standards, any HTML errors, will be spotted immediatly.

-----

## Build Status
|Branch|Status|
|---|---|
|master |[![Build status](https://ci.appveyor.com/api/projects/status/tuv9pjxd2bkcgl3x/branch/master?svg=true)](https://ci.appveyor.com/project/Stephanevg/pshtml/branch/master) |
|dev |[![Build status](https://ci.appveyor.com/api/projects/status/tuv9pjxd2bkcgl3x/branch/master?svg=true)](https://ci.appveyor.com/project/Stephanevg/pshtml/branch/dev)|

A change log is available [here](Change_Log.md)
Known issues are tracked [here](Known_Issues.md)

## A few Basic examples of what PSHTML can achieve

### Basic page

The following quick example displays a simple page, with a few headers, divs, paragraphs, and header elements

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

## A more advanced example:

The following example is a tribute to PowerShell GodFather 'Jeffrey Snover' where we generated a BIO of the ShellFather gathering data from Wikipedia and other sources, all that using Powershell.


![screen shot of PSHTML results](PSHTML/examples/Example6/tribute_snover.png)

The example ```PSHTML / Powershell``` code is available [here](PSHTML/examples/Example6/Example6.ps1)

The generated ```HTML``` code is available [here](PSHTML/examples/Example6/Example6.html)
## Templates

Since version 0.4 it is possible to build websites using templates. The following example showcase how this works:

```Example04/Example04.ps1``` contains the following sample code:

### Example04/Example04.ps1

```powershell


html{
    Header{
        h1 "This is an example generated using PSHTML Templates"
    }
    Body{

        include -name Body

    }
    Footer{
        Include -Name Footer
    }
}

```

Assuming that ```Example4/body.ps1``` and ```Example/Footer.ps1``` contains the following ```pshtml```code:

### body.ps1

```powershell

    h2 "This comes from a template file"

```

### footer.ps1

```powershell
div {
    h4 "This is the footer from a template"
    p{
        "Copyright from template"
    }
}
```

Would generate the following code:

```html

    <header>
        <h1>This is an example generated using PSHTML Templates</h1>
    </header>
    <body>
        <h2>This comes from a template file</h2>
    </body>
    <footer>
        <div>
            <h4>This is the footer from a template</h4>
        </div>
    </footer>
</html>

```
## Generating a (very) basic form

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
## Generating a HTML Table

```PowerShell
$proc = Get-Process | Select-Object -Skip 8 -First 10
$css = 'body{background:#252525;font:87.5%/1.5em Lato,sans-serif;padding:20px}table{border-spacing:1px;border-collapse:collapse;background:#F7F6F6;border-radius:6px;overflow:hidden;max-width:800px;width:100%;margin:0 auto;position:relative}td,th{padding-left:8px}thead tr{height:60px;background:#367AB1;color:#F5F6FA;font-size:1.2em;font-weight:700;text-transform:uppercase}tbody tr{height:48px;border-bottom:1px solid #367AB1;text-transform:capitalize;font-size:1em;&:last-child {;border:0}tr:nth-child(even){background-color:#E8E9E8}'

html {
    head { 
        style {
            $css
        }
    }
    body {
        ConvertTo-HTMLtable -Object $proc -Inline -properties Id, Name, Handles, StartTime, WorkingSet
    }
}  | Out-File 'C:\temp\Example-ConvertTo-HTMLtable.html'
```
Which generate the following HTML page :

![screen shot of PSHTML ConvertTo-HTMLtable results](/Examples/Example-ConvertTo-HTMLtable.png)

# Todo List

There is a lot to accomplish before making this module available to the public.

I plan the following most important milestones:

 - [ ] Provide basic functionality (Generating an HTML document) using the DSL. The following sections are the highest priority:
    - [X] Root
    - [X] Sections
    - [X] Tables
    - [X] blocs
    - [ ] Forms
    - [ ] Textual semantic
    - [X] Metadata

In parallel to this, I want to add the support for the following attributes (as a first step):
- [X] Class
- [X] Id
- [X] Style


Eventually, the following components will also be added:
 - [X] Scripts
 - [X] Include Sections
 - [ ] Interactive Data

## The attribute I want to set is not available

The objective, is to have integrated every tag and every possible attribute in PSHTML. Since this needs to be done on an individual basis (per HTML tag), this task is pretty huge, and will take some time to complete HTML 5 Coverage Below.

In the mean time, two ways are available to you:

1. **Prefered Method:** Add the attribute your self, be forking the repository, and simply adding a parameter to the function. 
2. Use the `-Attributes` parameter.


Each function has an additional parameter called: ```Attributes``` of type HashTable.
It allow to add additional html tags without having to list ALL the existing attributes. It offers flexibility for custom and/or special htmls attributes, or the ones that are not immediatly available to you. (Open an issue, if you want to have an additional parameter for a specific html element. Or, you could add it your self, since this is an open sourced project ;) (Read 'contributing' part here under.

### Example:

```powershell
option -Attributes @{"CustomAttributeName"="MyValue"}

```

generates the following HTML:

```HTML
<option CustomAttributeName="MyValue"  >
</option>
```

## HTML 5 coverage

I would like to have all HTML 5 tags available in PSHTML ASAP. The list is currently ongoing, and this is work in progress. It can be followed [here](https://github.com/Stephanevg/PSHTML/issues/7)

## Contributing

Read how you can `contribute` to `pshtml`by reading the [contributing](/CONTRIBUTING.md) document.


