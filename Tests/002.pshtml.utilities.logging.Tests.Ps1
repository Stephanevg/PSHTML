$TestsPath = Split-Path $MyInvocation.MyCommand.Path

#$FunctionsPath = join-Path -Path (get-item $TestsPath).Parent -ChildPath "Functions"

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\PSHTML -Force

InModuleScope -ModuleName PSHTML {

    Describe '[MessageType]-[Constructors]' {
    
        It '[MessageType]-[Constructor] - Parameterless - should not Throw' {
    
            {[MessageType]::New()} | Should not throw 
    
        } #End of it block
    
    
    
    }# end of Describe block
    Describe '[LogDocument]-[Constructors]' {
    
        It '[LogDocument]-[Constructor] - Parameterless - should Throw' {
    
            {[LogDocument]::New()} | Should throw 
    
        } #End of it block

    }# end of Describe block

    <#
    Describe '[LogFile]-[Constructors]' {
    
        It '[LogFile]-[Constructor] - Parameterless - should Not Throw' {
    
            {[LogFile]::New()} | Should not throw
    
        } #End of it block
    
    
        It '[LogFile]-[Constructor]() should Not Throw' {
    
            #Instanciation:
            #Constructor Call:
    
            {[LogFile]::New()} | Should Not Throw 
        }# end of it block
    
        It '[LogFile]-[Constructor]([string]Path) should Not Throw' {
    
            #Instanciation:
    
            $Path = $TestDrive
    
            #Constructor Call:
    
            {[LogFile]::New($Path)} | Should Not Throw 
        }# end of it block
    
    
    }# end of Describe block

    #>
    Describe '[Logger]-[Constructors]' {
    
        It '[Logger]-[Constructor] - Parameterless - should Not Throw' {
    
            {[Logger]::New()} | Should not throw
    
        } #End of it block
    
    
        It '[Logger]-[Constructor]() should Not Throw' {
    
            #Instanciation:
            #Constructor Call:
    
            {[Logger]::New()} | Should Not Throw 
        }# end of it block
    
        It '[Logger]-[Constructor](Path) should Not Throw' {
    
            #Instanciation:
    
            $Path = "$TestDrive\MyLog.log"
    
            #Constructor Call:
    
            {[Logger]::New($Path)} | Should Not Throw 
        }# end of it block
    
    
    }# end of Describe block
    Describe '[LogMessage]-[Constructors]' {
    
        It '[LogMessage]-[Constructor] - Parameterless - should Not Throw' {
    
            {[LogMessage]::New()} | Should not throw
    
        } #End of it block
    
    
        It '[LogMessage]-[Constructor]() should Not Throw' {
    
            #Instanciation:
            #Constructor Call:
    
            {[LogMessage]::New()} | Should Not Throw 
        }# end of it block
    
        It '[LogMessage]-[Constructor](Message) should Not Throw' {
    
            #Instanciation:
    
            $Message = 'Plop woop'
    
            #Constructor Call:
    
            {[LogMessage]::New($Message)} | Should Not Throw 
        }# end of it block
    
        It '[LogMessage]-[Constructor]([String]Message,[MessageType]type) should Not Throw' {
    
            #Instanciation:
    
            $Message = 'Salutations'
    
    
            $type = 'WARN'
    
            #Constructor Call:
    
            {[LogMessage]::New($Message, $type)} | Should Not Throw 
        }# end of it block
    
    
    }# end of Describe block
    Describe '[LogMessage]-[Methods]' {
    
        #Public Method
        It '[LogMessage] --> ToString() : [String] - should Not Throw' {
    
            #Arrange
    
            $Message = 'Salutations'
    
    
            $type = 'WARN'
    
            #Constructor Call:
    
            $Instance = [LogMessage]::New($Message, $type)
    
            #Act
    
            #Assert
            {$Instance.ToString()} | Should Not Throw
    
        } #End It Block
    
        #Public Method
        It '[LogMessage] --> ToString () should return type [String]' {
    
            #Arrange
            # Add parameter values here
    
            $Message = 'Salutations'
    
    
            $type = 'WARN'
    
            #Constructor Call:
    
            $Instance = [LogMessage]::New($Message, $type)
    
            #Act
    
            #Assert
            ($Instance.ToString()).GetType().Name | should -Be "String"
    
        } #End It Block
    
        #Public Method
        It '[LogMessage] --> FormatMessage() : [String] - should Not Throw' {
    
            #Arrange
    
            $Message = 'Salutations'
    
    
            $type = 'WARN'
    
            #Constructor Call:
    
            $Instance = [LogMessage]::New($Message, $type)

    
            #Act
    
            #Assert
            {$Instance.FormatMessage()} | Should Not Throw
    
        } #End It Block
    
        #Public Method
        It '[LogMessage] --> FormatMessage () should return type [String]' {
    
            $Message = 'Salutations'
    
    
            $type = 'WARN'
    
            #Constructor Call:
    
            $Instance = [LogMessage]::New($Message, $type)

    
            #Act
    
            #Assert
            ($Instance.FormatMessage()).GetType().Name | Should Be String
    
    
        } #End It Block
    
        #Public Method
        It '[LogMessage] --> FormatMessage($MessageType,$msg) : [String] - should Not Throw' {
    
            #Arrange
    
            [String]$MessageType = 'ERROR'
    
            [String]$msg = 'Oh No!'
    
    
    
            #Act
    
            #Assert
            {[LogMessage]::FormatMessage($MessageType, $msg)} | Should Not Throw
    
        } #End It Block
    
        #Public Method
        It '[LogMessage] --> FormatMessage ($MessageType,$msg) should return type [String]' {
    
            #Arrange
            # Add parameter values here
    
            [String]$MessageType = 'ERROR'
    
            [String]$msg = 'Oh No!'
    
    
            #Act
            #Instantiate your class here
            #Test Values
            ([LogMessage]::FormatMessage($MessageType, $msg)).GetType().Name | should be String
    
        } #End It Block
    
    }#EndDescribeBlock
}

