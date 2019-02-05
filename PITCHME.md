---

@snap[west span-50]
## PSHTML
@snapend

@snap[east span-50]
in 60 seconds
@snapend

---

## What is PSHTML?

@snap[west span-50]
It is a PowerShell DSL (Domain Specific Language) to generate HTML language.
PSHTML is a languge tool.
@snapend

@snap[east span-50]
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
                strong "plop";"Woop"
            }
    }

}
```
@snapend

--- 

---

@snap[west span-50]
## Create websites using *powershell* syntax __only__
@snapend

@snap[east span-50]
![](PSHTML\Examples\Example6\tribute_snover.png)
@snapend

--- 


@snap[west span-33]
## Create beautifull graphs in seconds
@snapend

@snap[east span-33]

```powershell
#Preparing data
$Data3 = @(4,1,6,12,17,25,18,17,22,30,35,44)
$Labels = @("January","February","Mars","April","Mai","June","July","August","September","October","November","december")

#Creating a DataSet
$dsb3 = New-PSHTMLChartBarDataSet -Data $data3 -label "2018" -BackgroundColor ([Color]::blue )

#Generating the chart
New-PSHTMLChart -type bar -DataSet $dsb3 -title "Bar Chart Example" -Labels $Labels -CanvasID $BarCanvasID

```

@snapend

@snap[east span-33]
![](PSHTML\Examples\Charts\Chart01\BarChartExample.png)
@snapend

---

@snap[west span-55]
## Out of the box support for
@snapend

@snap[east span-50]
- BootStrap
- ChartJs
- Query
@snapend

---
@snap[west span-50]

Take advantage of your existing HTML / CSS knowledge
@snapend

@snap[east span-50]

## Image of HTML Table creation
@snapend

---
@snap[west span-50]

Or benefit of abastractions, and focus only on your Powershell knowledge.
@snapend

@snap[east span-50]
## Image of ConvertTo-PSHTMLTable
@snapend

