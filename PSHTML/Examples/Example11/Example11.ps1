
import-module pshtml -force
$Document = html {

    head {

        title "Example 2"
    }

    body {
        h1 {"Example adding loops an other operators"}

        $Languages = @("PowerShell","Python","CSharp","Bash")

        "My Favorite language are:"
        ul{

            
            Foreach($language in $Languages){
                li {
                    $Language
                }
            }
        }
    }
    Footer {
        h6 "This is h1 Title in Footer"
    }

}


$Document | out-file -FilePath '.\Example11.html' -Encoding utf8