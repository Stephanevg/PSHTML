# Includes

The include functionality allows one to include PSHTML content into a another PSHTML document.
This is very usefull to reuse common parts of a HTML document which doesn't change, but which have to be present on every page.
Ideally, 'includes' would be used use for footer, header or menus, or anything that must remain identical on more then two pages. 

## Basics

An include file is nothing more than a regular powershell file (.ps1) which contains pshtml code. 


Include files must be located in the following location:
```powershell
$PSScriptRoot\Includes
```

> The include files are loaded into memory during the import of the module. If your Include file is not available, try re-loading the module using ```import-module pshtml -Force```.

## Example

File `$PSModuleRoot/Includes/footer.ps1`

```powershell
div -Id "plop"{
    p {
        span -Class "footer" {
            "Copyright 2019"
        } 
    }
}
```

Main script:

```powershell

html {
    head {
        
    }
    body {
     
    include -Name footer
    }
} 

```

> Did you know that `include` is an alias for `Write-PSHTMLInclude`.

Result:

```html
<html >
    <head ></head>
    <Body >
        <footer >
            <div Id="plop"  >
                <p >
                    <span Class="footer"  >"Copyright 2019"</span>
                </p>
            </div>
        </footer>
    </Body>
</html>
```

## Find available include files:

In order to list the available include files, the `Get-PSHTMLInclude` cmdlet can be used.

To find a specific include file, use the `-Name` parameter of Get-PSHTMLInclude.

> The name of an include file is the name of the powershell script containing the code, without the extension.
    Example: Footer.ps1 The name will be 'Footer'