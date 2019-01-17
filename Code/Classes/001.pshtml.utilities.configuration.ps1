
Class ConfigurationFile {

    [System.IO.FileInfo]$Path = "$PSScriptRoot/pshtml.configuration.json"
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

    [ConfigurationLog]GetConfigurationLog(){
        return $this.Data.GetConfigurationLog()
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

    [Void]SetLogConfig([ConfigurationLog]$LogDocument){
        $this.Data.SetConfigurationLog($LogDocument)
    }

    [String]GetLogfilePath(){
        Return $this.Data.GetLogFilePath()
    }
    

    
}


Class ConfigurationLog {
    [System.IO.FileInfo]$Path
    [int]$MaxFiles = 200
    $MaxTotalSize = 5
    hidden $Logfilename = "PSHTML.Log"

    ConfigurationLog(){
        $DefPath = $this.GetDefaultLogFolderPath()
        $This.Path = $this.NewLogFile($DefPath)

    }

    ConfigurationLog ([System.IO.FileInfo]$Path){
        $this.Path = $Path
    }

    ConfigurationLog ([System.IO.DirectoryInfo]$Path){
        $this.Path = $this.NewLogFile($Path)
    }

    ConfigurationLog([System.IO.FileInfo]$Path,[int]$Maxfiles,$MaxTotalSize){
        $this.Path = $Path
        $this.MaxFiles = $Maxfiles
        $this.MaxTotalSize = $MaxTotalSize
    }

    [System.IO.FileInfo] Hidden NewLogFile([System.IO.DirectoryInfo]$Directory){

        Return [System.IO.FileInfo]([System.io.Path]::Combine($Directory.FullName,$this.Logfilename))
    }

    [String]GetLogfilePath(){
        Return $This.Path.FullName
    }

    [String]GetDefaultLogFolderPath(){
        if($global:IsLinux){
            $p = "/tmp/pshtml/"
        }Else{
            $p = Join-Path $Env:Temp -ChildPath "pshtml"
        }
        return $p
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
        if($json.Logging.Path -Eq 'default' -or $json.logging.Path -eq ""){
            
                if($global:IsLinux){
                    
                    $LogPath = "/tmp/pshtml/pshtml.log"
                }Else{
                    $LogPath = Join-Path $Env:ProgramData -ChildPath "pshtml/pshtml.log"
                }



        }else{
            $P = Join-Path $json.logging.Path -ChildPath 'pshtml.log'
            #$pa = [System.IO.Path]::Combine($P.FullName,'pshtml.log')
            $LogPath = $P
        }



        $this.Logging = [ConfigurationLog]::New($LogPath,$json.Logging.MaxFiles,$json.Logging.MaxTotalSize)
        if($json.Assets.Path.Tolower() -eq 'default' -or $json.Assets.Path -eq '' ){
            $root = $Path.Directory.FullName
            $AssetsPath = "$Root/Assets"
        }Else{
            $AssetsPath = $json.Assets.Path
        }
        $this.Assets = [ConfigurationAssets]::New($AssetsPath)
        $this.General = [ConfigurationGeneral]::New($Json.Configuration.Verbosity)
    }

    [ConfigurationLog] GetConfigurationLog(){
        return $this.Logging
    }

    [ConfigurationGeneral] GetConfigurationGeneral(){
        return $this.General
    }

    [ConfigurationAssets] GetConfigurationAssets(){
        return $this.Assets
    }

    SetConfigurationLog([ConfigurationLog]$LogDocument){
        $this.Logging = $LogDocument
    }
   
    [String]GetLogfilePath(){
        return $this.Logging.GetLogfilePath()
    }

    [String]GetDefaultLogFolderPath(){
        return $this.Logging.GetDefaultLogFolderPath()
    }
}

function New-Logfile {
    [CmdletBinding()]
    param (
        
        $Path = {Throw "Path parameter is mandatory."}
    )
    
    begin {
    }
    
    process {
        if($Path -is [System.IO.DirectoryInfo] -or $Path -is [System.IO.fileInfo]){

            Return [ConfigurationLog]::New($Path)
        }Else{
            Throw "Log file is of wrong type. Please specify a System.IO.DirectoryInfo or System.IO.fileIno type."
        }
    }
    
    end {
    }
}
function New-ConfigurationDocument {
    [CmdletBinding()]
    param (
        [System.IO.FileInfo]$Path,
        [Switch]$Force
    )
    
    begin {
    }
    
    process {
        if($Path){
            [ConfigurationFile]::New($Path)
        }Else{

            [ConfigurationFile]::New()
        }
    }
    
    end {
    }
}
