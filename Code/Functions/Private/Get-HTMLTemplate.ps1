Function Get-HTMLTemplate{
    <#
        .Example



html{
    Body{

        include -name body

    }
    Footer{
        Include -Name Footer
    }
}

#Generates the following HTML code

        <html>
            <body>

            h2 "This comes a template file"
            </body>
            <footer>
            div {
                h4 "This is the footer from a template"
                p{
                    CopyRight from template
                }
            }
            </footer>
        </html>
    #>
    [CmdletBinding()]
    Param(
        $Name
    )

    Throw "This function has been renamed to 'Get-PSHTMLTemplate' and will be removed in a future release .Either use the Alias 'include' or rename your function calls from Get-PSHTMLTemplate to Get-PSHTMLTemplate"
}
