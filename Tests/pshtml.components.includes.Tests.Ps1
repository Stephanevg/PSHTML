$TestsPath = Split-Path $MyInvocation.MyCommand.Path

#$FunctionsPath = join-Path -Path (get-item $TestsPath).Parent -ChildPath "Functions"

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\PSHTML -Force

InModuleScope -ModuleName 'PSHTML'{

    Describe '[IncludeFile]-[Constructors]'{
    
    }# end of Describe block
    Describe '[Include]-[Constructors]'{
    
    It '[Include]-[Constructor]([System.IO.FileInfo]FilePath) should Not Throw' {
    
    # -- Arrange
    
    $FilePath = Join-Path -Path $TestDrive -ChildPath "plop.txt"
    $Null = New-Item -Path $FilePath -Force -Value "eee"
    [System.IO.FileInfo]$FilePath=$FilePath
    
    # -- Act
    
    # -- Assert
    
    {[Include]::New($FilePath)} | Should Not Throw 
    
    }# end of it block
    
    
    }# end of Describe block
    Describe '[IncludeFactory]-[Constructors]'{
    
    }# end of Describe block
    Describe '[IncludeFactory]-[Methods]'{
    
    #Public Method
    It '[IncludeFactory] --> Create($Path) : [Include[]] - should Not Throw' {
    
    # -- Arrange
    
    [System.IO.DirectoryInfo]$Path = $TestDrive
    
    # -- Act
    
    # -- Assert
    
    {[IncludeFactory]::Create($Path)} | Should Not Throw
    
    } #End It Block
    
    #Public Method
    It '[IncludeFactory] --> Create($Path) : [Include[]] - should return type [Include[]]' {
    
    # -- Arrange
    [System.IO.DirectoryInfo]$Path = $TestDrive
    
    # -- Act
    
    # -- Assert
    
    ([IncludeFactory]::Create($Path)).GetType().Name | should be Include[]
    
    } #End It Block
    
    }#EndDescribeBlock

}    
