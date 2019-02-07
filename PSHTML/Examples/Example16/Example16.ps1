
$h = html -Attributes @{lang = "en"} {
    head {
        meta -charset 'UTF-8'
        meta -name 'author' -content "Stéphane van Gulick"
        Title -Content "District"
        #Write-PSHTMLAsset 
    }
    body {
        div -Class 'container' {

            H1 -Class "title" {
                "My Example"
            }

            $arr = 1..10
            Foreach($a in $arr){
                
                p {
                    "Hello Mambo Number: $($a)"
                }
            }
        }
        footer {

        }
    }
} 

$h | Out-File -FilePath '.\Example16.html' -Encoding utf8
start .\Example16.html
