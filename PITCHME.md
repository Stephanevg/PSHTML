

@snap[west span-50]
## PSHTML
@snapend

@snap[east span-50]
in 60 seconds
@snapend

---

## What is PSHTML?

---

# PSHTML

Is a Powershell module that allows you to script the generation of html documents using powershell like syntax. It makes creating html pages really easy!

---

PSHTML is a PowerShell DSL (Domain Specific Language). It allows you to leverage your existing knowledge of powershell to create html documents without leaving your IDE. 

No more "html string building"!

---
![](/Images/Example01.jpg)
---


Create websites using *powershell* syntax __only__

---

![](PSHTML/Examples/Example6/tribute_snover.png)

* [Get the code](https://github.com/Stephanevg/PSHTML/blob/master/PSHTML/Examples/Example6/Example6.ps1)

--- 

## Create beautifull graphs in seconds

---

```powershell
#Preparing data
$Data3 = @(4,1,6,12,17,25,18,17,22,30,35,44)
$Labels = @("January","February","Mars","April","Mai","June","July","August","September","October","November","december")

#Creating a DataSet
$dsb3 = New-PSHTMLChartBarDataSet -Data $data3 -label "2018" -BackgroundColor ([Color]::blue )

#Generating the chart
New-PSHTMLChart -type bar -DataSet $dsb3 -title "Bar Chart Example" -Labels $Labels -CanvasID $BarCanvasID

```
---

![](PSHTML/Examples/Charts/Chart01/BarChartExample.png)


---

### Out of the box support for

* BootStrap
* ChartJs
* Query



---

Or benefit of abastractions, and focus only on your Powershell knowledge.


