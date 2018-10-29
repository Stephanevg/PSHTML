
import-module C:\Users\taavast3\OneDrive\Scripting\Repository\Projects\OpenSource\PSHTML\pshtml.psd1 -force
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


$Document > .\PSHTML\Examples\wop.Example11.html