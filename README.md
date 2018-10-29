
PSHTML is a cross platform Powershell module to generate HTML markup language within a DSL.

# Summary

`PSHTML` allow people to write a HTML document(s) using `powershell-like` syntax, which makes building webpages easier, and less cumbersome for 'native' powersheller's.

`PSHTML` offers the flexibility of the PowerShell language, and allows to add logic in ```powershell``` directly in the ```HTML``` structure. This open the possibility to add loops, conditional statements, switchs, functions, classes, calling external modules etc.. all that directly from the same editor.

`PSHTML` comes with a templating functionality which allows one to `include` parts of webpages that are identical throughout the web page Eg: footer, Header,Menu etc..


Using PSHTML, offers code completition and syntax highliting from the the default powershell langauge. As PSHTML respects the W3C standards, any HTML errors, will be spotted immediatly.

-----

## Build Status
|Branch|Status|
|---|---|
|master |[![Build status](https://ci.appveyor.com/api/projects/status/tuv9pjxd2bkcgl3x/branch/master?svg=true)](https://ci.appveyor.com/project/Stephanevg/pshtml/branch/master) |
|dev |[![Build status](https://ci.appveyor.com/api/projects/status/tuv9pjxd2bkcgl3x/branch/master?svg=true)](https://ci.appveyor.com/project/Stephanevg/pshtml/branch/dev)|

A change log is available [here](Change_Log.md)
Known issues are tracked [here](Known_Issues.md)

# How to install PSHTML

PSHTML is available on the powershell gallery. You can install it using the following one liner from a powershell console


```Powershell
Find-Module PSHTML | Install-Module
```
# What is PSHTML?

The best way to understand what PSHTML can do, is to skim through some examples.

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

### A more advanced example:

The following example is a tribute to PowerShell GodFather 'Jeffrey Snover' where we generated a BIO of the ShellFather gathering data from Wikipedia and other sources, all that using Powershell.


![screen shot of PSHTML results](PSHTML/Examples/Example6/tribute_snover.png)

The example ```PSHTML / Powershell``` code is available [here](PSHTML/examples/Example6/Example6.ps1)

The generated ```HTML``` code is available [here](PSHTML/examples/Example6/Example6.html)

<<<<<<< HEAD
## Documenation
=======

# Templating

Since version 0.4 it is possible to build websites using templates. this is done by using the keyword `include` and specifiying the name of your template.

The following example showcase how this works:
>>>>>>> 5ee9effd41baa4bc1fbe7047c0d0576370e32fd2

Check out the [Documentation](docs/_HowToUsePSHTML.md) on how to use PSHTML.

## Check out refferences/blog posts

- Introducing PSHTML on [PowershellDistrict](http://powershelldistrict.com/introducing-pshtml/).
- [Multiple Blog posts](https://chen.about-powershell.com/) from [@ChendrayanV](https://twitter.com/ChendrayanV).
- Presentation at [Glasgow Super Meetup](https://youtu.be/QS_gppC5UWQ?t=6246) by [@anthonyroud](https://twitter.com/anthonyroud). 

## See how community members use PSHTML

Find here a few examples where people already used PSHTML in an awesome way.

- Blog post from [@ChendrayanV](https://twitter.com/ChendrayanV) [Autorefresh pages with Polaris and PSHTML](https://chen.about-powershell.com/2018/10/auto-refresh-polaris-page-to-retrieve-status-using-pshtml/)
- [Docker Image](https://hub.docker.com/r/stijnc/pshtml/tags/) with Polaris and PSHTML created by [@StijnCa](https://twitter.com/StijnCa).
- [Build your own API](https://livestream.com/accounts/26955461/PSConfAsia/videos/182130806) Presentation by [@ravikanth](https://twitter.com/ravikanth) at PSConfAsia. The PSHTML part starts at 31 minutes, however it is worth it to watch the whole session.

## Want to Contribute?

If you're interessted in contributing to PSHTML please be sure to check out the [Contribution Guide](CONTRIBUTING.md).