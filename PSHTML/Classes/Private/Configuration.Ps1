Class ConfigurationFile {

    [System.IO.FileInfo]$Path = "$PSScriptRoot\PSHTML.Configuration.Json"
    [PSHTMLConfiguration]$Data

    ConfigurationFile (){
        $this.LoadConfigurationData()
    }

    ConfigurationFile ([System.IO.FileInfo]$Path){
        $this.SetConfigurationFile($Path)
    }

    [void]LoadConfigurationData(){
        $This.Data = [PSHTMLConfiguration]::New($this.Path)
    }

    SetConfigurationFile([System.IO.FileInfo]$Path){
        $this.Path = $Path
        $this.LoadConfigurationData()
    }

    [ConfigurationLog]GetLogConfig(){
        return $this.Data.Logging
    }

    [ConfigurationAssets]GetAssetsConfig(){
        return $this.Data.Assets
    }

    [ConfigurationGeneral]GetGeneralConfig(){
        return $this.Data.General
    }
    [HashTable[]]GetAsset(){
        return $this.Data.Assets.Assets
    }
    [String]GetAsset($Name){
        return $this.Data.Assets.Assets.$($Name)
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
            $root = $Path.Directory.FullName
            $AssetsPath = "$Root/Assets"
        }Else{
            $AssetsPath = $json.Assets.Path
        }
        $this.Assets = [ConfigurationAssets]::New($AssetsPath)
        $this.General = [ConfigurationGeneral]::New($Json.Configuration.Verbosity)
    }


   

}
