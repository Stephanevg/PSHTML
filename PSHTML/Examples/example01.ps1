
import-module pshtml
$Document = html {

    head{

        title "woop title"
        link "css/normalize.css" "stylesheet"
    }

    body{

        Header {
            img "https://i0.wp.com/powershelldistrict.com/wp-content/uploads/2016/01/logo_pd_quadri.png" "logo powershell" -height 100 -width 400
            h1 "This is h1 Title in header"
            div {
                p {
                    "This is simply a paragraph in a div."
                }
            }
        }


            p {
                h1 "This is h1"
                h2 "This is h2"
                h3 "This is h3"
                h4 "This is h4"
                h5 "This is h5"
                h6 "This is h6"
                strong "plop";"Woop"
            }
            p{

                table{
                    caption "This is a table generated with PSHTML"
                    thead {
                        tr{
                            th "number1"
                            th "number2"
                            th "number3"
                        }
                    }
                    tbody{
                        tr{
                            td "Child 1.1"
                            td "Child 1.2"
                            td "Child 1.3"
                        }
                        tr{
                            td "Child 2.1"
                            td "Child 2.2"
                            td "Child 2.3"
                        }
                    }
                    tfoot{
                        tr{
                            td "Table footer"
                        }
                    }
                }
            }
        p{

            a {
                "This links point to PowershellDistrict"
            } -href "http://powershellDistrict.com"

        }

    }
    Footer {
        h6 "This is h1 Title in Footer"
}

}


$Document | Out-File -FilePath '.\PSHTML_Example.html' -Encoding utf8