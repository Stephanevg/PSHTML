
Enum SettingType {
    General
    Asset
    Log
}

Enum AssetType {
    Script
    Style
}

Class ConfigurationDocument {

    [System.IO.FileInfo]$Path = "$PSScriptRoot/pshtml.configuration.json"
    [Setting[]]$Settings
    [Asset[]]$Assets
    [Include[]]$Includes

    #Constructors
    ConfigurationDocument (){
        $this.Load()
    }

    ConfigurationDocument ([System.IO.FileInfo]$Path){
        $this.Path = $Path
        $this.Load()
    }

    #Methods
    [void]Load(){
        #Read data from json
        $this.Settings = [SettingFactory]::Parse($This.Path)
        $AssetsFolder = Join-Path $This.Path.Directory -ChildPath "Assets"
        $this.Assets = [AssetsFactory]::CreateAssets($AssetsFolder)
        $IncludesFolder = Join-Path $this.Path.Directory -ChildPath 'Includes'
        $this.Includes = [IncludeFactory]::Create($IncludesFolder)
    }

    [void]Load([System.IO.FileInfo]$Path){
        $this.Path = $Path
        $this.Load()
    }

    [Setting[]]GetSetting(){
        return $this.Settings
    }

    [Setting[]]GetSetting([SettingType]$Type){
        return $this.Settings | ? {$_.Type -eq $type}
    }

    [Asset[]]GetAsset(){
        return $this.Assets
    }

    [Asset[]]GetAsset([String]$Name){
        return $this.Assets | ? {$_.Name -eq $NAme}
    }

    [Asset[]]GetAsset([AssetType]$Type){
        return $this.Assets | ? {$_.Type -eq $type}
    }

    [Asset[]]GetAsset([String]$Name,[AssetType]$Type){
        return $this.Assets | ? {$_.Type -eq $type -and $_.Name -eq $Name}
    }

    [Void]AddAsset([Asset]$Asset){
        $this.Assets += $Asset
    }

    [Void]hidden LoadDataFromFile(){
        if(!(test-Path $this.Path.FullName)){
            throw "No configuration file found at $($this.Path.FullName)"
        }
        $this.Load()

    }

    [void]hidden LoadLogSettings(){

    }

    [String]GetDefaultLogFilePath(){
        return $this.GetSetting("Log").GetLogfilePath()
    }

    [Include[]]GetInclude(){
        Return $this.Includes
    }

    [Include[]]GetInclude([String]$Name){
        Return $this.Includes | ? {$_.Name -eq $Name}
    }

}

Class Setting{
    [SettingType]$Type

    [SettingType] GetSettingType(){
        Return $This.Type
    }

    SetSettingType([SettingType]$SettingType){
        $This.Type = $SettingType
    }

}

Class LogSettings : Setting {
    
    [System.IO.FileInfo]$Path
    [int]$MaxFiles = 200
    $MaxTotalSize = 5
    hidden $Logfilename = "PSHTML.Log"
    [SettingType]$Type = "Log"

    LogSettings(){
        $DefPath = $this.GetDefaultLogFolderPath()
        $This.Path = $this.NewLogFile($DefPath)
    }

    LogSettings([PsCustomObject]$Object){
        $this.MaxFiles = $Object.MaxFiles
        $this.MaxTotalSize = $Object.MaxTotalSIze

        if($Object.Path.ToLower() -eq "default" -or $Object.Path -eq ""){
            $DefPath = $this.GetDefaultLogFolderPath()
            $This.Path = $this.NewLogFile($DefPath)
        }else{
            $this.Path = $Object.Path
        }
    }

    LogSettings ([System.IO.FileInfo]$Path){
        $this.Path = $Path
    }

    LogSettings ([System.IO.DirectoryInfo]$Path){
        $this.Path = $this.NewLogFile($Path)
    }

    LogSettings([System.IO.FileInfo]$Path,[int]$Maxfiles,$MaxTotalSize){
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

Class GeneralSettings : Setting{

    [String]$Verbosity
    [Version]$Version
    [SettingType]$Type = "General"
    GeneralSettings([PsCustomObject]$Object){
        $this.Verbosity = $Object.Verbosity
        $this.Version = $Object.Version
        $this.SetSettingType("General")
    }

    GeneralSettings([String]$Verbosity,[Version]$Version){
        $this.Verbosity = $Verbosity
        $This.Version = $Version
        $this.SetSettingType("General")
    }
}

Class AssetSettings : Setting {
    [System.IO.FileInfo]$Path
    [Bool]$DefaultPath
    [SettingType]$Type = "Asset"

    AssetSettings([PsCustomObject]$Object,[System.Io.DirectoryInfo]$ModuleRootPath){
        $this.SetSettingType("Asset")
        If ($Object.Path -eq 'Default' -or $Object.Path -eq ""){
            
            $this.Path = Join-Path $ModuleRootPath.FullName -ChildPath "Assets"
            $this.DefaultPath = $True
        }Else{
            $this.Path = $Object.Path
            $This.DefaultPath = $false
        }
    }
<#

if($json.Assets.Path.Tolower() -eq 'default' -or $json.Assets.Path -eq '' ){
    $root = $this.Path.Directory.FullName
    $AssetsPath = "$Root/Assets"
}Else{
    $AssetsPath = $json.Assets.Path
}
#>

    [Bool]IsPathDefault(){
        return $this.DefaultPath
    }
}



Class SettingFactory{

    static [Setting] CreateSetting([System.IO.FileInfo]$Path){

        $JsonData = ConvertFrom-Json (gc $Path -raw)
        If($JsonData){
            $Keys = $JsonData.Psobject.Properties.GetEnumerator().Name

            Foreach($key in $Keys){
    
                Switch($Key){
                    "General"{
                        return [GeneralSettings]::new($JsonData.$Key)
                    }
                    "Logging"{
                        Return [LogSettings]::New($JsonData.$Key)
                    }
                    "Assets"{
                        REturn [AssetSettings]::New($JsonData.$Key)
                    }
                    Default {
                        Throw "Configuration $_ Not implemented."
                    }
                }
            }
            Throw "Configuration $($PAth.FullName) Not implemented."
        }else{
            throw "Config file not found"
        }
    }

    #Return a single setting 'part' (eg: General,Assets,Logging)
    static [Setting] CreateSetting([String]$Name,[System.IO.FileInfo]$ConfigurationFilePath){

        $JsonData = ConvertFrom-Json (gc $ConfigurationFilePath -raw)
        If($JsonData){
            #$Keys = $JsonData.Psobject.Properties.GetEnumerator().Name
            $RootModulePath = $ConfigurationFilePath.Directory.FullName
                Switch($Name){
                    "General"{
                        return [GeneralSettings]::new($JsonData.$Name)
                    }
                    "Logging"{
                        Return [LogSettings]::New($JsonData.$Name)
                    }
                    "Assets"{
                        
                        Return [AssetSettings]::New($JsonData.$Name,$RootModulePath)
                    }
                    Default {
                        Throw "Configuration $_ Not implemented."
                    }
                }
            
            Throw "Configuration $($ConfigurationFilePath.FullName) Not implemented."
        }else{
            throw "Config file not found"
        }
    }

    #Returns all the setting parts that exists in the config file.
    static [Setting[]] Parse([System.IO.FileInfo]$ConfigurationFilePath){
        $AllSettings = @()
        $JsonData = ConvertFrom-Json (gc $ConfigurationFilePath -raw)
        If($JsonData){
            $Keys = $JsonData.Psobject.Properties.GetEnumerator().Name
            $RootModulePath = $ConfigurationFilePath.Directory.FullName
            Foreach($Name in $Keys){

                Switch($Name){
                    "General"{
                        $AllSettings += [GeneralSettings]::new($JsonData.$Name)
                        ;Break
                    }
                    "Logging"{
                        $AllSettings += [LogSettings]::New($JsonData.$Name)
                        ;Break
                    }
                    "Assets"{
                        
                        $AllSettings += [AssetSettings]::New($JsonData.$Name,$RootModulePath)
                        ;Break
                    }
                    Default {
                        Throw "Configuration $_ Not implemented."
                    }
                }
            }
            
            Return $AllSettings
        }else{
            throw "Config file not found $($ConfigurationFilePath)- or config file is empty"
        }
    }

}


Class AssetsFactory{

    Static [Asset] CreateAsset([System.Io.FileInfo]$AssetPath){
        
        switch($AssetPath.Extension){
            ".js" {
                Return [ScriptAsset]::new($AssetPath)
                ;Break
            }
            ".css"{
                Return [StyleAsset]::new($AssetPath)
                ;Break
            }
            default{
                Throw "$($AssetPath.Extenion) is not a supported asset aaa type."
            }
        }

        Throw "$($AssetPath.FullName) Is not a supported Asset Type."
        
    }

    Static [Asset[]] CreateAssets([System.IO.DirectoryInfo]$AssetsFolderPath) {
        $Directories = Get-ChildItem $AssetsFolderPath -Directory
        $AllItems = @()

        Foreach($Directory in $Directories){
            $Items = $Directory | Get-ChildItem  -File | ? {$_.Extension -eq ".js" -or $_.Extension -eq ".css"} #If performance becomes important. Change this to -Filter
            Foreach($Item in $Items){
                if(!($Item)){
                    Continue
                }

                try{

                    $Type = [AssetsFactory]::GetAssetType($Item)
                }Catch{
                    
                    continue
                }
               
                Switch($Type){
                    "Script" {
                        $AllItems += [ScriptAsset]::new($Item)
                        Break;
                    }
                    "Style"{
                        $AllItems += [StyleAsset]::new($Item)
                        ;Break
                    }
                }
            }
        }

        Return $AllItems
    }

    hidden Static [AssetType]GetAssetType([System.IO.FileInfo]$File){
    

        switch($File.Extension){
            ".js" {
                Return [AssetType]::Script
                ;Break
            }
            ".css"{
                Return [AssetType]::Style
                ;Break
            }
            default{
                return $null
            }
            
        }
        return $null
        #Throw "$($File.Extenion) is not a supported asset type."
        
    }
}

Class Asset{

    [String]$Name
    [System.IO.DirectoryInfo]$FolderPath
    [System.IO.FileInfo]$FilePath
    [String]$RelativePath
    [AssetType]$Type

    Asset(){}
    
    Asset([System.IO.FileInfo]$FilePath){
        $this.FilePath = $FilePath
        $this.Parse()
        
    }

    Asset([System.IO.DirectoryInfo]$Path){
        $this.FolderPath = $Path
        $this.Parse()
        
    }

    Parse(){
        $this.FolderPath = $this.FilePath.Directory
        $this.SetRelativePath()
        $this.SetName()
    }

    [Void]SetName(){
        $this.Name = $This.FolderPath.Name
    }

    [Void]SetRelativePath(){
        $This.RelativePath = ([System.Io.Path]::Combine("Assets",$This.FilePath.Directory.Name,$this.FilePath.Name)).Replace("\","/")
    }

    [String]GetRelativePath(){
        return $this.RelativePath
    }

    [String]GetFullFilePath(){
        REturn $This.FilePath.FullName.Replace("\","/")
    }

    [String]ToString(){
        Throw "must be overwritten"
    }
}

Class ScriptAsset : Asset {
    ScriptAsset ([System.IO.FileInfo]$FilePath) : base([System.IO.FileInfo]$FilePath) { 
        $this.Type = [AssetType]::Script
    }
    ScriptAsset ([System.IO.DirectoryInfo]$Path) : base([System.IO.DirectoryInfo]$Path) { 
        $this.Type = [AssetType]::Script
    }

    [String] ToString(){
        $S = "<{0} src='{1}'></{0}>" -f "Script",$this.GetFullFilePath()
        Return $S
    }
}

Class StyleAsset : Asset {
    StyleAsset ([System.IO.FileInfo]$FilePath) : base([System.IO.FileInfo]$FilePath) { 
        $this.Type = [AssetType]::Style
    }
    StyleAsset ([System.IO.DirectoryInfo]$Path) : base([System.IO.DirectoryInfo]$Path) { 
        $this.Type = [AssetType]::Style
    }


     [String] ToString(){
         #rel="stylesheet"
        $S = "<{0} rel='{1}' type={2} href='{3}' >" -f "Link","stylesheet","text/css",$this.GetFullFilePath()
        Return $S
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

            Return [LogSettings]::New($Path)
        }Else{
            Throw "Log file is of wrong type. Please specify a System.IO.DirectoryInfo or System.IO.fileIno type."
        }
    }
    
    end {
    }
}
function Get-ConfigurationDocument {
    [CmdletBinding()]
    param (
        [System.IO.FileInfo]$Path,
        [Switch]$Force
    )
    
    begin {
    }
    
    process {
        if($Path){
            [ConfigurationDocument]::New($Path)
        }Else{

            [ConfigurationDocument]::New()
        }
    }
    
    end {
    }
}
