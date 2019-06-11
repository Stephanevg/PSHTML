# Overview of Changes

The latest version of the help documentation is directly available [Here](https://pshtml.readthedocs.io/en/latest/)

## v0.7.11
- Fixed minor bug with ConvertTo-PSHTMLTable

## v0.7.10
- Updates on 'Form': (See #212 / #213) -> Thanks to @TylerLeonhardt for reporting the issues.
- Updates on 'ConvertTo-PSHTMLTable': Added support for PipelineInput -> Thanks to @lxlechat

## v0.7.9
- Added Out-PSHTMLDocument

## v0.7.8
- Depreacted `convertTo-HtmlTable' and replaced it with `ConvertTo-PSHTMLTable`
- Enahanced ConvertTo-PSHTMLTable for customization with following properties: 
- TableID,TableClass,TableStyle,TableAttributes,TheadID,TheadClass,TheadStyle,TheadAttributes,TbodyID,TBodyClass,TbodyStyle,TbodyAttributes

## v0.7.7
- Added help for include functionality.
- Added pester tests for Include functionality. 
- Fixed minor bug fixes

## v0.7.6
- enhanced 'include' functionality of PSHTML. Added Write-PSHTMLInclude, Added Get-PSHTMLInclude. 

## v0.7.5
- Added support for 'span' tag
- Added 'base - BootStrap/JQuery' vsCode snippet
- Added 'base - BootStrap/JQuery/ChartJS' vsCode snippet
- Fixed minor bugs


## v0.7.4
- Added documentation for Assets (Get-PSHTMLAsset, Write-PSHTMLAsset)
- Minor bug fixes.

## v0.7.3
- Added Support for Assets -> BootStrap, Jquery and chartjs are now part of PSHTML, and are ready to use. See Write-PSHTMLAsset for more information. 👍
- Added support for Configuration -> it is now to configure PSHTML settings centrally from the ```pshtml.configuration.json``` file located in the module root folder.

## v0.7.2
- Added support log file 👍
- Added public functions to export.

## v0.7.1
- Improved modue loading time by 91% (!!) by switching to single psm1 file.
- Added support for configuration 👍

## v0.7.0
- Added support for Charts 👍
- Introduced dependency on PowerShell version 5.1 or higher (intensive use of classes)


