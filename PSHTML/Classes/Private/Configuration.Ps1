Class ConfigurationFile {

    [System.IO.FileInfo]$Path = "$PSScriptRoot\PSHTML.Configuration.Json"
    [PSHTMLConfiguration]$Data

    ConfigurationFile (){
        $this.LoadConfigurationData()
    }

    ConfigurationFile ([System.IO.FileInfo]$Path){
        $this.Path = $Path
        $this.LoadConfigurationData()
    }

    [void]LoadConfigurationData(){
        $This.Data = [PSHTMLConfiguration]::New($this.Path)
    }

    SetConfigurationFile([System.IO.FileInfo]$Path){
        $this.Path = $Path
        $this.LoadConfigurationData()
    }
}


Class ConfigurationLog {
    [System.IO.FileInfo]$Path
    [int]$MaxFiles
    $MaxTotalSize

    ConfigurationLog([System.IO.FileInfo]$Path,[int]$Maxfiles,$MaxTotalSize){
        $this.Path = $Path
        $this.MaxFiles = $Maxfiles
        $this.MaxTotalSize = $MaxTotalSize
    }
}

Class ConfigurationAssets{

    [System.IO.DirectoryInfo]$Path
    [hashtable[]]$Assets

    ConfigurationAssets([System.IO.DirectoryInfo]$Path){
        
        $this.Path = $Path

        $Folders = Get-ChildItem -Path $Path -Directory
        Foreach($f in $folders){
            $Hash = @{}
            $Hash.$($f.Name) = $F.FullName
            $This.Assets += $Hash
        }
    }
}

Class ConfigurationGeneral{

    [String]$Verbosity

    ConfigurationGeneral([String]$Verbosity){
        $this.Verbosity = $Verbosity
    }


}

Class PSHTMLConfiguration{

    [ConfigurationGeneral]$General
    [ConfigurationAssets]$Assets
    [ConfigurationLog]$Logging

    PSHTMLConfiguration([System.IO.FileInfo]$Path){
        $json = (gc -Path $Path | ConvertFrom-Json)
        $this.Logging = [ConfigurationLog]::New($json.Logging.Path,$json.Logging.MaxFiles,$json.Logging.MaxTotalSize)
        if($json.Assets.Path.Tolower() -eq 'default' -or $json.Assets.Path -eq '' ){
            $AssetsPath = "$PSScriptRoot/Assets"
        }Else{
            $AssetsPath = $json.Assets.Path
        }
        $this.Assets = [ConfigurationAssets]::New($AssetsPath)
        $this.General = [ConfigurationGeneral]::New($Json.Configuration.Verbosity)
    }


    [ConfigurationLog]GetLogConfig(){
        return $this.Logging
    }

    [ConfigurationAssets]GetAssetsConfig(){
        return $this.Assets
    }

    [ConfigurationGeneral]GetGeneralConfig(){
        return $this.General
    }

}
function Get-PSHTMLConfiguration {
    [CmdletBinding()]
    param (
        [System.IO.FileInfo]$Path,
        [Switch]$Force
    )
    
    begin {
    }
    
    process {
        if($PSBoundParameters['Path']){
            [ConfigurationFile]::New($Path)
        }Else{

            [ConfigurationFile]::New()
        }
    }
    
    end {
    }
}
