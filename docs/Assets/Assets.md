# Asset management in PSHTML

Since version **0.7.3** of PSHTML it is possible to work with __assets__

Working with assets, allows one to provide references dynamically to scripts and style files that are hosted locally, in the PSHTML folder.
```
Since version 0.8.0 It is possible to create CDN assets. Which allows to create references for script / styles tags and to point them to internet locations.
More below..
```

This is **very** usefull for cases where there is no internet connection, and where scenarios like adding bootstrap, or using charts (Using [New-PSHTMLChart](../Charts/Charts.md)) 

> We have specifically tried to eas the user exeperience. writting ```Write-PSHTMLAsset -Name ``` and pressing ```TAB``` will list the current assets currently available to you. (Read below for a list of default ones).

## How to

Use ```write-PSHTMLAsset``` function in order to add a reference to one of the assets.

## Available assets

PSHTML comes with 3 default assets which are considered as the most widley used.
- BootStrap
- JQuery
- ChartJs

> The later one is needed for the support of PSHTML Charts functionality.

The above assets, are full fledged web frameworks that one can immediatly start using.
There is also a more `generic` type of asset called `cdn asset`.

It cover cases where the webframeworks you want to link in your HTML document, are located on CDN's on the internet / intranet.

## Finding out available assets

Use ```Get-PSHTMLAsset``` to find out which assets are available on your system.

## Example 1

The code here under would be defined in script named ```script1.ps1```.

```powershell
html {
    head {
        title 'Assets Example'
        Write-PSHTMLAsset -Type Script -Name BootStrap
    }
    body {
         h1 'Simple Asset example'
    }
}
```

Executing ```script1.ps1``` returns the following code:

```html
<html ><head ><title >Assets Example</title><Script src='BootStrap/bootstrap.bundle.min.js'></Script></head><Body ><h1 >Simple Asset example</h1></Body></html>
```

> Setting the ```-Type``` parameter to "Script", forced the search to be done only on `Javascript` files.

## Example 2

The code here under would be defined in script named ```script2.ps1```.

```powershell
html {
    head {
        title 'Example Asset - Styles'
        Write-PSHTMLAsset -Type Style -Name BootStrap
    }
    body {
         h1 'Asset example adding a reference to a styles (.css) file.'
    }
}
```

Executing ```script2.ps1``` returns the following code:

```html
<html ><head ><title >Example Asset - Styles</title><Link src='BootStrap/bootstrap.min.css'></Link></head><Body ><h1 >Asset example adding a reference to a styles (.css) file.</h1></Body></html>
```

## Example 3

Notice how ```Bootstrap```has the need to link to one ```.css``` and one ```.js``` file.
It could even be that some other frameworks have several js files.

If the order is not important,  it is possible to add the correct reference for all the framework files in one and easy step.

The code here under would be defined in script named ```script3.ps1```.

```powershell
html {
    head {
        title 'Asset Example - Adding all needed references'
        Write-PSHTMLAsset -Name BootStrap
    }
    body {
         h1 'Example Adding all Asset references in one shot'
    }
}
```

Executing ```script3.ps1``` returns the following code:

```html
<html >
    <head >
        <title >Asset Example - Adding all needed references</title>
        <Script src='BootStrap/bootstrap.bundle.min.js'></Script>
        <Link src='BootStrap/bootstrap.min.css'></Link>
    </head>
    <Body >
        <h1 >Example Adding all Asset references in one shot</h1>
    </Body>
</html>
```

## Adding custom assets

It is possible to add custom Assets to PSHTML.

For this, create a folder in the Assets folder located in the PSHTML module root folder.
In that newly created folder, copy and paste your .Js/.css files in.

To list ones currently available to you, use `Get-PSHTMLAsset`

To add a reference to your custom asset, add your files in a Folder called 'CustomAssets' in the Assets folder of PSHTML, Import the module (Or reload the module) and using `write-pshtmlAsset` to add reference to your custom code.

> Write-PSHTMLAsset has dynamic parameters, you can simply type -Name and press tab, to see all the available assets.

Currently, these are the supported asset types:

- Script (.js files)
- styles (.css files)
- cdn (.cdn files)

## Asset Type: Script

The script asset type allows one to reference JS script files into your html document.
Script files will be converted to ``` <script src=''> </script> ``` html tags, with the src attribute pointing to script file location on disk.

## Asset Type: style

The script asset type allows one to link .css files into your html.
CSS files will be converted to ``` <style link=''> </style> ``` html tags, with the link attribute pointing to css file location on disk.

## Asset Type: CDN

The CDN asset type allows one to link .css / reference .js files into your html pages.
This is convenient for frameworks that offers CDN references on the internet, and when your HTML document is located somwhere where it can access the internet.

The CDN Asset is smart enough to distinguish if the Asset is a Style or a Script asset, based on the content that the `.CDN`file contains.

### CDN file strucutre

A .CDN file is specific to PSHTML. It needs to be located in a subfolder, under the Assets folder of your script.

> A .CDN file is actually nothing more than a json file with a .CDN extention containing specific properties according to which type of CDN asset has been created (Style or Script):

The following properties are available in Script / Style CDN asset files

- Integrity
- Crossorigin

Specify type of CDN's have specific type of properties

#### Script

The following properties will be additionaly present in a `script .CDN` file.

- Source

#### Style

The following properties will be additionaly present in a `style .CDN` file.

- href
- link (has a default of 'stylesheet' but can be overwritten using `New-PSHTMLCDNASsetFile -Link`)

To create an empty CDN file, one can create it from scratch manually / programmatically or by using the cmdlet ``` New-PSHTMLCDNAssetFile ```



### Example

You have a company styles file called ```CoreStyles.css``` which you would like to use in your PSHTML scripts.
Simply create a folder called ```CompanyCore``` in the Assets folder of the PSHTML module root folder, and copy and paste the ```coreStyles.Css``` file in it.
Use the ```Write-PSHTMLAsset``` cmdlet and tab through the ```-Name``` parameter values up until you find 'CompanyCore'.

> The name of the folder is actually used under the hood to dynamically generate the different values that the ```-Name``` parameter from the ```Write-PSHTMLAsset``` cmdlet. The ```-Type``` switch will allow to filter either on only CSS files (Styles) or on .JS files (Script). If more then one file is present in the folder, but no type nor name is speicified, then all will be rendered.

Use it like this to use it

```powershell
html {
    head {
        title "Adding CompanyCore style example"
        Write-PSHTMLAsset -Name CompanyCore
    }
    body {
         h1 'Example Adding all Asset references in one shot'
    }
}
```
