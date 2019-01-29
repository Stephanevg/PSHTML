$Html = html {
    head {
        title 'Simple Bootstrap'
        Write-PSHTMLAsset -Name Jquery
        Write-PSHTMLAsset -Name BootStrap
        
    }
    body {
        div -Class "Container"{

            h1 -Class "text-uppercase" 'Implementing BootStrap example.'
            P  {
                "This is a very simple example to demonstrate how Bootstrap integrated with PSHTML"
            }
        }
    }
}

$Html > ".\Export.html"
start .\Export.html