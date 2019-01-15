
import-module ".\PSHTML\PSHTML.psd1" -Force

$Document = html {

    head {

        title "Syntax Highligthing"
        link "css/normalize.css" "stylesheet"

        # Those 2 links are responsible for Highlighting. I am hosting them on my webpage since it's not located on any CDN
        # Also this version is still Release Candidate so not stable
        link -rel stylesheet -href "https://evotec.xyz/wp-content/uploads/pswritehtml/enlighterjs.min.css"
        script -type text/javascript -src "https://evotec.xyz/wp-content/uploads/pswritehtml/enlighterjs.min.js"
    }

    body {

        Header {
            img "https://i0.wp.com/powershelldistrict.com/wp-content/uploads/2016/01/logo_pd_quadri.png" "logo powershell" -height 100 -width 400
            h1 "This examples shows syntax highligthing done in PowerShell"
        }

        div {
            $PreAttributesJS = [ordered]@{
                'data-enlighter-language'    = "js"
                'data-enlighter-theme'       = "rowhammer"
                'data-enlighter-group'       = "LetsGroupThem"
                'data-enlighter-title'       = "My code in JavaScript"
                'data-enlighter-linenumbers' = "true"
                'data-enlighter-highlight'   = "5"
                'data-enlighter-lineoffset'  = ""
            }

            $PreAttributesXML = [ordered]@{
                'data-enlighter-language'    = "xml"
                'data-enlighter-theme'       = ""  # this doesn't matter as it's grouped so it will take theme from 1st value
                'data-enlighter-group'       = "LetsGroupThem"
                'data-enlighter-title'       = "My code in XML"
                'data-enlighter-linenumbers' = "true"
                'data-enlighter-highlight'   = "3"
                'data-enlighter-lineoffset'  = ""
            }

            $CodeBlockJS = @'
//refresh page on browser resize
$(window).bind("resize", function(e) {
    if (window.RT) clearTimeout(window.RT);
    window.RT = setTimeout(function() {
        this.location.reload(false); /* false to get page from cache */
    }, 200);
}
'@
            $CodeBlockXML = @'
<!--?xml version="1.0" encoding="UTF-8"?-->
<building name="GlobalDynamics Main Building" core:id="0xFA8A91C6617DFA1B" core:uid="0898213-123123123-1230898123" xmlns:core="http://www.xmlnamespace.tld">
<core:group core:level="2">
    <room number="123">Conference Room A</room>
    <room number="124">Conference Room B</room>
    <room number="125">Conference Room C</room>
    <room number="126">Conference Room D</room>
</core:group>
</building>
'@

            pre -Attributes $PreAttributesJS -Content $CodeBlockJS
            pre -Attributes $PreAttributesXML -Content $CodeBlockXML

        }

        br
        br

        div {
            $PreAttributes = [ordered]@{
                'data-enlighter-language'    = "powershell"
                'data-enlighter-theme'       = "droide"
                'data-enlighter-group'       = ""
                'data-enlighter-title'       = "My code in PowerShell"
                'data-enlighter-linenumbers' = "true"
                'data-enlighter-highlight'   = "10-13, 23-68, 73-86, 92-105"
                'data-enlighter-lineoffset'  = ""
            }
            $CodeBlock = (Get-Content ".\PSHTML\Examples\Example - Syntax Code\Example - Syntax.ps1") -join "`n"

            pre -Attributes $PreAttributes -Content $CodeBlock
        }

    }
    Footer {
        # this is required for Highlighter to work it basically definees
        # you can add more defaults and then skip attributes above
        script -type text/javascript -content {
            @"
                // INIT CODE - simple page-wide initialization based on css selectors
                // - highlight all pre + code tags (CSS3 selectors)
                // - use javascript as default language
                // - use theme "enlighter" as default theme
                // - replace tabs with 2 spaces
                EnlighterJS.init("pre", "code", {
                    language: "powershell",
                    theme: "enlighter",
                    indent: 2
                });
"@
        }
    }

}


$Document > ".\PSHTML\Examples\Example - Syntax Code\Example.html"