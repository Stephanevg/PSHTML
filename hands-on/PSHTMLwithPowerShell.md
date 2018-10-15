# PSHTML 💗  Polaris

With the help of PSHTML and [Polaris](https://github.com/PowerShell/Polaris) we can build good HTML based web applications. This document will be updated in regular schedule to share real world examples using PSHTML with Polaris. As a first step here is the get started examples.

> The below example shows inlined example. 

```PowerShell
Import-Module Polaris -Verbose 
Import-Module PSHTML -Verbose
New-PolarisGetRoute -path '/helloworld' -ScriptBlock {
    $Html = html {
        head {
            title "PSHTML + Polaris Demo"
        }
        body {
            h1 "Hello World!"
        }
    }
    $Response.SetContentType('text/html')
    $Response.Send($Html)
}

Start-Polaris -Port 8080
```

> Now comes the Organized approach!

## First and foremost we need to create a folder structure. For our demo it will be like illsutrated below 

```
├── projectroot
    ├── routes
│   ├── HelloWorld.ps1
└── server.ps1
```
> server.ps1 - snippet 

```PowerShell
Import-Module Polaris -Verbose 
Import-Module PSHTML -Verbose

foreach($route in (Get-ChildItem -Path .\routes)) {
    . $route.FullName
}

Start-Polaris -Port 8080
```

> helloworld.ps1 - snippet (Routes are case sensitive)

```PowerShell
New-PolarisGetRoute -path '/helloworld' -ScriptBlock {
    $Html = html {
        head {
            title "PSHTML + Polaris Demo"
        }
        body {
            h1 "Hello World!"
        }
    }
    $Response.SetContentType('text/html')
    $Response.Send($Html)
}
```