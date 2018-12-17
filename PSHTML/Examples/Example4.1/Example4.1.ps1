
html{
    include -Name head

    Body{

        include -name Body
        
        $PrimaryColors = @("Red","green","blue")

        H3 "Primary color are:"
        ul {
     
            Foreach($PColor in $PrimaryColors){
                
                li $PColor
            }
        }
        p {
            "This is just content after the unorded list but before the footer."
        }
    }
    
    Include -Name Footer
}