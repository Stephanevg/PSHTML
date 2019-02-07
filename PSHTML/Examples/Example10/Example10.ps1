
import-module 'pshtml' -force
html {

    head {

        title "Example 2"
    }

    body {
        h1 {"Example adding loops an other operators"}

        $Languages = @("PowerShell","Python","CSharp","Bash")

        Foreach()

    }
    Footer {
        h6 "This is h1 Title in Footer"
    }

}


$Document | out-file -FilePath '.\PSHTML_Basic_Example.html' -Encoding utf8