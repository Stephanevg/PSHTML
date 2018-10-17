Describe "VSCode Snippets store with PSHTML Snippets" {
    Context "Testing PSHTML Snippets exist" {
        It "has the Small snippet" {
            Test-Path "$($env:APPDATA)\Code\User\snippets\PsHtml_BoilerPlate_small.Snippet.code-snippets" | Should Be $true
        }
        It "has the Medium snippet" {
            Test-Path "$($env:APPDATA)\Code\User\snippets\PsHtml_BoilerPlate_small.Snippet.code-snippets" | Should Be $true
        }
        It "has the Full snippet" {
            Test-Path "$($env:APPDATA)\Code\User\snippets\PsHtml_BoilerPlate_small.Snippet.code-snippets" | Should Be $true
        } 
    }
}
