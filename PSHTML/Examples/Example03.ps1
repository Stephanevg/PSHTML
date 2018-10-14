

html{
    Body{

        h2 "This is a form example with a Password"

        p{

            Form -action "CallThisPage.Html" -method get -target _self -Content{
                "Please input your password"
                input -type password "woop"
                "Please Confirm your passwor"
                input -type password -name "woop2"
            }
        }

        div {
           p -Class "MyClass" {
                "This is an alter"
           }
        }
    }
}