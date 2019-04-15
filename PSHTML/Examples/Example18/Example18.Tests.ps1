Describe "My DEscribe block" {


    It "My It block 1" {
        $false | Should be $false
    }
    It "My It block 2" {
        $false | Should be $false
    }
}

Describe "My DEscribe block 2" {


    It "My It block 3" {
        $false | Should be $false
    }
    It "My It block 4" {
        $false | Should be $false
    }
}
Describe "Describe block 3" {
    It "My It block 5" {
        $false | Should be $false
    }
    It "My It block 6" {
        $true | Should be $false
    }
    It "My It block 7" {
        $true | Should be $false
    }
    It "My It block 8" {
        $true | Should be $false
    }
}

Describe "My DEscribe block 4" {


    It "My It block 9" {
        $false | Should be $false
    }
    It "My It block 10" {
        $false | Should be $true
    }
}

Describe "My DEscribe block 5" {


    It "My It block 11" {
        $false | Should be $false
    }
    It "My It block 12" {
        $false | Should be $false
    }
}

#$results = invoke-pester C:\Users\taavast3\OneDrive\Repo\Projects\OpenSource\PSHTML\PSHTML\Examples\Example18\Example18.Tests.ps1 -PassThru
#$results | ConvertTo-Json -Depth 5 | out-File .\TestREsults.Json