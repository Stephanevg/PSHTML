function Write-PSHTMLSymbol {

    param (
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [ValidateSet('COPYRIGHT SIGN', 
            'REGISTERED SIGN', 
            'EURO SIGN', 
            'TRADEMARK',
            'LEFTWARDS ARROW',
            'UPWARDS ARROW',
            'RIGHTWARDS ARROW',
            'DOWNWARDS ARROW',
            'BLACK SPADE SUIT',
            'BLACK CLUB SUIT',
            'BLACK HEART SUIT',
            'BLACK DIAMOND SUIT',
            'FOR ALL',
            'PARTIAL DIFFERENTIAL',
            'THERE EXISTS',
            'EMPTY SETS',
            'NABLA',
            'ELEMENT OF',
            'NOT AN ELEMENT OF',
            'CONTAINS AS MEMBER',
            'N-ARY PRODUCT',
            'N-ARY SUMMATION',
            'GREEK CAPITAL LETTER ALPHA',
            'GREEK CAPITAL LETTER BETA',
            'GREEK CAPITAL LETTER GAMMA',
            'GREEK CAPITAL LETTER DELTA',
            'GREEK CAPITAL LETTER EPSILON',
            'GREEK CAPITAL LETTER ZETA'
        )]
        [string[]]
        $Name
    )

    process {
        switch ($Name) {
            "COPYRIGHT SIGN" {
                "&copy;"
            }
            "REGISTERED SIGN" {
                "&reg;"
            }
            "EURO SIGN" {
                "&euro;"
            }
            "TRADEMARK" {
                "&trade;"
            }
            "LEFTWARDS ARROW" {
                "&larr;"
            }
            "UPWARDS ARROW" {
                "&uarr;"
            }
            "RIGHTWARDS ARROW" {
                "&rarr;"
            }
            "DOWNWARDS ARROW" {
                "&darr;"
            }
            "BLACK SPADE SUIT" {
                "&spades;"
            }
            "BLACK CLUB SUIT" {
                "&clubs;"
            }
            "BLACK HEART SUIT" {
                "&hearts;"
            }
            "BLACK DIAMOND SUIT" {
                "&diams;"
            }
            "FOR ALL" {
                "&forall;"
            }
            "PARTIAL DIFFERENTIAL" {
                "&part;"
            }
            "THERE EXISTS" {
                "&exist;"
            }
            "EMPTY SETS" {
                "&empty;"
            }
            "NABLA" {
                "&nabla;"
            }
            "ELEMENT OF" {
                "&isin;"
            }
            "NOT AN ELEMENT OF" {
                "&notin;"
            }
            "CONTAINS AS MEMBER" {
                "&ni;"
            }
            "N-ARY PRODUCT" {
                "&prod;"
            }
            "N-ARY SUMMATION" {
                "&sum;"
            }
            "GREEK CAPITAL LETTER ALPHA" {
                "&Alpha;"
            }
            "GREEK CAPITAL LETTER BETA" {
                "&Beta;"
            }
            "GREEK CAPITAL LETTER GAMMA" {
                "&Gamma;"
            }
            "GREEK CAPITAL LETTER DELTA" {
                "&Delta;"
            }
            "GREEK CAPITAL LETTER EPSILON" {
                "&Epsilon;"
            }
            "GREEK CAPITAL LETTER ZETA" {
                "&Zeta;"
            }
        }
    }
}