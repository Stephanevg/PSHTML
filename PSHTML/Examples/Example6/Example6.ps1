<#
    Tribute to Snover but added CSS styles and bootstrap.
    The following example called 'tribute to Snover' grasps information for the 'shellfather' from around the internet, adn generates a html page with the information.
    # This example ilustrates how we can leverage the power of powershell, to fetch and filter information on various websites (using invoke-webrequest)

    We use foreach to create multiple <p> or <li> elements.
#>

import-module pshtml

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

                img -src "https://pbs.twimg.com/profile_images/1039650689620688896/ZZgN5c9Y_400x400.jpg" -class "rounded-circle" -alt "Jeffrey Snover photo" -height "400" -width "400"


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
start .\Example6.html