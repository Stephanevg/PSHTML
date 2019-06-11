$TestsPath = Split-Path $MyInvocation.MyCommand.Path

#$FunctionsPath = join-Path -Path (get-item $TestsPath).Parent -ChildPath "Functions"

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\PSHTML -Force

InModuleScope -ModuleName PSHTML {

    $Configuration = @"
{
    "General": {
        "Verbosity": "Normal",
        "version":"1.0.0"
    },
    "Logging": {
        "Path": "Default",
        "MaxFiles": 200,
        "MaxTotalSize": "5MB"
    },
    "Assets": {
        "Path": "Default"
    }
}
"@

    Describe '[ConfigurationDocument]-[Constructors]' {
    
        It '[ConfigurationDocument]-[Constructor] - Parameterless should Not Throw' {
    
            # -- Arrange
    
            # -- Act
    
            # -- Assert
    
            {[ConfigurationDocument]::New()} | Should Not Throw 
    
        }# end of it block
    
    
        It '[ConfigurationDocument]-[Constructor]([System.IO.FileInfo]Path) should Not Throw' {
    
            # -- Arrange
    
            $FilePath = Join-Path -Path $TestDrive -ChildPath "plop.txt"
            $Null = New-Item -Path $FilePath -Force -Value $Configuration
            [System.IO.FileInfo]$Path = $FilePath
    
            # -- Act
    
            # -- Assert
    
            {[ConfigurationDocument]::New($Path)} | Should Not Throw 
    
        }# end of it block
    
    
    }# end of Describe block
    Describe '[Setting]-[Constructors]' {
    
    }# end of Describe block
    Describe '[LogSettings]-[Constructors]' {
    
        It '[LogSettings]-[Constructor] - Parameterless should Not Throw' {
    
            # -- Arrange
    
            # -- Act
    
            # -- Assert
    
            {[LogSettings]::New()} | Should Not Throw 
    
        }# end of it block
    
    
        It '[LogSettings]-[Constructor]([PsCustomObject]Object) should Not Throw' {
    
            # -- Arrange
    
            $FilePath = Join-Path -Path $TestDrive -ChildPath "plop.json"
            $Null = New-Item -Path $FilePath -Force -Value $Configuration
    
            [PsCustomObject]$Object = (gc $FilePath -Raw | ConvertFrom-Json).Logging
    
            # -- Act
    
            # -- Assert
    
            {[LogSettings]::New($Object)} | Should Not Throw 
    
        }# end of it block
    
    
        It '[LogSettings]-[Constructor]([System.IO.FileInfo]Path) should Not Throw' {
    
            # -- Arrange
    
            $FilePath = Join-Path -Path $TestDrive -ChildPath "plop.json"
            $Null = New-Item -Path $FilePath -Force -Value $Configuration

            [System.IO.FileInfo]$Path = $FilePath
    
            # -- Act
    
            # -- Assert
    
            {[LogSettings]::New($Path)} | Should Not Throw 
    
        }# end of it block
    
    
        It '[LogSettings]-[Constructor]([System.IO.DirectoryInfo]Path) should Not Throw' {
    
            # -- Arrange
    
            $FilePath = Join-Path -Path $TestDrive -ChildPath "plop.json"
            $Null = New-Item -Path $FilePath -Force -Value $Configuration

            [System.IO.DirectoryInfo]$Path = $TestDrive
    
            # -- Act
    
            # -- Assert
    
            {[LogSettings]::New($Path)} | Should Not Throw 
    
        }# end of it block
    
    
        It '[LogSettings]-[Constructor]([System.IO.FileInfo]Path,[int]Maxfiles,MaxTotalSize) should Not Throw' {
    
            # -- Arrange
    
            $FilePath = Join-Path -Path $TestDrive -ChildPath "plop.json"
            $Null = New-Item -Path $FilePath -Force -Value $Configuration
            [System.IO.FileInfo]$Path = $filePath
    
    
            [int]$Maxfiles = 5
    
    
            $MaxTotalSize = 30
    
            # -- Act
    
            # -- Assert
    
            {[LogSettings]::New($Path, $Maxfiles, $MaxTotalSize)} | Should Not Throw 
    
        }# end of it block
    
    
    }# end of Describe block
    Describe '[GeneralSettings]-[Constructors]' {
    
        It '[GeneralSettings]-[Constructor]([PsCustomObject]Object) should Not Throw' {
    
            # -- Arrange
    
            $FilePath = Join-Path -Path $TestDrive -ChildPath "plop.json"
            $Null = New-Item -Path $FilePath -Force -Value $Configuration
            [System.IO.FileInfo]$Path = $filePath
    
            [PsCustomObject]$Object = (gc $FilePath -Raw | ConvertFrom-Json).General
    
            # -- Act
    
            # -- Assert
    
            {[GeneralSettings]::New($Object)} | Should Not Throw 
    
        }# end of it block
    
    
        It '[GeneralSettings]-[Constructor]([String]Verbosity,[Version]Version) should Not Throw' {
    
            # -- Arrange
    
    
            [String]$Verbosity = 'Normal'
    
    
            [Version]$Version = 1.0.0
    
            # -- Act
    
            # -- Assert
    
            {[GeneralSettings]::New($Verbosity, $Version)} | Should Not Throw 
    
        }# end of it block
    
    
    }# end of Describe block
    Describe '[AssetSettings]-[Constructors]' {
    
        It '[AssetSettings]-[Constructor]([PsCustomObject]Object,[System.Io.DirectoryInfo]ModuleRootPath) should Not Throw' {
    
            # -- Arrange
    
            $FilePath = Join-Path -Path $TestDrive -ChildPath "plop.json"
            $Null = New-Item -Path $FilePath -Force -Value $Configuration
            [System.IO.FileInfo]$Path = $filePath
    
            [PsCustomObject]$Object = (gc $FilePath -Raw | ConvertFrom-Json).General


    
    
            [System.Io.DirectoryInfo]$ModuleRootPath = $TestDrive
    
            # -- Act
    
            # -- Assert
    
            {[AssetSettings]::New($Object, $ModuleRootPath)} | Should Not Throw 
    
        }# end of it block
    
    
    }# end of Describe block
    Describe '[SettingFactory]-[Constructors]' {
    
    }# end of Describe block
    Describe '[AssetsFactory]-[Constructors]' {
    
    }# end of Describe block
    Describe '[Asset]-[Constructors]' {
    
        It '[Asset]-[Constructor] - Parameterless should Not Throw' {
    
            # -- Arrange
    
            # -- Act
    
            # -- Assert
    
            {[Asset]::New()} | Should Not Throw 
    
        }# end of it block
    
    
        It '[Asset]-[Constructor]([System.IO.FileInfo]FilePath) should Not Throw' {
    
            # -- Arrange
    
    
            $FilePath = Join-Path -Path $TestDrive -ChildPath "plop.json"
            $F = New-Item -Path $FilePath -Force -Value $Configuration
            
            # -- Act
    
            # -- Assert
    
            {[Asset]::New($F)} | Should Not Throw 
    
        }# end of it block
    
    
        It '[Asset]-[Constructor]([System.IO.DirectoryInfo]Path) should Not Throw' {
    
            # -- Arrange
    
    
            [System.IO.DirectoryInfo]$Path = $TestDrive
    
            # -- Act
    
            # -- Assert
    
            {[Asset]::New($Path)} | Should Not Throw 
    
        }# end of it block
    
    
    }# end of Describe block
    Describe '[ScriptAsset]-[Constructors]' {
    
        It '[ScriptAsset]-[Constructor]([System.IO.FileInfo]FilePath) should Not Throw' {
    
            # -- Arrange
            
            $FilePath = Join-Path -Path $TestDrive -ChildPath "plop.json"
            $Null = New-Item -Path $FilePath -Force -Value $Configuration
            
            [System.IO.FileInfo]$FilePath = $FilePath
    
            # -- Act
    
            # -- Assert
    
            {[ScriptAsset]::New($FilePath)} | Should Not Throw 
    
        }# end of it block
    
    
        It '[ScriptAsset]-[Constructor]([System.IO.DirectoryInfo]Path) should Not Throw' {
    
            # -- Arrange
    
    
            [System.IO.DirectoryInfo]$Path = $TestDrive
    
            # -- Act
    
            # -- Assert
    
            {[ScriptAsset]::New($Path)} | Should Not Throw 
    
        }# end of it block
    
    
    }# end of Describe block
    Describe '[StyleAsset]-[Constructors]' {
    
        It '[StyleAsset]-[Constructor]([System.IO.FileInfo]FilePath) should Not Throw' {
    
            # -- Arrange
    
            $FilePath = Join-Path -Path $TestDrive -ChildPath "plop.json"
            $Null = New-Item -Path $FilePath -Force -Value $Configuration
           
    
            [System.IO.FileInfo]$FilePath = $FilePath
    
            # -- Act
    
            # -- Assert
    
            {[StyleAsset]::New($FilePath)} | Should Not Throw 
    
        }# end of it block
    
    
        It '[StyleAsset]-[Constructor]([System.IO.DirectoryInfo]Path) should Not Throw' {
    
            # -- Arrange
    
    
            [System.IO.DirectoryInfo]$Path = $TestDrive
    
            # -- Act
    
            # -- Assert
    
            {[StyleAsset]::New($Path)} | Should Not Throw 
    
        }# end of it block
    
    
    }# end of Describe block
    Describe '[StyleAsset]-[Methods]' {
    
        #Public Method
        It '[StyleAsset] --> ToString() : [String] - should Not Throw' {
    
            # -- Arrange
            $FilePath = Join-Path -Path $TestDrive -ChildPath "plop.json"
            $Null = New-Item -Path $FilePath -Force -Value $Configuration
           
    
            [System.IO.FileInfo]$Path = $FilePath



            # -- Act
    
            $Instance = [StyleAsset]::New($Path)
    
            # -- Assert
    
            {$Instance.ToString()} | Should Not Throw
    
        } #End It Block
    
        #Public Method
        It '[StyleAsset] --> ToString() : [String] - should return type [String]' {
    
            # -- Arrange
            $FilePath = Join-Path -Path $TestDrive -ChildPath "plop.json"
            $Null = New-Item -Path $FilePath -Force -Value $Configuration
           
    
            [System.IO.FileInfo]$Path = $FilePath
            
            # -- Act
            
    
            $Instance = [StyleAsset]::New($Path)
            # -- Assert
    
            ($Instance.ToString()).GetType().Name | should be String
    
        } #End It Block
    
    }#EndDescribeBlock

}    
