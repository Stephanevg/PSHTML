
import-module pshtml

$Languages = @("PowerShell","Ruby","CSharp","Python")

$HtmlDocument = html {

    head{

        title "woop title"
        link -rel "stylesheet" "css/normalize.css"
    }

    body{

        Header {
            h1 "My select page"
            div {
                p {
                    "Hello from D.P"
                }
            }
        }


        p {
            "My favorite language is:"
        }
        SelectTag {

            foreach($language in $Languages){
                option -value $language -Content $language
            }

        }

        p {
            "My favorite car is:"
        }
        SelectTag {
            option -value "Citroen" -Content "Citroen"
            option -value "Renault" -Content "Renault"
            option -value "Peugeot" -Content "Peugeot"
            option -value "DS" -Content "DS"
        }

        p {
            "My favorite language color:"
        }
        SelectTag {
            option -value "Gree" -Content "Green"
            option -value "Yellow" -Content "Yellow"
            option -value "White" -Content "White"
            option -value "Red" -Content "Red"
        }

        "<br>"
        "<br>"

        button -Content "To Next Page" -Id "btn_Next"
    }

}

$HtmlDocument | out-file -FilePath $home\Documents\MyPage.Html -Encoding utf8
start $home\Documents\MyPage.Html