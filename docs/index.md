# Welcome to the PSHTML documentation page

## What is PSHTML

PSHTML is a cross platform powershell module that allows to renders HTML using powershell syntax.
It is currently supported on Windows and Linux.

## Prerequisites

In order to work, the following prerequisites need to be met:

- Up until **PSHTML version 0.6.1** -> **Powershell v3**
- From **PSHTML version 0.7.0** and above -> **PowerShell version 5.1 or higher**.

## Installation

In order to install, use the following methodology


### Internet access is possible

```powershell
#(Assuming Access to internet is possible)
Install-Module PSHTML
```

### Internet access is **not** possible


- Download the sources from the release page [here](https://github.com/Stephanevg/PSHTML/releases/tag/v0.7.0)
- Unzip the sources to a temporary location. (Example: ```$Home/Temp/PSHTMLSources/```)
- Copy the ```$Home/Temp/PSHTMLSources/PSHTML/``` files to a repository of your PSModulePath (See below)
- To find an acceptable path for the module, run ```  $env:PSModulePath -split ";" ```. Choose simply one from the list.


## Getting started

Go through the example folder located in the module folder or / and have a look at them [here](https://github.com/Stephanevg/PSHTML/tree/v0.7.0/PSHTML/Examples)

run the following command:

```powershell
import-module PSHTML
Get-Command -Module PSHTML
```

## Example

A basic and straight forward example is the following one:

```powershell
Import-Module PSHTML

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
            
            }
    }

}
```

A lot of examples can be found in the ```/Examples/``` inside the module folder. The same examples are also available online [here](https://github.com/Stephanevg/PSHTML/tree/v0.7.0/PSHTML/Examples).