
PSHTML is a cross platform Powershell module to generate HTML markup language within a DSL.

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


![screen shot of PSHTML results](PSHTML/Examples/Example6/tribute_snover.png)

The example ```PSHTML / Powershell``` code is available [here](PSHTML/examples/Example6/Example6.ps1)

The generated ```HTML``` code is available [here](PSHTML/examples/Example6/Example6.html)

## Documenation

Check out the [Documentation](docs/_HowToUsePSHTML.md) on how to use PSHTML.


## Wanna Contribute?

If you're interessted in contributing to PSHTML please be sure to check out the [Contribution Guide](CONTRIBUTING.md).