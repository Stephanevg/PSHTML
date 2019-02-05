

## PSHTML

### In 60 seconds


---

## What is PSHTML?

---

# PSHTML

Is a Crossplatform Powershell module that allows you to script the generation of html documents using powershell like syntax. 

*It makes creating html pages really really easy!*

---

PSHTML is a PowerShell DSL (Domain Specific Language). 

It allows you to leverage your existing knowledge of powershell to create html documents without leaving your IDE. 

No more "html string building" as in 2015!

---

Create websites using *powershell* syntax __only__

---

```Powershell
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
                strong "plop";"Woop"
            }
    }

}
```
---

Use all the techniques you already know.

* Loops (foreach, while, do while, for)
* Conditional statement (if elseIf() /Else, switch etc...)
* Functions, filters, classes

---

Use all the modules that you have learned to love over time

* ActiveDirectory
* ConfigMgr
* FailoverClustering
* PsClassUtils

---

Create Forms

```powershell
p{
    Form -action "CallThisPage.Html" -method get -target _self -Content{
        "Please input your password"
        input -type password "woop"
        "Please Confirm your passwor"
        input -type password -name "woop2"
    }
}
```

---

Create Tables manually

```Powershell
p{
h2 "Example with HTML table"

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

---

Or generate tables dynamically

```powershell
$Process = Get-Process | select -First 3 
$Process | ConvertTo-PSHTMLTable -Properties "Name","Handles"
```

---

Create Drop down boxes

```powershell
p {
    "My favorite car is:"
}
SelectTag {
    option -value "Citroen" -Content "Citroen"
    option -value "Renault" -Content "Renault"
    option -value "Peugeot" -Content "Peugeot"
    option -value "DS" -Content "DS"
}
```

---

Or generate your drop down boxes 'dynamicaly'

```powershell
$Languages = @("PowerShell","Ruby","CSharp","Python")
p {
    "My favorite language is:"
}
SelectTag {
    foreach($language in $Languages){
        option -value $language -Content $language
    }
}
```

---
Use `includes` to reuse specific chunks of code in different places

```powershell
html{
    include -Name head

    Body{

        include -name Body
        
        $PrimaryColors = @("Red","green","blue")

        H3 "Primary color are:"
        ul {
     
            Foreach($PColor in $PrimaryColors){
                
                li $PColor
            }
        }
        p {
            "This is just content after the unorded list but before the footer."
        }
    }
    
    Include -Name Footer
}
```

---
Out of the box support for assets such as

* BootStrap
* ChartJs
* Query

---
#### You love VSCode? 
##### So do we!

PSHTML comes with VScode snipets ready to be installed.

Install them using

```powershell
Install-PSHTMLVsCodeSnippets
```
---

All snippets start with the word `pshtml`

![](/Images/snippets.jpg)

---
PSHTML support the creation of custom charts
![](/docs/Images/Charts_Overview.png)
---

It is very easy to do, and needs only a few seconds using

```powershell
New-PSHTMLChart
```

---

Example:
```powershell
#Preparing data
$Data3 = @(4,1,6,12,17,25,18,17,22,30,35,44)
$Labels = @("January","February","Mars","April","Mai","June","July","August","September","October","November","december")

#Creating a DataSet
$dsb3 = New-PSHTMLChartBarDataSet -Data $data3 -label "2018" -BackgroundColor ([Color]::blue )

#Generating the chart
New-PSHTMLChart -type bar -DataSet $dsb3 -title "Bar Chart Example" -Labels $Labels -CanvasID $BarCanvasID

```
---?image=PSHTML/Examples/Charts/Chart01/BarChartExample.png&size=25%
---

Add your HTML / CSS knowledge directly in your PSHTML code.

---

Every PSHTML tag cmdlet comes with the following parameters:

* ```-Class``` -> Add classes to you html tags
* `-Style` -> Add inline styles to your html tags
* `-Attributes` -> Add custom attributes with values to your html tags.

---

### -Class 
-> Add classes to you html tags

#### Example

```powershell
p -Class "My Class" {
    "This is simply a paragraph in a div."
} 
```

Generates

```html
<p Class="My Class" >
  This is simply a paragraph in a div.
</p>
```

---

### -Style 
-> Add inline styles to your html tags

#### Example

```powershell
p -Style "color:blue;margin-left:30px;" {
    "This is simply a paragraph in a div."
} 
```

Generates

```html
<p Style="color:blue;margin-left:30px;" >
  This is simply a paragraph in a div.
</p>
```

---

### -Attributes 
-> Add custom attributes with values to your html tags.

#### Example

```powershell
p {
    "This is simply a paragraph in a div."
} -Attributes @{"MyCustomAttribute"="My custom value"}
```

Generates

```html
<p MyCustomAttribute="My custom value" >
  This is simply a paragraph in a div.
</p>
```
---

# Your only limitation is your imagination

---

```PowerShell
<#
    Tribute to Snover but added CSS styles and bootstrap.
    The following example called 'tribute to Snover' grasps information for the 'shellfather' from around the internet, adn generates a html page with the information.
    # This example ilustrates how we can leverage the power of powershell, to fetch and filter information on various websites (using invoke-webrequest)

    We use foreach to create multiple <p> or <li> elements.
#>

import-module .\pshtml.psd1

$Snover = Html {
    head -content {
        Title "Tribute to snover"
        #Linking to bootstrap

        $AllLinks = @()
        $AllLinks += @{
            "rel" = "stylesheet"
            "href" = "https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css"
            "Integrity" = "sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB"
            "crossorigin"= "anonymous"
        }

        $AllLinks += @{
            "rel" = "stylesheet"
            "href" = "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css"
            "Integrity" = "sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp"
            "crossorigin"= "anonymous"
        }

        $ScriptParams = @()

        $ScriptParams += @{

            "src" = "https://code.jquery.com/jquery-3.3.1.slim.min.js"
            "integrity"="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
            "crossorigin"="anonymous"
        }

        $ScriptParams += @{

            "src" = "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
            "integrity"="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
            "crossorigin"="anonymous"
        }

        $scriptParams += @{

            "src" = "https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
            "integrity"="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
            "crossorigin"="anonymous"
        }

        $scriptParams += @{

            "src" = "https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"
            "integrity"="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T"
            "crossorigin"="anonymous"
        }

        foreach ($link in $AllLinks){
            link @link
        }


        foreach ($ScriptParam in $ScriptParams){

            script @ScriptParam
        }


        link -rel stylesheet -href "MyStyles.css"
    }
    Body{

        div -Class "container" {
            div -Class "text-center" {

                h1 "Tribute to Jeffrey Snover" -Class "Title"

                img -src "https://pbs.twimg.com/profile_images/618804166631145473/2q6yharL_400x400.jpg" -class "rounded-circle" -alt "Jeffrey Snover photo" -height "400" -width "400"


            }
            div -id "Bio" {
                $WikiRootSite = "https://en.wikipedia.org"
                $Source = a {"Wikipedia"} -href $WikiRootSite
                h2 "Biography"
                h4 "Source --> $Source"

                #Gathering the biography information from Wikipedia
                $wiki = Invoke-WebRequest -Uri ($WikiRootSite + "/wiki/Jeffrey_Snover")
                $Output = $Wiki.ParsedHtml.getElementById("mw-content-text").children | Where-Object -FilterScript {$_.ClassName -eq 'mw-parser-output'}
                $Bio = $Output.Children | Where-Object -FilterScript {$_.TagName -eq 'p'} | Select-Object -Property Tagname,InnerHtml

                foreach ($p in $bio){
                    if($p.InnerHtml -ne $null){
                        #The url are relative on Wiki website. Correcting it here so that the Links are still working
                        $Corrected = $p.innerHTML.Replace("/wiki/","$WikiRootSite/wiki/")
                        p{

                            $Corrected
                        }
                    }


                }

            }#End Accomplishements
            Div -id "Snoverisms" {
                $SnoverismsSite = "http://snoverisms.com/"

                h2 "Snoverisms"
                h4 "Source --> $SnoverismsSite"

                $Page = Invoke-WebRequest -Uri $SnoverismsSite
                $Snoverisms = $Page.ParsedHtml.getElementsByTagName("p") | Where-Object -FilterScript {$_.ClassName -ne "site-description"} | Select-Object -Property innerhtml
                $Snoverisms += (Invoke-WebRequest -uri "http://snoverisms.com/page/2/").ParsedHtml.getElementsByTagName("p") | Where-Object -FilterScript {$_.ClassName -ne "site-description"} | Select-Object -Property innerhtml

                ul -id "snoverism-list" -Content {
                    Foreach ($snov in $Snoverisms){

                        li -Class "snoverism" -content {
                            $snov.innerHTML
                        }
                    }

                }#end of ul
            }
        }
    }
    Footer{
        $PSHTMLlink = a {"PSHTML"} -href "https://github.com/Stephanevg/PSHTML"
        h6 "Generated with $($PSHTMLlink)"
    }
}

$Snover > "Example6.html"
```

---?image=PSHTML/Examples/Example6/tribute_snover.png&size=50%

---


Get started:

* [Github](https://github.com/Stephanevg/PSHTML)
* [Read the docs](https://pshtml.readthedocs.io/en/latest/)
* [PowerShellDistrict](http://www.powershelldistrict.com)

```powershell
Install-Module PSHTML
```

Look at code samples

* [Tribute to Snover](https://github.com/Stephanevg/PSHTML/blob/master/PSHTML/Examples/Example6/Example6.ps1)
