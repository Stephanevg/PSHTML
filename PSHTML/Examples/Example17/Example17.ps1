
Import-Module PSHTML

html {

    head{

        title "woop title"
        link "css/normalize.css" "stylesheet"
    }

    body{

        
            h1 "This is h1 Title in header"
            div {
                p {
                    "This is simply a paragraph in a div."
                }
            }

            h2 "This is h2 Title in header"
            p {
                "Another paragraph"
            }


            div {
                $FavoriteNumbers = 1..10
                ul {

                    Foreach($num in $FavoriteNumbers){

                        li {
                            "Item Number: $($num)"
                        }
                    }

                }

                p{
                    "End of Example."
                }
            }
    }

}
