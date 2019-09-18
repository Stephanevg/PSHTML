$TestsPath = Split-Path $MyInvocation.MyCommand.Path

#$FunctionsPath = join-Path -Path (get-item $TestsPath).Parent -ChildPath "Functions"

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\PSHTML -Force

Describe 'Write-PSHTMLSymbol' {
    $Hash = @{
        "COPYRIGHT SIGN"="&copy;"
        "REGISTERED SIGN" ="&reg;"
        "EURO SIGN" ="&euro;"
        "TRADEMARK" ="&trade;"
        "LEFTWARDS ARROW" ="&larr;"
        "UPWARDS ARROW" ="&uarr;"
        "RIGHTWARDS ARROW" ="&rarr;"
        "DOWNWARDS ARROW" ="&darr;"
        "BLACK SPADE SUIT" ="&spades;"
        "BLACK CLUB SUIT" ="&clubs;"
        "BLACK HEART SUIT" ="&hearts;"
        "BLACK DIAMOND SUIT" ="&diams;"
        "FOR ALL" ="&forall;" 
        "PARTIAL DIFFERENTIAL" ="&part;"
        "THERE EXISTS" ="&exist;"
        "EMPTY SETS" ="&empty;"
        "NABLA" ="&nabla;"
        "ELEMENT OF" ="&isin;"
        "NOT AN ELEMENT OF" ="&notin;"
        "CONTAINS AS MEMBER" ="&ni;"
        "N-ARY PRODUCT" ="&prod;"
        "N-ARY SUMMATION" ="&sum;"
        "GREEK CAPITAL LETTER ALPHA" ="&Alpha;"
        "GREEK CAPITAL LETTER BETA" ="&Beta;"
        "GREEK CAPITAL LETTER GAMMA" ="&Gamma;"
        "GREEK CAPITAL LETTER DELTA" ="&Delta;"
        "GREEK CAPITAL LETTER EPSILON" ="&Epsilon;"
        "GREEK CAPITAL LETTER ZETA" ="&Zeta;"
    }
    
    $hash.GetEnumerator() | %{
        it "Write-PSHTSymbol '$($_.Name)' should return '$($_.Value)'" {
            $Result = Write-PSHTMLSymbol -Name $($_.Name)
            $Result | should be $($_.Value)
        }
    }
}
