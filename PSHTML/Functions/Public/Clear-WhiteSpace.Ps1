
#From Jakub Jares (Thanks!)
function Clear-WhiteSpace ($Text) {
    "$($Text -replace "(`t|`n|`r)"," " -replace "\s+"," ")".Trim()
}