function Get-PSHTMLAsset {
    <#
    .SYNOPSIS
        Returns existing PSHTML assets
    .DESCRIPTION
        Get-PSHTMLAsset allows to retriev one or more of the available assets in PSHTML. It is possible to sort by type, and Name.
        It is also possible to add custom assets.
        1) Add a folder in the Assets folder
        2) place .js or .css files in that folder.
        3) Voila! Your assets are now available via Get-PSHTMLAsset

    .EXAMPLE
        Get-PSHTMLAsset (Version numbers could potentially be different)

        Name         : BootStrap
        FolderPath   : C:\ModuleLocation\PSHTML\PSHTML\Assets\BootStrap
        FilePath     : bootstrap.bundle.js
        RelativePath : Assets/BootStrap/bootstrap.bundle.js
        Type         : Script

        Name         : BootStrap
        FolderPath   : C:\ModuleLocation\PSHTML\PSHTML\Assets\BootStrap
        FilePath     : bootstrap.css
        RelativePath : Assets/BootStrap/bootstrap.css
        Type         : Style

        Name         : Chartjs
        FolderPath   : C:\ModuleLocation\PSHTML\PSHTML\Assets\Chartjs
        FilePath     : Chart.bundle.min.js
        RelativePath : Assets/Chartjs/Chart.bundle.min.js
        Type         : Script

        Name         : Jquery
        FolderPath   : C:\ModuleLocation\PSHTML\PSHTML\Assets\Jquery
        FilePath     : jquery-3.3.1.slim.min.js
        RelativePath : Assets/Jquery/jquery-3.3.1.slim.min.js
        Type         : Script

    .Parameter Name

        Get-PSHTMLAsset -Name Jquery

        Name         : Jquery
        FolderPath   : C:\ModuleLocation\PSHTML\PSHTML\Assets\Jquery
        FilePath     : jquery-3.3.1.slim.min.js
        RelativePath : Assets/Jquery/jquery-3.3.1.slim.min.js
        Type         : Script

    .Parameter Type

    Allows to filter on one specific type to return.

        Get-PSHTMLAsset -Type Script

        Name         : BootStrap
        FolderPath   : C:\ModuleLocation\PSHTML\PSHTML\Assets\BootStrap
        FilePath     : bootstrap.bundle.js
        RelativePath : Assets/BootStrap/bootstrap.bundle.js
        Type         : Script

        Name         : Chartjs
        FolderPath   : C:\ModuleLocation\PSHTML\PSHTML\Assets\Chartjs
        FilePath     : Chart.bundle.min.js
        RelativePath : Assets/Chartjs/Chart.bundle.min.js
        Type         : Script

        Name         : Jquery
        FolderPath   : C:\ModuleLocation\PSHTML\PSHTML\Assets\Jquery
        FilePath     : jquery-3.3.1.slim.min.js
        RelativePath : Assets/Jquery/jquery-3.3.1.slim.min.js
        Type         : Script

    .EXAMPLE 

    In the following example, Bootstrap is retrieved. Bootstrap needs one Script file (.js) and one Style (.css) file (at a minimum) to work.
    Using 'only' the -Name parameter will return all of the found values for that specific name, regardles of the type. To have a type filtering, use the -Type parameter.

    Get-PSHTMLAsset -Name Bootstrap

        Name         : BootStrap
        FolderPath   : C:\ModuleLocation\PSHTML\PSHTML\Assets\BootStrap
        FilePath     : bootstrap.bundle.js
        RelativePath : Assets/BootStrap/bootstrap.bundle.js
        Type         : Script

        Name         : BootStrap
        FolderPath   : C:\ModuleLocation\PSHTML\PSHTML\Assets\BootStrap
        FilePath     : bootstrap.css
        RelativePath : Assets/BootStrap/bootstrap.css
        Type         : Style

    .EXAMPLE

    The Asset object it self, comes with a method called ToString() which allows one to write the the html information for that specific asset.

    Place the following code the head{} of your HTML Document.

    $J = Get-PSHTMLAsset -Name Jquery
    $J.ToString()

    #This will dynamically generate a script tag to that specific asset. 
    <Script src='C:/ModuleLocation/PSHTML/PSHTML/Assets/Jquery/jquery-3.3.1.slim.min.js'></Script>

    Note: The above code would return the exact same result as Write-PSHTMLAsset:

    Write-PSHTMLAsset -Name Jquery

    #As a best practise, we recommend to use Write-PSHTMLAsset

    .INPUTS
        None
    .OUTPUTS
        Asset[]
    .Notes
        Author: Stéphane van Gulick
    .Link
      https://github.com/Stephanevg/PSHTML
    #>
    [CmdletBinding()]
    param (
        [String]$Name,
        [ValidateSet("Script","Style")]$Type
    )
    
    begin {
    }
    
    process {
        $Config = (Get-PSHTMLConfiguration)
        If($Name){

            $Config.GetAsset($Name)
        }Elseif($Type -and $Name){
            $Config.GetAsset($Name,$Type)
        }elseif($Type){
            $Config.GetAsset($Type)
        }Else{
            $Config.GetAsset()
        }
    }
    
    end {
    }
}