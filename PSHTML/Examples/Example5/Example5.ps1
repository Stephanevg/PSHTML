<#
    The following example called 'tribute to Snover' grasps information for the 'shellfather' from around the internet, adn generates a html page with the information.
    # This example ilustrates how we can leverage the power of powershell, to fetch and filter information on various websites (using invoke-webrequest)

    We use foreach to create multiple <p> or <li> elements.
#>

import-module pshtml

$Snover = Html {
    header -content {
        Title "Tribute to snover"
        Write-PSHTMLAsset
        link -rel stylesheet -href "MyStyles.css"
    }
    Body{
        h1 "Tribute to Jeffrey Snover" -Class "Title"

        div -Class "Photo" {

            img -src "https://pbs.twimg.com/profile_images/1039650689620688896/ZZgN5c9Y_400x400.jpg" -alt "Jeffrey Snover photo" -height "400" -width "400" -Class "Photo"
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
    Footer{
        $PSHTMLlink = a {"PSHTML"} -href "https://github.com/Stephanevg/PSHTML"
        h6 "Generated with $($PSHTMLlink)"
    }
}

$Snover > "Example5.html"