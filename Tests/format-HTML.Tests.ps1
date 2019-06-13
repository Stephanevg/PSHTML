$TestsPath = Split-Path $MyInvocation.MyCommand.Path

#$FunctionsPath = join-Path -Path (get-item $TestsPath).Parent -ChildPath "Functions"

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\PSHTML -Force

InModuleScope PSHTML {

    Describe "Testing format-HTML | General options" {
        $HTMLString = '<html><head><script>alert(''test'');</script></head><body><p>this is a test</p></body></html>'

        it '[format-HTML] param HTMLstring is mandatory' {
            ( (Get-Command format-HTML).Parameters['HTMLstring'].Attributes | Where-Object { $_ -is [parameter] } ).Mandatory | Should Be $true
        }
        it '[format-HTML] param Indent is mandatory' {
            ( (Get-Command format-HTML).Parameters['Indent'].Attributes | Where-Object { $_ -is [parameter] } ).Mandatory | Should Be $false
        }
    }

    Describe 'Testing format-HTML -HTMLString $HTMLString' {
        $HTMLString = '<html><head><script>alert(''test'');</script></head><body><p>this is a test</p></body></html>'
        $ExpectedResult = @"
<html>
    <head>
        <script>
            alert('test');
        </script>
    </head>
    <body>
        <p>this is a test</p>
    </body>
</html>
"@

        it '[format-HTML][-HTMLstring] Should not throw' {
            { format-HTML -HTMLString $HTMLString } | should not throw
        }

        it '[format-HTML][-HTMLstring] Should create correct code' {
            $Is = format-HTML -HTMLString $HTMLString
            $Is | should be $ExpectedResult
        }
    }

    Describe 'Testing format-HTML -HTMLString $HTMLString' {
        $HTMLString = '<html><head><script>alert(''test'');</script></head><body><p>this is a test</p></body></html>'
        $ExpectedResult = @"
<html>
  <head>
    <script>
      alert('test');
    </script>
  </head>
  <body>
    <p>this is a test</p>
  </body>
</html>
"@

        it '[format-HTML][-HTMLstring $HTMLstring][-Indent 2] Should not throw' {
            { format-HTML -HTMLString $HTMLString -Indent 2 } | should not throw
        }

        it '[format-HTML][-HTMLstring $HTMLstring][-Indent 2] Should create correct code' {
            $Is = format-HTML -HTMLString $HTMLString -Indent 2
            $Is | should be $ExpectedResult
        }
    }
}