﻿#Generated at 10/20/2019 14:08:56 by Stephane van Gulick

Enum SettingType {
    General
    Asset
    Log
}

Enum AssetType {
    Script
    Style
    cdn
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

        $EC = Get-Variable ExecutionContext -ValueOnly
        $ProjectRootFolder = $ec.SessionState.Path.CurrentLocation.Path 
        $ModuleFolder = $This.Path.Directory

        #Assets
            $ModuleAssetsFolder = Join-Path $ModuleFolder -ChildPath "Assets"
            $ProjectAssetsFolder = Join-Path $ProjectRootFolder -ChildPath "Assets"

            $ModuleAssets = [AssetsFactory]::CreateAsset($ModuleAssetsFolder)
            $ProjectAssets = [AssetsFactory]::CreateAsset($ProjectAssetsFolder)

            $this.Assets += $ProjectAssets

            foreach ($modass in $ModuleAssets){
                if($this.Assets.name -contains $modass.name){
                    
                    $PotentialConflictingAsset = $this.Assets | ? {$_.Name -eq $modass.Name}
                    if($PotentialConflictingAsset.Type -eq $modass.type){

                        #write-verbose "Identical asset found at $($modass.name). Keeping project asset."
                        Continue
                    }else{
                        $This.Assets += $modass
                    }
                }else{
                    $This.Assets += $modass
                }
            }

        #Includes
            #$IncludesFolder = Join-Path -Path $ExecutionContext.SessionState.Path.CurrentLocation.Path -ChildPath "Includes" #Join-Path $this.Path.Directory -ChildPath 'Includes'
            $IncludesFolder = Join-Path -Path $ProjectRootFolder -ChildPath "Includes"
            $this.Includes = [IncludeFactory]::Create($IncludesFolder)

            $ModuleIncludesFolder = Join-Path $ModuleFolder -ChildPath "Includes"
            $ProjectIncludesFolder = Join-Path $ProjectRootFolder -ChildPath "Assets"

            $ModuleIncludes = [IncludeFactory]::Create($ModuleIncludesFolder)
            $ProjectIncludes = [IncludeFactory]::Create($ProjectIncludesFolder)

            $this.Includes += $ProjectIncludes

            foreach ($modinc in $ModuleIncludes){
                if($this.Includes.name -contains $modinc.name){
                    
                    $PotentialConflictingInclude = $this.Includes | ? {$_.Name -eq $modinc.Name}
                    if($PotentialConflictingInclude.Type -eq $modinc.type){

                        #write-verbose "Identical asset found at $($modinc.name). Keeping project asset."
                        Continue
                    }
                    
                    Continue
                }else{
                    $This.Includes += $modinc
                }
            }
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
        if($global:PSVersionTable.os -match '^Linux.*'){
            #Linux
            $p = "/tmp/pshtml/"
        }elseif($global:PSVersionTable.OS -match '^Darwin.*'){
            #Macos
            $p = $env:TMPDIR
        }
        Else{
            #Windows
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


    Static [Asset[]] CreateAsset([String]$AssetPath){
        if(Test-Path $AssetPath){

            $It = Get-Item $AssetPath 
        }else{
            Return $Null
        }
        
        If($It -is [System.Io.FileInfo]){
            Return [AssetsFactory]::CreateAsset([System.Io.FileInfo]$It)
        }elseif($It -is [System.IO.DirectoryInfo]){
            Return [AssetsFactory]::CreateAssets([System.IO.DirectoryInfo]$It)
        }elseif($null -eq $It){
            return $null
            #No assets are present
            #throw "Asset file type at $($AssetPath) could not be identified. Please specify a folder or a file."
        }else{
            Throw "Asset type could not be identified."
        }
        
        
    }

    hidden Static [Asset[]] CreateAsset([System.Io.FileInfo]$AssetPath){
        $r = @()
        switch($AssetPath.Extension){
            ".js" {
                $r += [ScriptAsset]::new($AssetPath)
                ;Break
            }
            ".css"{
                $r += [StyleAsset]::new($AssetPath)
                ;Break
            }
            ".cdn"{
                $r += [CDNAsset]::new($AssetPath)
                ;Break
            }
            default{
                Throw "$($AssetPath.Extenion) is not a supported asset type."
            }
        }
        return $r
        
    }

    hidden Static [Asset[]] CreateAssets([System.IO.DirectoryInfo]$AssetsFolderPath) {

        $Directories = Get-ChildItem $AssetsFolderPath -Directory
        $AllItems = @()

        Foreach($Directory in $Directories){
            $Items = $Directory | Get-ChildItem  -File | ? {$_.Extension -eq ".js" -or $_.Extension -eq ".css" -or $_.Extension -eq ".cdn"} #If performance becomes important. Change this to -Filter
            Foreach($Item in $Items){
                if(!($Item)){
                    Continue
                }
                <#
                try{

                    $Type = [AssetsFactory]::GetAssetType($Item)
                }Catch{
                    
                    continue
                }
                #>
                 $AllItems += [AssetsFactory]::CreateAsset($Item)
                
            }
        }
        return $AllItems
        
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
            ".cdn"{
                Return [AssetType]::cdn
                ;Break
            }
            default{
                return $null
            }
            
        }
        return $null
        #Throw "$($File.Extenion) is not a supported asset type."
        
    }
    hidden Static [AssetType]GetAssetType([String]$Asset){
    
        $null = $Asset -match "^.*(?'extension'.*\..{1,4}$)"

        switch($Matches.Extension){
            ".js" {
                Return [AssetType]::Script
                ;Break
            }
            ".css"{
                Return [AssetType]::Style
                ;Break
            }
            ".cdn"{
                Return [AssetType]::cdn
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

Class CDNAsset : Asset {
    [String]$Integrity
    [String]$CrossOrigin
    Hidden [AssetType]$cdnType
    hidden $raw

    CDNAsset ([System.IO.FileInfo]$FilePath) { 
        

        $this.raw = Get-Content $filePath.FullName -Raw | ConvertFrom-Json
        $this.Type = [AssetType]::cdn
        $this.cdnType = [AssetsFactory]::GetAssetType($This.raw.source)
        $this.Name = $filePath.BaseName
        if($this.raw.integrity){
            $this.Integrity = $this.raw.Integrity
        }

        if($this.raw.CrossOrigin){
            $This.CrossOrigin = $This.Raw.CrossOrigin
        }
    }
    
    [String] ToString(){
    $t = ""
    $p = ""
    $full_CrossOrigin = ""
    $full_Integrity = ""
    Switch($this.cdnType){
        "script" {
            #$s = "<{0} src='{1}'>" -f "Script",$raw.source
            $t = 'script'
            $p = 'src'
            ;break
        }
        "style"{
            #$t = "<{0} src='{1}'>" -f "Link",$raw.source
            $t = 'link'
            $p = 'href'
        }
    }


        if($this.CrossOrigin){
            $full_CrossOrigin = "crossorigin='{0}'" -f $this.CrossOrigin
        }

        If($This.Integrity){
            $full_Integrity = "integrity='{0}'" -f $this.Integrity
        }
        $S = "<{0} {1}='{2}' {3} {4}></{0}>" -f $t,$p,$this.raw.source,$full_CrossOrigin,$full_Integrity
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


enum MessageType{

    Information = 0
    Confirmation = 1
    warning = 2
    error = 3
}

Class LogDocument{
    
    
    LogDocument(){
        $ClassType = $this.GetType()
        if($ClassType -eq [LogDocument]){
            throw "this class cannot be instanciated, it must be inherited."
        }
    }
    writelog(){
        throw("Must be overwritten!")
    }
}

<#
Class LogFile : LogDocument {

    [System.IO.FileInfo]$File
    [String]$FileName
    [string]$Folder


    LogFile (){
        
        $CurrentInvocation = $MyInvocation.MyCommand.Definition 
        $PSCommandPath = $PSCommandPath
        $location = (Get-Location).Path
       


        $stack = Get-PSCallStack
        If($stack.Location -eq "<No File>"){
            if(($stack | measure).Count -ge 2){
                $cp = (Get-PSCallStack)[-2].ScriptName
            }else{

                $cp = $PSCommandPath
            }
        }else{

            $cp = (Get-PSCallStack)[-1].ScriptName #$PSCommandPath #Split-Path -parent $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath(ï¿½.\ï¿½) #$PSCommandPath
        }

        $cp = $global:MyInvocation.MyCommand.Definition #fix for Ubuntu appveyor machines.
        $sr = $psScriptRoot
        
        $Extension = (get-item -Path $cp).Extension

        $leaf = Split-Path $cp -Leaf

        $Name = $leaf.Replace($Extension,"")
        #$Name = $MyInvocation.ScriptName.Replace(".ps1","")
        $timestamp = get-date -uformat '%Y%m%d-%T'
        $timestamp = $timestamp.Replace(':','')
        $FullFileName = $Name + '_' + $timestamp + '.log'
        $ScriptRoot = split-Path -Path $cp -Parent
        $LogFolderPath = Join-Path -Path $ScriptRoot -ChildPath 'logs'
        #$LogFolderPath = join-Path -Path $psScriptRoot -ChildPath 'logs'
        if (!(test-Path $LogFolderPath)){
            mkdir $LogFolderPath
        }
        $FullPath = Join-Path -Path $LogFolderPath -ChildPath $FullFileName

        $this.File = $FullPath
        $this.FileName = $FullFileName
        $this.Folder = $LogFolderPath

       

        #Add cleaning part
     
    }

    LogFile ([string]$Path){
    
            $FullFileName = $this.CreateFileName()
            
              
            
            if (!(Test-Path $Path)){
                $null = mkdir $Path
            }
            
            $FullPath = Join-Path -Path $Path -ChildPath $FullFileName
            
            $this.File = $FullPath
            $this.FileName = $FullFileName
            $this.Folder = $Path

            #$this.LogFileConfig = [LogFileConfig]::New($this)
        
    }

    WriteLog([LogMessage]$Message){
       
            #To change to String builder?

            $Writer = [System.IO.StreamWriter]::($This.Path,$true)
            $Writer.write($Message.ToString())
            #add-content -Path $this.File.FullName -Value $Message.ToString()
    }

    hidden [string] CreateFileName() {
        $cp = $PSCommandPath #Split-Path -parent $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath(ï¿½.\ï¿½) #$PSCommandPath
        if(!($cp)){
            $cp = (Get-PSCallStack)[-1].ScriptName 
        }
        #Write-Host "cp: $($cp)" -ForegroundColor DarkCyan
        $sr = $psScriptRoot
        $Extension = (get-item -Path $cp).Extension

        $leaf = Split-Path $cp -Leaf

        $Name = $leaf.Replace($Extension,"")
        #$Name = $MyInvocation.ScriptName.Replace(".ps1","")
        $timestamp = get-date -uformat '%Y%m%d-%T'
        $timestamp = $timestamp.Replace(':','')
        $FullFileName = $Name + '_' + $timestamp + '.log'


        Return $FullFileName
    }
    
    [String] ToString(){
        Return "[{0}] Logs have written to: {1} " -f $this.Type.ToString(),$this.File
    }

}
#>
Class Logger{
    [System.IO.FileInfo]$Logfile
    
    Logger (){
        #$this.Logfile = $PSHTML_CONFIG.Logging.Path
        $this.Logfile = "$env:HOME/Logging.log"
    }
    Logger ($Path){
        $IOF = [System.IO.FileInfo]$Path
        If(!($IOF.Directory.Exists)){
            $IOF.Directory.Create()
        }
        
        $this.Logfile = $Path
    }

    Log($Message){
        $sw = [System.IO.StreamWriter]::new($this.LogFile,$true,[System.Text.Encoding]::UTF8)
        $sw.WriteLine($Message)
        $sw.Close()
    }
}

Class LogMessage {
    [MessageType]$Type
    $message
    $Timestamp 
    hidden $TypePrefix

    LogMessage (){
        $this.Timestamp = get-date -uformat '%Y%m%d-%T'
    }
    LogMessage ($Message){
        $this.Message = $Message
        $this.Timestamp = get-date -uformat '%Y%m%d-%T'
    }
    LogMessage([String]$Message,[MessageType]$type){
        $this.Message = $Message
        $this.Type = $type
        $this.Timestamp = get-date -uformat '%Y%m%d-%T'
    }

    [String] ToString(){

        $this.typeprefix = '[OK   ]'
        switch ($this.type){
            information {
                $eventType = "Information"
                $this.typeprefix = 'INFO '
                break;
            }
            warning{
                $eventType = "Warning"
                $this.typeprefix = 'WARN '
                break;
            }
            error{
                $eventType = "Error"
                $this.typeprefix = 'ERROR'
                break;
            }
            default {
                $eventType = "Information"
                $this.typeprefix = 'INFO '
               
            }
        }

        return $this.FormatMessage()
        #[$this.timestamp] + $typeprefix + $this.Message
    }
    [String]FormatMessage(){
        return "[{0}][{1}] -> {2}" -f $this.Timestamp,$this.Typeprefix,$this.message
    }

    Static [String] FormatMessage([String]$MessageType,[String]$msg){
        $Ts = get-date -uformat '%Y%m%d-%T'
        If(!($MessageType)){
            $MessageType = "INFO "

        }

        return "[{0}][{1}] -> {2}" -f $Ts,$MessageType,$msg
    }

}


#From Jakub Jares (Thanks!)
function Clear-WhiteSpace ($Text) {
    "$($Text -replace "(`t|`n|`r)"," " -replace "\s+"," ")".Trim()
}

Enum ChartType {
    bar
    horizontalBar
    line
    doughnut
    pie
    radar
    polarArea
}

Class Color {
    [int]$r
    [int]$g
    [int]$b
    [double]$a

    color([int]$r,[int]$g,[int]$b){
        $this.r = $r
        $this.g = $g
        $this.b = $b
    }

    color([int]$r,[int]$g,[int]$b,[double]$a){
        $this.r = $r
        $this.g = $g
        $this.b = $b
        $this.a = $a
    }

<#

    Original color names

    static [String] $blue = "rgb(30,144,255)"
    static [String] $red = "rgb(220,20,60)"
    static [string] $Yellow = "rgb(255,255,0)"
    static [string] $Green = "rgb(173,255,47)"
    static [string] $Orange = "rgb(255,165,0)"
    static [string] $Black = "rgb(0,0,0)"
    static [string] $White = "rgb(255,255,255)"
#>

#   W3 color names
#   Implement hex, rgb, rgba, hsl and hsla types
#   https://www.w3.org/TR/css-color-3/#colorunits
static [object] $aliceblue_def = @{"r"=240;"g"=248;"b"=255}
static [object] $antiquewhite_def = @{"r"=250;"g"=235;"b"=215}
static [object] $aqua_def = @{"r"=0;"g"=255;"b"=255}
static [object] $aquamarine_def = @{"r"=127;"g"=255;"b"=212}
static [object] $azure_def = @{"r"=240;"g"=255;"b"=255}
static [object] $beige_def = @{"r"=245;"g"=245;"b"=220}
static [object] $bisque_def = @{"r"=255;"g"=228;"b"=196}
static [object] $black_def = @{"r"=0;"g"=0;"b"=0}
static [object] $blanchedalmond_def = @{"r"=255;"g"=235;"b"=205}
static [object] $blue_def = @{"r"=0;"g"=0;"b"=255}
static [object] $blueviolet_def = @{"r"=138;"g"=43;"b"=226}
static [object] $brown_def = @{"r"=165;"g"=42;"b"=42}
static [object] $burlywood_def = @{"r"=222;"g"=184;"b"=135}
static [object] $cadetblue_def = @{"r"=95;"g"=158;"b"=160}
static [object] $chartreuse_def = @{"r"=127;"g"=255;"b"=0}
static [object] $chocolate_def = @{"r"=210;"g"=105;"b"=30}
static [object] $coral_def = @{"r"=255;"g"=127;"b"=80}
static [object] $cornflowerblue_def = @{"r"=100;"g"=149;"b"=237}
static [object] $cornsilk_def = @{"r"=255;"g"=248;"b"=220}
static [object] $crimson_def = @{"r"=220;"g"=20;"b"=60}
static [object] $cyan_def = @{"r"=0;"g"=255;"b"=255}
static [object] $darkblue_def = @{"r"=0;"g"=0;"b"=139}
static [object] $darkcyan_def = @{"r"=0;"g"=139;"b"=139}
static [object] $darkgoldenrod_def = @{"r"=184;"g"=134;"b"=11}
static [object] $darkgray_def = @{"r"=169;"g"=169;"b"=169}
static [object] $darkgreen_def = @{"r"=0;"g"=100;"b"=0}
static [object] $darkgrey_def = @{"r"=169;"g"=169;"b"=169}
static [object] $darkkhaki_def = @{"r"=189;"g"=183;"b"=107}
static [object] $darkmagenta_def = @{"r"=139;"g"=0;"b"=139}
static [object] $darkolivegreen_def = @{"r"=85;"g"=107;"b"=47}
static [object] $darkorange_def = @{"r"=255;"g"=140;"b"=0}
static [object] $darkorchid_def = @{"r"=153;"g"=50;"b"=204}
static [object] $darkred_def = @{"r"=139;"g"=0;"b"=0}
static [object] $darksalmon_def = @{"r"=233;"g"=150;"b"=122}
static [object] $darkseagreen_def = @{"r"=143;"g"=188;"b"=143}
static [object] $darkslateblue_def = @{"r"=72;"g"=61;"b"=139}
static [object] $darkslategray_def = @{"r"=47;"g"=79;"b"=79}
static [object] $darkslategrey_def = @{"r"=47;"g"=79;"b"=79}
static [object] $darkturquoise_def = @{"r"=0;"g"=206;"b"=209}
static [object] $darkviolet_def = @{"r"=148;"g"=0;"b"=211}
static [object] $deeppink_def = @{"r"=255;"g"=20;"b"=147}
static [object] $deepskyblue_def = @{"r"=0;"g"=191;"b"=255}
static [object] $dimgray_def = @{"r"=105;"g"=105;"b"=105}
static [object] $dimgrey_def = @{"r"=105;"g"=105;"b"=105}
static [object] $dodgerblue_def = @{"r"=30;"g"=144;"b"=255}
static [object] $firebrick_def = @{"r"=178;"g"=34;"b"=34}
static [object] $floralwhite_def = @{"r"=255;"g"=250;"b"=240}
static [object] $forestgreen_def = @{"r"=34;"g"=139;"b"=34}
static [object] $fuchsia_def = @{"r"=255;"g"=0;"b"=255}
static [object] $gainsboro_def = @{"r"=220;"g"=220;"b"=220}
static [object] $ghostwhite_def = @{"r"=248;"g"=248;"b"=255}
static [object] $gold_def = @{"r"=255;"g"=215;"b"=0}
static [object] $goldenrod_def = @{"r"=218;"g"=165;"b"=32}
static [object] $gray_def = @{"r"=128;"g"=128;"b"=128}
static [object] $green_def = @{"r"=0;"g"=128;"b"=0}
static [object] $greenyellow_def = @{"r"=173;"g"=255;"b"=47}
static [object] $grey_def = @{"r"=128;"g"=128;"b"=128}
static [object] $honeydew_def = @{"r"=240;"g"=255;"b"=240}
static [object] $hotpink_def = @{"r"=255;"g"=105;"b"=180}
static [object] $indianred_def = @{"r"=205;"g"=92;"b"=92}
static [object] $indigo_def = @{"r"=75;"g"=0;"b"=130}
static [object] $ivory_def = @{"r"=255;"g"=255;"b"=240}
static [object] $khaki_def = @{"r"=240;"g"=230;"b"=140}
static [object] $lavender_def = @{"r"=230;"g"=230;"b"=250}
static [object] $lavenderblush_def = @{"r"=255;"g"=240;"b"=245}
static [object] $lawngreen_def = @{"r"=124;"g"=252;"b"=0}
static [object] $lemonchiffon_def = @{"r"=255;"g"=250;"b"=205}
static [object] $lightblue_def = @{"r"=173;"g"=216;"b"=230}
static [object] $lightcoral_def = @{"r"=240;"g"=128;"b"=128}
static [object] $lightcyan_def = @{"r"=224;"g"=255;"b"=255}
static [object] $lightgoldenrodyellow_def = @{"r"=250;"g"=250;"b"=210}
static [object] $lightgray_def = @{"r"=211;"g"=211;"b"=211}
static [object] $lightgreen_def = @{"r"=144;"g"=238;"b"=144}
static [object] $lightgrey_def = @{"r"=211;"g"=211;"b"=211}
static [object] $lightpink_def = @{"r"=255;"g"=182;"b"=193}
static [object] $lightsalmon_def = @{"r"=255;"g"=160;"b"=122}
static [object] $lightseagreen_def = @{"r"=32;"g"=178;"b"=170}
static [object] $lightskyblue_def = @{"r"=135;"g"=206;"b"=250}
static [object] $lightslategray_def = @{"r"=119;"g"=136;"b"=153}
static [object] $lightslategrey_def = @{"r"=119;"g"=136;"b"=153}
static [object] $lightsteelblue_def = @{"r"=176;"g"=196;"b"=222}
static [object] $lightyellow_def = @{"r"=255;"g"=255;"b"=224}
static [object] $lime_def = @{"r"=0;"g"=255;"b"=0}
static [object] $limegreen_def = @{"r"=50;"g"=205;"b"=50}
static [object] $linen_def = @{"r"=250;"g"=240;"b"=230}
static [object] $magenta_def = @{"r"=255;"g"=0;"b"=255}
static [object] $maroon_def = @{"r"=128;"g"=0;"b"=0}
static [object] $mediumaquamarine_def = @{"r"=102;"g"=205;"b"=170}
static [object] $mediumblue_def = @{"r"=0;"g"=0;"b"=205}
static [object] $mediumorchid_def = @{"r"=186;"g"=85;"b"=211}
static [object] $mediumpurple_def = @{"r"=147;"g"=112;"b"=219}
static [object] $mediumseagreen_def = @{"r"=60;"g"=179;"b"=113}
static [object] $mediumslateblue_def = @{"r"=123;"g"=104;"b"=238}
static [object] $mediumspringgreen_def = @{"r"=0;"g"=250;"b"=154}
static [object] $mediumturquoise_def = @{"r"=72;"g"=209;"b"=204}
static [object] $mediumvioletred_def = @{"r"=199;"g"=21;"b"=133}
static [object] $midnightblue_def = @{"r"=25;"g"=25;"b"=112}
static [object] $mintcream_def = @{"r"=245;"g"=255;"b"=250}
static [object] $mistyrose_def = @{"r"=255;"g"=228;"b"=225}
static [object] $moccasin_def = @{"r"=255;"g"=228;"b"=181}
static [object] $navajowhite_def = @{"r"=255;"g"=222;"b"=173}
static [object] $navy_def = @{"r"=0;"g"=0;"b"=128}
static [object] $oldlace_def = @{"r"=253;"g"=245;"b"=230}
static [object] $olive_def = @{"r"=128;"g"=128;"b"=0}
static [object] $olivedrab_def = @{"r"=107;"g"=142;"b"=35}
static [object] $orange_def = @{"r"=255;"g"=165;"b"=0}
static [object] $orangered_def = @{"r"=255;"g"=69;"b"=0}
static [object] $orchid_def = @{"r"=218;"g"=112;"b"=214}
static [object] $palegoldenrod_def = @{"r"=238;"g"=232;"b"=170}
static [object] $palegreen_def = @{"r"=152;"g"=251;"b"=152}
static [object] $paleturquoise_def = @{"r"=175;"g"=238;"b"=238}
static [object] $palevioletred_def = @{"r"=219;"g"=112;"b"=147}
static [object] $papayawhip_def = @{"r"=255;"g"=239;"b"=213}
static [object] $peachpuff_def = @{"r"=255;"g"=218;"b"=185}
static [object] $peru_def = @{"r"=205;"g"=133;"b"=63}
static [object] $pink_def = @{"r"=255;"g"=192;"b"=203}
static [object] $plum_def = @{"r"=221;"g"=160;"b"=221}
static [object] $powderblue_def = @{"r"=176;"g"=224;"b"=230}
static [object] $purple_def = @{"r"=128;"g"=0;"b"=128}
static [object] $red_def = @{"r"=255;"g"=0;"b"=0}
static [object] $rosybrown_def = @{"r"=188;"g"=143;"b"=143}
static [object] $royalblue_def = @{"r"=65;"g"=105;"b"=225}
static [object] $saddlebrown_def = @{"r"=139;"g"=69;"b"=19}
static [object] $salmon_def = @{"r"=250;"g"=128;"b"=114}
static [object] $sandybrown_def = @{"r"=244;"g"=164;"b"=96}
static [object] $seagreen_def = @{"r"=46;"g"=139;"b"=87}
static [object] $seashell_def = @{"r"=255;"g"=245;"b"=238}
static [object] $sienna_def = @{"r"=160;"g"=82;"b"=45}
static [object] $silver_def = @{"r"=192;"g"=192;"b"=192}
static [object] $skyblue_def = @{"r"=135;"g"=206;"b"=235}
static [object] $slateblue_def = @{"r"=106;"g"=90;"b"=205}
static [object] $slategray_def = @{"r"=112;"g"=128;"b"=144}
static [object] $slategrey_def = @{"r"=112;"g"=128;"b"=144}
static [object] $snow_def = @{"r"=255;"g"=250;"b"=250}
static [object] $springgreen_def = @{"r"=0;"g"=255;"b"=127}
static [object] $steelblue_def = @{"r"=70;"g"=130;"b"=180}
static [object] $tan_def = @{"r"=210;"g"=180;"b"=140}
static [object] $teal_def = @{"r"=0;"g"=128;"b"=128}
static [object] $thistle_def = @{"r"=216;"g"=191;"b"=216}
static [object] $tomato_def = @{"r"=255;"g"=99;"b"=71}
static [object] $turquoise_def = @{"r"=64;"g"=224;"b"=208}
static [object] $violet_def = @{"r"=238;"g"=130;"b"=238}
static [object] $wheat_def = @{"r"=245;"g"=222;"b"=179}
static [object] $white_def = @{"r"=255;"g"=255;"b"=255}
static [object] $whitesmoke_def = @{"r"=245;"g"=245;"b"=245}
static [object] $yellow_def = @{"r"=255;"g"=255;"b"=0}
static [object] $yellowgreen_def = @{"r"=154;"g"=205;"b"=50}

static [string] $aliceblue = "rgb({0},{1},{2})" -f [Color]::aliceblue_def.r, [Color]::aliceblue_def.g, [Color]::aliceblue_def.b
static [string] $antiquewhite = "rgb({0},{1},{2})" -f [Color]::antiquewhite_def.r, [Color]::antiquewhite_def.g, [Color]::antiquewhite_def.b
static [string] $aqua = "rgb({0},{1},{2})" -f [Color]::aqua_def.r, [Color]::aqua_def.g, [Color]::aqua_def.b
static [string] $aquamarine = "rgb({0},{1},{2})" -f [Color]::aquamarine_def.r, [Color]::aquamarine_def.g, [Color]::aquamarine_def.b
static [string] $azure = "rgb({0},{1},{2})" -f [Color]::azure_def.r, [Color]::azure_def.g, [Color]::azure_def.b
static [string] $beige = "rgb({0},{1},{2})" -f [Color]::beige_def.r, [Color]::beige_def.g, [Color]::beige_def.b
static [string] $bisque = "rgb({0},{1},{2})" -f [Color]::bisque_def.r, [Color]::bisque_def.g, [Color]::bisque_def.b
static [string] $black = "rgb({0},{1},{2})" -f [Color]::black_def.r, [Color]::black_def.g, [Color]::black_def.b
static [string] $blanchedalmond = "rgb({0},{1},{2})" -f [Color]::blanchedalmond_def.r, [Color]::blanchedalmond_def.g, [Color]::blanchedalmond_def.b
static [string] $blue = "rgb({0},{1},{2})" -f [Color]::blue_def.r, [Color]::blue_def.g, [Color]::blue_def.b
static [string] $blueviolet = "rgb({0},{1},{2})" -f [Color]::blueviolet_def.r, [Color]::blueviolet_def.g, [Color]::blueviolet_def.b
static [string] $brown = "rgb({0},{1},{2})" -f [Color]::brown_def.r, [Color]::brown_def.g, [Color]::brown_def.b
static [string] $burlywood = "rgb({0},{1},{2})" -f [Color]::burlywood_def.r, [Color]::burlywood_def.g, [Color]::burlywood_def.b
static [string] $cadetblue = "rgb({0},{1},{2})" -f [Color]::cadetblue_def.r, [Color]::cadetblue_def.g, [Color]::cadetblue_def.b
static [string] $chartreuse = "rgb({0},{1},{2})" -f [Color]::chartreuse_def.r, [Color]::chartreuse_def.g, [Color]::chartreuse_def.b
static [string] $chocolate = "rgb({0},{1},{2})" -f [Color]::chocolate_def.r, [Color]::chocolate_def.g, [Color]::chocolate_def.b
static [string] $coral = "rgb({0},{1},{2})" -f [Color]::coral_def.r, [Color]::coral_def.g, [Color]::coral_def.b
static [string] $cornflowerblue = "rgb({0},{1},{2})" -f [Color]::cornflowerblue_def.r, [Color]::cornflowerblue_def.g, [Color]::cornflowerblue_def.b
static [string] $cornsilk = "rgb({0},{1},{2})" -f [Color]::cornsilk_def.r, [Color]::cornsilk_def.g, [Color]::cornsilk_def.b
static [string] $crimson = "rgb({0},{1},{2})" -f [Color]::crimson_def.r, [Color]::crimson_def.g, [Color]::crimson_def.b
static [string] $cyan = "rgb({0},{1},{2})" -f [Color]::cyan_def.r, [Color]::cyan_def.g, [Color]::cyan_def.b
static [string] $darkblue = "rgb({0},{1},{2})" -f [Color]::darkblue_def.r, [Color]::darkblue_def.g, [Color]::darkblue_def.b
static [string] $darkcyan = "rgb({0},{1},{2})" -f [Color]::darkcyan_def.r, [Color]::darkcyan_def.g, [Color]::darkcyan_def.b
static [string] $darkgoldenrod = "rgb({0},{1},{2})" -f [Color]::darkgoldenrod_def.r, [Color]::darkgoldenrod_def.g, [Color]::darkgoldenrod_def.b
static [string] $darkgray = "rgb({0},{1},{2})" -f [Color]::darkgray_def.r, [Color]::darkgray_def.g, [Color]::darkgray_def.b
static [string] $darkgreen = "rgb({0},{1},{2})" -f [Color]::darkgreen_def.r, [Color]::darkgreen_def.g, [Color]::darkgreen_def.b
static [string] $darkgrey = "rgb({0},{1},{2})" -f [Color]::darkgrey_def.r, [Color]::darkgrey_def.g, [Color]::darkgrey_def.b
static [string] $darkkhaki = "rgb({0},{1},{2})" -f [Color]::darkkhaki_def.r, [Color]::darkkhaki_def.g, [Color]::darkkhaki_def.b
static [string] $darkmagenta = "rgb({0},{1},{2})" -f [Color]::darkmagenta_def.r, [Color]::darkmagenta_def.g, [Color]::darkmagenta_def.b
static [string] $darkolivegreen = "rgb({0},{1},{2})" -f [Color]::darkolivegreen_def.r, [Color]::darkolivegreen_def.g, [Color]::darkolivegreen_def.b
static [string] $darkorange = "rgb({0},{1},{2})" -f [Color]::darkorange_def.r, [Color]::darkorange_def.g, [Color]::darkorange_def.b
static [string] $darkorchid = "rgb({0},{1},{2})" -f [Color]::darkorchid_def.r, [Color]::darkorchid_def.g, [Color]::darkorchid_def.b
static [string] $darkred = "rgb({0},{1},{2})" -f [Color]::darkred_def.r, [Color]::darkred_def.g, [Color]::darkred_def.b
static [string] $darksalmon = "rgb({0},{1},{2})" -f [Color]::darksalmon_def.r, [Color]::darksalmon_def.g, [Color]::darksalmon_def.b
static [string] $darkseagreen = "rgb({0},{1},{2})" -f [Color]::darkseagreen_def.r, [Color]::darkseagreen_def.g, [Color]::darkseagreen_def.b
static [string] $darkslateblue = "rgb({0},{1},{2})" -f [Color]::darkslateblue_def.r, [Color]::darkslateblue_def.g, [Color]::darkslateblue_def.b
static [string] $darkslategray = "rgb({0},{1},{2})" -f [Color]::darkslategray_def.r, [Color]::darkslategray_def.g, [Color]::darkslategray_def.b
static [string] $darkslategrey = "rgb({0},{1},{2})" -f [Color]::darkslategrey_def.r, [Color]::darkslategrey_def.g, [Color]::darkslategrey_def.b
static [string] $darkturquoise = "rgb({0},{1},{2})" -f [Color]::darkturquoise_def.r, [Color]::darkturquoise_def.g, [Color]::darkturquoise_def.b
static [string] $darkviolet = "rgb({0},{1},{2})" -f [Color]::darkviolet_def.r, [Color]::darkviolet_def.g, [Color]::darkviolet_def.b
static [string] $deeppink = "rgb({0},{1},{2})" -f [Color]::deeppink_def.r, [Color]::deeppink_def.g, [Color]::deeppink_def.b
static [string] $deepskyblue = "rgb({0},{1},{2})" -f [Color]::deepskyblue_def.r, [Color]::deepskyblue_def.g, [Color]::deepskyblue_def.b
static [string] $dimgray = "rgb({0},{1},{2})" -f [Color]::dimgray_def.r, [Color]::dimgray_def.g, [Color]::dimgray_def.b
static [string] $dimgrey = "rgb({0},{1},{2})" -f [Color]::dimgrey_def.r, [Color]::dimgrey_def.g, [Color]::dimgrey_def.b
static [string] $dodgerblue = "rgb({0},{1},{2})" -f [Color]::dodgerblue_def.r, [Color]::dodgerblue_def.g, [Color]::dodgerblue_def.b
static [string] $firebrick = "rgb({0},{1},{2})" -f [Color]::firebrick_def.r, [Color]::firebrick_def.g, [Color]::firebrick_def.b
static [string] $floralwhite = "rgb({0},{1},{2})" -f [Color]::floralwhite_def.r, [Color]::floralwhite_def.g, [Color]::floralwhite_def.b
static [string] $forestgreen = "rgb({0},{1},{2})" -f [Color]::forestgreen_def.r, [Color]::forestgreen_def.g, [Color]::forestgreen_def.b
static [string] $fuchsia = "rgb({0},{1},{2})" -f [Color]::fuchsia_def.r, [Color]::fuchsia_def.g, [Color]::fuchsia_def.b
static [string] $gainsboro = "rgb({0},{1},{2})" -f [Color]::gainsboro_def.r, [Color]::gainsboro_def.g, [Color]::gainsboro_def.b
static [string] $ghostwhite = "rgb({0},{1},{2})" -f [Color]::ghostwhite_def.r, [Color]::ghostwhite_def.g, [Color]::ghostwhite_def.b
static [string] $gold = "rgb({0},{1},{2})" -f [Color]::gold_def.r, [Color]::gold_def.g, [Color]::gold_def.b
static [string] $goldenrod = "rgb({0},{1},{2})" -f [Color]::goldenrod_def.r, [Color]::goldenrod_def.g, [Color]::goldenrod_def.b
static [string] $gray = "rgb({0},{1},{2})" -f [Color]::gray_def.r, [Color]::gray_def.g, [Color]::gray_def.b
static [string] $green = "rgb({0},{1},{2})" -f [Color]::green_def.r, [Color]::green_def.g, [Color]::green_def.b
static [string] $greenyellow = "rgb({0},{1},{2})" -f [Color]::greenyellow_def.r, [Color]::greenyellow_def.g, [Color]::greenyellow_def.b
static [string] $grey = "rgb({0},{1},{2})" -f [Color]::grey_def.r, [Color]::grey_def.g, [Color]::grey_def.b
static [string] $honeydew = "rgb({0},{1},{2})" -f [Color]::honeydew_def.r, [Color]::honeydew_def.g, [Color]::honeydew_def.b
static [string] $hotpink = "rgb({0},{1},{2})" -f [Color]::hotpink_def.r, [Color]::hotpink_def.g, [Color]::hotpink_def.b
static [string] $indianred = "rgb({0},{1},{2})" -f [Color]::indianred_def.r, [Color]::indianred_def.g, [Color]::indianred_def.b
static [string] $indigo = "rgb({0},{1},{2})" -f [Color]::indigo_def.r, [Color]::indigo_def.g, [Color]::indigo_def.b
static [string] $ivory = "rgb({0},{1},{2})" -f [Color]::ivory_def.r, [Color]::ivory_def.g, [Color]::ivory_def.b
static [string] $khaki = "rgb({0},{1},{2})" -f [Color]::khaki_def.r, [Color]::khaki_def.g, [Color]::khaki_def.b
static [string] $lavender = "rgb({0},{1},{2})" -f [Color]::lavender_def.r, [Color]::lavender_def.g, [Color]::lavender_def.b
static [string] $lavenderblush = "rgb({0},{1},{2})" -f [Color]::lavenderblush_def.r, [Color]::lavenderblush_def.g, [Color]::lavenderblush_def.b
static [string] $lawngreen = "rgb({0},{1},{2})" -f [Color]::lawngreen_def.r, [Color]::lawngreen_def.g, [Color]::lawngreen_def.b
static [string] $lemonchiffon = "rgb({0},{1},{2})" -f [Color]::lemonchiffon_def.r, [Color]::lemonchiffon_def.g, [Color]::lemonchiffon_def.b
static [string] $lightblue = "rgb({0},{1},{2})" -f [Color]::lightblue_def.r, [Color]::lightblue_def.g, [Color]::lightblue_def.b
static [string] $lightcoral = "rgb({0},{1},{2})" -f [Color]::lightcoral_def.r, [Color]::lightcoral_def.g, [Color]::lightcoral_def.b
static [string] $lightcyan = "rgb({0},{1},{2})" -f [Color]::lightcyan_def.r, [Color]::lightcyan_def.g, [Color]::lightcyan_def.b
static [string] $lightgoldenrodyellow = "rgb({0},{1},{2})" -f [Color]::lightgoldenrodyellow_def.r, [Color]::lightgoldenrodyellow_def.g, [Color]::lightgoldenrodyellow_def.b
static [string] $lightgray = "rgb({0},{1},{2})" -f [Color]::lightgray_def.r, [Color]::lightgray_def.g, [Color]::lightgray_def.b
static [string] $lightgreen = "rgb({0},{1},{2})" -f [Color]::lightgreen_def.r, [Color]::lightgreen_def.g, [Color]::lightgreen_def.b
static [string] $lightgrey = "rgb({0},{1},{2})" -f [Color]::lightgrey_def.r, [Color]::lightgrey_def.g, [Color]::lightgrey_def.b
static [string] $lightpink = "rgb({0},{1},{2})" -f [Color]::lightpink_def.r, [Color]::lightpink_def.g, [Color]::lightpink_def.b
static [string] $lightsalmon = "rgb({0},{1},{2})" -f [Color]::lightsalmon_def.r, [Color]::lightsalmon_def.g, [Color]::lightsalmon_def.b
static [string] $lightseagreen = "rgb({0},{1},{2})" -f [Color]::lightseagreen_def.r, [Color]::lightseagreen_def.g, [Color]::lightseagreen_def.b
static [string] $lightskyblue = "rgb({0},{1},{2})" -f [Color]::lightskyblue_def.r, [Color]::lightskyblue_def.g, [Color]::lightskyblue_def.b
static [string] $lightslategray = "rgb({0},{1},{2})" -f [Color]::lightslategray_def.r, [Color]::lightslategray_def.g, [Color]::lightslategray_def.b
static [string] $lightslategrey = "rgb({0},{1},{2})" -f [Color]::lightslategrey_def.r, [Color]::lightslategrey_def.g, [Color]::lightslategrey_def.b
static [string] $lightsteelblue = "rgb({0},{1},{2})" -f [Color]::lightsteelblue_def.r, [Color]::lightsteelblue_def.g, [Color]::lightsteelblue_def.b
static [string] $lightyellow = "rgb({0},{1},{2})" -f [Color]::lightyellow_def.r, [Color]::lightyellow_def.g, [Color]::lightyellow_def.b
static [string] $lime = "rgb({0},{1},{2})" -f [Color]::lime_def.r, [Color]::lime_def.g, [Color]::lime_def.b
static [string] $limegreen = "rgb({0},{1},{2})" -f [Color]::limegreen_def.r, [Color]::limegreen_def.g, [Color]::limegreen_def.b
static [string] $linen = "rgb({0},{1},{2})" -f [Color]::linen_def.r, [Color]::linen_def.g, [Color]::linen_def.b
static [string] $magenta = "rgb({0},{1},{2})" -f [Color]::magenta_def.r, [Color]::magenta_def.g, [Color]::magenta_def.b
static [string] $maroon = "rgb({0},{1},{2})" -f [Color]::maroon_def.r, [Color]::maroon_def.g, [Color]::maroon_def.b
static [string] $mediumaquamarine = "rgb({0},{1},{2})" -f [Color]::mediumaquamarine_def.r, [Color]::mediumaquamarine_def.g, [Color]::mediumaquamarine_def.b
static [string] $mediumblue = "rgb({0},{1},{2})" -f [Color]::mediumblue_def.r, [Color]::mediumblue_def.g, [Color]::mediumblue_def.b
static [string] $mediumorchid = "rgb({0},{1},{2})" -f [Color]::mediumorchid_def.r, [Color]::mediumorchid_def.g, [Color]::mediumorchid_def.b
static [string] $mediumpurple = "rgb({0},{1},{2})" -f [Color]::mediumpurple_def.r, [Color]::mediumpurple_def.g, [Color]::mediumpurple_def.b
static [string] $mediumseagreen = "rgb({0},{1},{2})" -f [Color]::mediumseagreen_def.r, [Color]::mediumseagreen_def.g, [Color]::mediumseagreen_def.b
static [string] $mediumslateblue = "rgb({0},{1},{2})" -f [Color]::mediumslateblue_def.r, [Color]::mediumslateblue_def.g, [Color]::mediumslateblue_def.b
static [string] $mediumspringgreen = "rgb({0},{1},{2})" -f [Color]::mediumspringgreen_def.r, [Color]::mediumspringgreen_def.g, [Color]::mediumspringgreen_def.b
static [string] $mediumturquoise = "rgb({0},{1},{2})" -f [Color]::mediumturquoise_def.r, [Color]::mediumturquoise_def.g, [Color]::mediumturquoise_def.b
static [string] $mediumvioletred = "rgb({0},{1},{2})" -f [Color]::mediumvioletred_def.r, [Color]::mediumvioletred_def.g, [Color]::mediumvioletred_def.b
static [string] $midnightblue = "rgb({0},{1},{2})" -f [Color]::midnightblue_def.r, [Color]::midnightblue_def.g, [Color]::midnightblue_def.b
static [string] $mintcream = "rgb({0},{1},{2})" -f [Color]::mintcream_def.r, [Color]::mintcream_def.g, [Color]::mintcream_def.b
static [string] $mistyrose = "rgb({0},{1},{2})" -f [Color]::mistyrose_def.r, [Color]::mistyrose_def.g, [Color]::mistyrose_def.b
static [string] $moccasin = "rgb({0},{1},{2})" -f [Color]::moccasin_def.r, [Color]::moccasin_def.g, [Color]::moccasin_def.b
static [string] $navajowhite = "rgb({0},{1},{2})" -f [Color]::navajowhite_def.r, [Color]::navajowhite_def.g, [Color]::navajowhite_def.b
static [string] $navy = "rgb({0},{1},{2})" -f [Color]::navy_def.r, [Color]::navy_def.g, [Color]::navy_def.b
static [string] $oldlace = "rgb({0},{1},{2})" -f [Color]::oldlace_def.r, [Color]::oldlace_def.g, [Color]::oldlace_def.b
static [string] $olive = "rgb({0},{1},{2})" -f [Color]::olive_def.r, [Color]::olive_def.g, [Color]::olive_def.b
static [string] $olivedrab = "rgb({0},{1},{2})" -f [Color]::olivedrab_def.r, [Color]::olivedrab_def.g, [Color]::olivedrab_def.b
static [string] $orange = "rgb({0},{1},{2})" -f [Color]::orange_def.r, [Color]::orange_def.g, [Color]::orange_def.b
static [string] $orangered = "rgb({0},{1},{2})" -f [Color]::orangered_def.r, [Color]::orangered_def.g, [Color]::orangered_def.b
static [string] $orchid = "rgb({0},{1},{2})" -f [Color]::orchid_def.r, [Color]::orchid_def.g, [Color]::orchid_def.b
static [string] $palegoldenrod = "rgb({0},{1},{2})" -f [Color]::palegoldenrod_def.r, [Color]::palegoldenrod_def.g, [Color]::palegoldenrod_def.b
static [string] $palegreen = "rgb({0},{1},{2})" -f [Color]::palegreen_def.r, [Color]::palegreen_def.g, [Color]::palegreen_def.b
static [string] $paleturquoise = "rgb({0},{1},{2})" -f [Color]::paleturquoise_def.r, [Color]::paleturquoise_def.g, [Color]::paleturquoise_def.b
static [string] $palevioletred = "rgb({0},{1},{2})" -f [Color]::palevioletred_def.r, [Color]::palevioletred_def.g, [Color]::palevioletred_def.b
static [string] $papayawhip = "rgb({0},{1},{2})" -f [Color]::papayawhip_def.r, [Color]::papayawhip_def.g, [Color]::papayawhip_def.b
static [string] $peachpuff = "rgb({0},{1},{2})" -f [Color]::peachpuff_def.r, [Color]::peachpuff_def.g, [Color]::peachpuff_def.b
static [string] $peru = "rgb({0},{1},{2})" -f [Color]::peru_def.r, [Color]::peru_def.g, [Color]::peru_def.b
static [string] $pink = "rgb({0},{1},{2})" -f [Color]::pink_def.r, [Color]::pink_def.g, [Color]::pink_def.b
static [string] $plum = "rgb({0},{1},{2})" -f [Color]::plum_def.r, [Color]::plum_def.g, [Color]::plum_def.b
static [string] $powderblue = "rgb({0},{1},{2})" -f [Color]::powderblue_def.r, [Color]::powderblue_def.g, [Color]::powderblue_def.b
static [string] $purple = "rgb({0},{1},{2})" -f [Color]::purple_def.r, [Color]::purple_def.g, [Color]::purple_def.b
static [string] $red = "rgb({0},{1},{2})" -f [Color]::red_def.r, [Color]::red_def.g, [Color]::red_def.b
static [string] $rosybrown = "rgb({0},{1},{2})" -f [Color]::rosybrown_def.r, [Color]::rosybrown_def.g, [Color]::rosybrown_def.b
static [string] $royalblue = "rgb({0},{1},{2})" -f [Color]::royalblue_def.r, [Color]::royalblue_def.g, [Color]::royalblue_def.b
static [string] $saddlebrown = "rgb({0},{1},{2})" -f [Color]::saddlebrown_def.r, [Color]::saddlebrown_def.g, [Color]::saddlebrown_def.b
static [string] $salmon = "rgb({0},{1},{2})" -f [Color]::salmon_def.r, [Color]::salmon_def.g, [Color]::salmon_def.b
static [string] $sandybrown = "rgb({0},{1},{2})" -f [Color]::sandybrown_def.r, [Color]::sandybrown_def.g, [Color]::sandybrown_def.b
static [string] $seagreen = "rgb({0},{1},{2})" -f [Color]::seagreen_def.r, [Color]::seagreen_def.g, [Color]::seagreen_def.b
static [string] $seashell = "rgb({0},{1},{2})" -f [Color]::seashell_def.r, [Color]::seashell_def.g, [Color]::seashell_def.b
static [string] $sienna = "rgb({0},{1},{2})" -f [Color]::sienna_def.r, [Color]::sienna_def.g, [Color]::sienna_def.b
static [string] $silver = "rgb({0},{1},{2})" -f [Color]::silver_def.r, [Color]::silver_def.g, [Color]::silver_def.b
static [string] $skyblue = "rgb({0},{1},{2})" -f [Color]::skyblue_def.r, [Color]::skyblue_def.g, [Color]::skyblue_def.b
static [string] $slateblue = "rgb({0},{1},{2})" -f [Color]::slateblue_def.r, [Color]::slateblue_def.g, [Color]::slateblue_def.b
static [string] $slategray = "rgb({0},{1},{2})" -f [Color]::slategray_def.r, [Color]::slategray_def.g, [Color]::slategray_def.b
static [string] $slategrey = "rgb({0},{1},{2})" -f [Color]::slategrey_def.r, [Color]::slategrey_def.g, [Color]::slategrey_def.b
static [string] $snow = "rgb({0},{1},{2})" -f [Color]::snow_def.r, [Color]::snow_def.g, [Color]::snow_def.b
static [string] $springgreen = "rgb({0},{1},{2})" -f [Color]::springgreen_def.r, [Color]::springgreen_def.g, [Color]::springgreen_def.b
static [string] $steelblue = "rgb({0},{1},{2})" -f [Color]::steelblue_def.r, [Color]::steelblue_def.g, [Color]::steelblue_def.b
static [string] $tan = "rgb({0},{1},{2})" -f [Color]::tan_def.r, [Color]::tan_def.g, [Color]::tan_def.b
static [string] $teal = "rgb({0},{1},{2})" -f [Color]::teal_def.r, [Color]::teal_def.g, [Color]::teal_def.b
static [string] $thistle = "rgb({0},{1},{2})" -f [Color]::thistle_def.r, [Color]::thistle_def.g, [Color]::thistle_def.b
static [string] $tomato = "rgb({0},{1},{2})" -f [Color]::tomato_def.r, [Color]::tomato_def.g, [Color]::tomato_def.b
static [string] $turquoise = "rgb({0},{1},{2})" -f [Color]::turquoise_def.r, [Color]::turquoise_def.g, [Color]::turquoise_def.b
static [string] $violet = "rgb({0},{1},{2})" -f [Color]::violet_def.r, [Color]::violet_def.g, [Color]::violet_def.b
static [string] $wheat = "rgb({0},{1},{2})" -f [Color]::wheat_def.r, [Color]::wheat_def.g, [Color]::wheat_def.b
static [string] $white = "rgb({0},{1},{2})" -f [Color]::white_def.r, [Color]::white_def.g, [Color]::white_def.b
static [string] $whitesmoke = "rgb({0},{1},{2})" -f [Color]::whitesmoke_def.r, [Color]::whitesmoke_def.g, [Color]::whitesmoke_def.b
static [string] $yellow = "rgb({0},{1},{2})" -f [Color]::yellow_def.r, [Color]::yellow_def.g, [Color]::yellow_def.b
static [string] $yellowgreen = "rgb({0},{1},{2})" -f [Color]::yellowgreen_def.r, [Color]::yellowgreen_def.g, [Color]::yellowgreen_def.b

static [string[]]$colornames = ([Color].GetProperties()  | Where-Object { $_.PropertyType.ToString() -EQ 'System.String'} | Select -Expand Name)

#logic from http://www.niwa.nu/2013/05/math-behind-colorspace-conversions-rgb-hsl/
static [string] hslcalc([int]$r, [int]$g, [int]$b, [double]$a) {
    $rc = [Math]::Round($r/255,2)
    $bc = [Math]::Round($b/255,2)
    $gc = [Math]::Round($g/255,2)

    $h = 0

    $m = $rc,$bc,$gc | Measure-Object -Maximum -Minimum
    $m

    $l = [Math]::Round(($m.Maximum + $m.Minimum)/2,2)
    Write-Verbose "L: $l"

    if ($m.Maximum -eq $m.Minimum) {
        $s = 0
    }
    else {
        if ($l -le 0.5) {
            $s = ($m.Maximum - $m.Minimum)/($m.Maximum + $m.Minimum)
        }
        else {
            $s = ($m.Maximum - $m.Minimum)/(2 - $m.Maximum - $m.Minimum)
        }
    }
    Write-Verbose "S: $s"

    if ($s -eq 0) {
        $h = 0
    }
    else {
        if ($rc -eq $m.Maximum) {
            $h =  ($gc-$bc)/($m.Maximum-$m.Minimum)
        }

        if ($gc -eq $m.Maximum) {
            $h =  2 + ($bc-$rc)/($m.Maximum-$m.Minimum)
        }

        if ($bc -eq $m.Maximum) {
            $h =  4 + ($rc-$gc)/($m.Maximum-$m.Minimum)  
        }

        if ($h -lt 0) {
            $h+= 360
        }

        $h = $h * 60
    }
    Write-Verbose "H: $h"
    
    if ($a -le 1) {
        return "hsla({0},{1:p0},{2:p0},{3})" -f [Math]::Round($h), [Math]::Round($s,2), $l, $a
    }
    else {
        $value = "hsl({0},{1:p0},{2:p0})" -f [Math]::Round($h), [Math]::Round($s,2), $l
        #on macOS, output is like this: hsl(240,100 %,50 %)
        $return = $value.Replace(" ","")
        return $return
        
    }
}

static [string] hex([int]$r,[int]$g,[int]$b){ 
    return "#{0:X2}{1:X2}{2:X2}" -f $r,$g,$b ;
}

static [string] hsl([int]$r,[int]$g,[int]$b){ 
    return [Color]::hslcalc($r, $g, $b, 9) ;
}

static [string] hsla([int]$r,[int]$g,[int]$b, [double] $a){ 
    return [Color]::hslcalc($r, $g, $b, $a) ;
}

    static [string] rgb([int]$r,[int]$g,[int]$b){
        return "rgb({0},{1},{2})" -f $r,$g,$b
    }
    static [string] rgba([int]$r,[int]$g,[int]$b,[double]$a){
        return "rgba({0},{1},{2},{3})" -f $r,$g,$b,$a
    }
}


#region dataSet
Class dataSet {
    [System.Collections.ArrayList] $data = @()
    [Array]$label

    dataSet(){
       
    }

    dataset([Array]$Data,[Array]$Label){
        
        if ( @( $Label ).Count -eq 1 ) {
            $this.SetLabel($Label)
        }
        else {
            foreach($l in $Label){
                $this.AddLabel($l)
            }
        }
        foreach($d in $data){
            $this.AddData($d)
        }
        
        
    }

    [void]AddLabel([Array]$Label){
        foreach($L in $Label){
            $null = $this.Label.Add($L)
        }
    }
    
    [void]SetLabel([String]$Label){
        $this.label = $Label
    }
    

    [void]AddData([Array]$Data){
        foreach($D in $Data){
            $null = $this.data.Add($d)
        }
    }
}

Class datasetbar : dataset {
    [String] $xAxisID
    [String] $yAxisID
    [string]  $backgroundColor
    [string]  $borderColor
    [int]    $borderWidth = 1
    [String] $borderSkipped
    [string]  $hoverBackgroundColor
    [string]  $hoverBorderColor
    [int]    $hoverBorderWidth

    datasetbar(){
       
    }

    datasetbar([Array]$Data,[Array]$Label){
        
        $this.SetLabel($Label)
        $this.AddData($Data)
        
    }
}

Class datasetPolarArea : dataset {
    [Array]  $backgroundColor
    [Array]  $borderColor
    [int]    $borderWidth = 1
    [String] $borderSkipped
    [Array]  $hoverBackgroundColor
    [Array]  $hoverBorderColor
    [int]    $hoverBorderWidth

    datasetPolarArea(){
    
    }

    datasetPolarArea([Array]$Data,[Array]$Label){
        if ( @( $Label ).Count -gt 1 ) {
            $this.AddLabel($Label)
        }
        else {
            $this.SetLabel( @( $Label)[0] )
        }
        $this.AddData($Data)
        
    }
}


Class datasetline : dataset{
    #See https://www.chartjs.org/docs/latest/charts/line.html
    #[String] $xAxisID
    #[String] $yAxisID

    [String]  $backgroundColor
    [String]  $borderColor
    [int]    $borderWidth = 1
    [int[]]    $borderDash = 0
    [int]    $borderDashOffSet = 0

    [ValidateSet("butt","round","square")]
    [String]    $borderCapStyle

    [ValidateSet("bevel","round","miter")]
    [String]    $borderJoinStyle

    [ValidateSet("default","monotone")]
    [String] $cubicInterpolationMode = "default"
    [Bool] $fill = $false
    [double]$lineTension = 0.5 #Stepped line should not be present, for this one to work.
    
    $pointBackgroundColor = "rgb(255,255,255)"
    $pointBorderColor = "rgb(0,0,0)"
    [Int[]]$pointBorderWidth = 1
    [float]$pointRadius = 4
    [ValidateSet("circle","cross","crossRot","dash","line","rect","rectRounded","rectRot","star","triangle")]
    $pointStyle = "circle"

    [int[]]$pointRotation
    [float]$pointHitRadius

    [String]  $PointHoverBackgroundColor
    [String]  $pointHoverBorderColor
    [int]    $pointHoverBorderWidth
    [float] $pointHoverRadius
    [bool]$showLine = $true
    [bool]$spanGaps

    #[ValidateSet("true","false","before","after")]
    #[String] $steppedLine = 'false' #Had to remove it, otherwise lines could not be rounded. It would ignore the $LineTension settings, even when set to false

    datasetline(){

    }

    datasetline([Array]$Data,[String]$Label){
        Write-verbose "[DatasetLine][Instanciation]Start"
        $this.SetLabel($Label)
        $this.AddData($Data)
        Write-verbose "[DatasetLine][Instanciation]End"
    }

    SetLineColor([String]$Color,[Bool]$Fill){
        Write-verbose "[DatasetLine][SetLineColor] Start"
        $this.borderColor = $Color
        $this.backgroundColor = $Color
        if($Fill){
           $this.SetLineBackGroundColor($Color)
        }
        Write-verbose "[DatasetLine][SetLineColor] End"
    }

    SetLineBackGroundColor(){
        Write-verbose "[DatasetLine][SetLineBackGroundColor] Start"
        #Without any color parameter, this will take the existing line color, and simply add 0.4 of alpha to it for the background color
        if(!($this.borderColor)){
            $t = $this.borderColor
            $this.fill = $true
            $t = $t.replace("rgb","rgba")
            $backgroundC = $t.replace(")",",0.4)")
            $this.backgroundColor = $backgroundC
        }
        Write-verbose "[DatasetLine][SetLineBackGroundColor] End"
    }

    SetLineBackGroundColor([String]$Color){
        #this will take the color, and add 0.4 of alpha to it for the background color
        Write-verbose "[DatasetLine][SetLineBackGroundColor] Start"
        $this.fill = $true
        $t = $Color
        $t = $t.replace("rgb","rgba")
        $backgroundC = $t.replace(")",",0.4)")
        $this.backgroundColor = $backgroundC
        Write-verbose "[DatasetLine][SetLineBackGroundColor] End"
    }

    SetPointSettings([float]$pointRadius,[float]$pointHitRadius,[float]$pointHoverRadius){
        Write-Verbose "[DatasetLine][SetPointSettings] Start"
        $this.pointRadius = $pointRadius
        $this.pointHitRadius = $pointHitRadius
        $this.pointHoverRadius = $pointHoverRadius
        Write-Verbose "[DatasetLine][SetPointSettings] End"
    }

    [hashtable]GetPointSettings(){
        Write-Verbose "[DatasetLine][GetPointSettings] Start"
        return @{
            PointRadius = $this.pointRadius
            PointHitRadius = $this.pointHitRadius
            PointHoverRadius = $this.pointHoverRadius
        }
        Write-Verbose "[DatasetLine][GetPointSettings] End"
    }
}


Class datasetpie : dataset {


    [System.Collections.ArrayList]$backgroundColor
    [String]$borderColor = "white"
    [int]$borderWidth = 1
    [System.Collections.ArrayList]$hoverBackgroundColor
    [Color]$HoverBorderColor
    [int]$HoverBorderWidth

    datasetpie(){

    }

    datasetpie([Array]$Data,[String]$ChartLabel){
        Write-verbose "[DatasetPie][Instanciation]Start"
        $this.SetLabel($ChartLabel)
        $this.AddData($Data)
        Write-verbose "[DatasetPie][Instanciation]End"
    }

    AddBackGroundColor($Color){
        if($null -eq $this.backgroundColor){
            $this.backgroundColor = @()
        }
        $this.backgroundColor.Add($Color)
    }

    AddBackGroundColor([Array]$Colors){
        
        foreach($c in $Colors){
            $this.AddBackGroundColor($c)
        }
        
    }

    AddHoverBackGroundColor($Color){
        if($null -eq $this.HoverbackgroundColor){
            $this.HoverbackgroundColor = @()
        }
        $this.HoverbackgroundColor.Add($Color)
    }

    AddHoverBackGroundColor([Array]$Colors){
        foreach($c in $Colors){
            $this.AddHoverBackGroundColor($c)
        }
        
    }

}

Class datasetDoughnut : dataset {

    [System.Collections.ArrayList]$backgroundColor
    [String]$borderColor = "white"
    [int]$borderWidth = 1
    [System.Collections.ArrayList]$hoverBackgroundColor
    [Color]$HoverBorderColor
    [int]$HoverBorderWidth

    datasetDoughnut(){

    }

    datasetDoughnut([Array]$Data,[String]$ChartLabel){
        Write-verbose "[DatasetDoughnut][Instanciation]Start"
        $this.SetLabel($ChartLabel)
        $this.AddData($Data)
        Write-verbose "[DatasetDoughnut][Instanciation]End"
    }

    AddBackGroundColor($Color){
        if($null -eq $this.backgroundColor){
            $this.backgroundColor = @()
        }
        $this.backgroundColor.Add($Color)
    }

    AddBackGroundColor([Array]$Colors){
        
        foreach($c in $Colors){
            $this.AddBackGroundColor($c)
        }
        
    }

    AddHoverBackGroundColor($Color){
        if($null -eq $this.HoverbackgroundColor){
            $this.HoverbackgroundColor = @()
        }
        $this.HoverbackgroundColor.Add($Color)
    }

    AddHoverBackGroundColor([Array]$Colors){
        foreach($c in $Colors){
            $this.AddHoverBackGroundColor($c)
        }
        
    }

}

#endregion


#region Configuration&Options

Class scales {
    [System.Collections.ArrayList]$yAxes = @()
    [System.Collections.ArrayList]$xAxes = @("")

    scales(){

        $null =$this.yAxes.Add(@{"ticks"=@{"beginAtZero"=$true}})
    }
}

Class ChartTitle {
    [Bool]$display=$false
    [String]$text
}

Class ChartAnimation {
    $onComplete = $null
}

Class ChartOptions  {
    # [int]$barPercentage = 0.9
    [Int]$categoryPercentage = 0.8
    [bool]$responsive = $false
    # [String]$barThickness
    # [Int]$maxBarThickness
    [Bool] $offsetGridLines = $true
    [scales]$scales = [scales]::New()
    [ChartTitle]$title = [ChartTitle]::New()
    [ChartAnimation]$animation = [ChartAnimation]::New()

    <#
        elements: {
						rectangle: {
							borderWidth: 2,
						}
					},
					responsive: true,
					legend: {
						position: 'right',
					},
					title: {
						display: true,
						text: 'Chart.js Horizontal Bar Chart'
					}
    #>
}

#endregion

#region Charts

Class BarChartOptions : ChartOptions {
    [int]$barPercentage = 0.9
    [String]$barThickness
    [Int]$maxBarThickness

}

Class horizontalBarChartOptions : ChartOptions {

}

Class PieChartOptions : ChartOptions {

}

Class LineChartOptions : ChartOptions {
    [Bool] $showLines = $True
    [Bool] $spanGaps = $False
}

Class DoughnutChartOptions : ChartOptions {
    
}

Class RadarChartOptions : ChartOptions {
    [scales]$scales = $null
}

Class polarAreaChartOptions : ChartOptions {
    [scales]$scales = $null
}

Class ChartData {
    [System.Collections.ArrayList] $labels = @()
    [System.Collections.ArrayList] $datasets = @()
    #[DataSet[]] $datasets = [dataSet]::New()

    ChartData(){
        #$this.datasets = [dataSet]::New()
        $this.datasets.add([dataSet]::New())
    }

    AddDataSet([DataSet]$Dataset){
        #$this.datasets += $Dataset
        $this.datasets.Add($Dataset)
    }

    SetLabels([Array]$Labels){
        Foreach($l in $Labels){

            $Null = $this.labels.Add($l)
        }
    }

}

Class BarData : ChartData {
    
    
}

Class Chart {
    [ChartType]$type
    [ChartData]$data
    [ChartOptions]$options
    Hidden [String]$definition

    Chart(){
        $Currenttype = $this.GetType()

        if ($Currenttype -eq [Chart])
        {
            throw("Class $($Currenttype) must be inherited")
        }
    }

    SetData([ChartData]$Data){
        $this.Data = $Data
    }

    SetOptions([ChartOptions]$Options){
        $this.Options = $Options
    }

    #Is this actually used? Could be removed?
    hidden [void] BuildDefinition(){
        $This.GetDefinitionStart()
        $This.GetDefinitionBody()
        $This.GetDefinitionEnd()
        #Do stuff with $DEfinition
    }

    Hidden [String]GetDefinitionStart([String]$CanvasID){
<#

$Start = @"
var ctx = document.getElementById("$($CanvasID)").getContext('2d');
var myChart = new Chart(ctx, 
"@
#>
$Start = "var ctx = document.getElementById(`"$($CanvasID)`").getContext('2d');"
$Start = $Start + [Environment]::NewLine
$Start = $Start + "var myChart = new Chart(ctx, "
    return $Start
    }

    Hidden [String]GetDefinitionEnd(){
        Return ");"
    }

    Hidden [String]GetDefinitionBody(){
        
        ##Graph Structure
            #Type
            #Data
                #Labels[]
                #DataSets[]
                    #Label
                    #Data[]
                    #BackGroundColor[]
                    #BorderColor[]
                    #BorderWidth int
            #Options
                #Scales
                    #yAxes []
                        #Ticks
                            #beginAtZero [bool]
                            
        $Body = $this | select @{N='type';E={$_.type.ToString()}},Data,Options  | convertto-Json -Depth 6 -Compress
        $BodyCleaned =  Clear-WhiteSpace $Body
        Return $BodyCleaned
    }

    [String] GetDefinition([String]$CanvasID){
        
        $FullDefintion = [System.Text.StringBuilder]::new()
        $FullDefintion.Append($this.GetDefinitionStart([String]$CanvasID))
        $FullDefintion.AppendLine($this.GetDefinitionBody())
        $FullDefintion.AppendLine($this.GetDefinitionEnd())
        $FullDefintionCleaned = Clear-WhiteSpace $FullDefintion
        return $FullDefintionCleaned
    }

    [String] GetDefinition([String]$CanvasID,[Bool]$ToBase64){
        
        $FullDefintion = [System.Text.StringBuilder]::new()
        $FullDefintion.Append($this.GetDefinitionStart([String]$CanvasID))
        $FullDefintion.AppendLine($this.GetDefinitionBody())
        $FullDefintion.AppendLine($this.GetDefinitionEnd())
        $FullDefintion.AppendLine("function RemoveCanvasAndCreateBase64Image (){")
        $FullDefintion.AppendLine("var base64 = this.toBase64Image();")
        $FullDefintion.AppendLine("var element = this.canvas;")
        $FullDefintion.AppendLine("var parent = element.parentNode;")
        $FullDefintion.AppendLine("var img = document.createElement('img');")
        $FullDefintion.AppendLine("img.src = base64;")
        $FullDefintion.AppendLine("img.name = element.id;")
        $FullDefintion.AppendLine("element.before(img);")
        $FullDefintion.AppendLine("parent.removeChild(element);")
        $FullDefintion.AppendLine("document.getElementById('pshtml_script_chart_$canvasid').parentNode.removeChild(document.getElementById('pshtml_script_chart_$canvasid'))")
        $FullDefintion.AppendLine("};")
        $FullDefintion.replace('"RemoveCanvasAndCreateBase64Image"','RemoveCanvasAndCreateBase64Image')
        
        <# somewhere along the line, we will need to remove script tags associated to the charts creation ... in order to send it to mail
        //var scripttags = document.getElementsByTagName('script');
        //var scripttags = document.getElementsByTagName('script');
        //for (i=0;i<scripttags.length;){
        //    var parent = scripttags[i].parentNode;
        //    parent.removeChild(scripttags[i]);
        //}
        };
        #>
        $FullDefintionCleaned = Clear-WhiteSpace $FullDefintion
        return $FullDefintionCleaned
    }
}

Class BarChart : Chart{

    [ChartType] $type = [ChartType]::bar
    
    BarChart(){
        #$Type = [ChartType]::bar

    }

    BarChart([ChartData]$Data,[ChartOptions]$Options){
        $this.data = $Data
        $This.options = $Options
    }

}

Class horizontalBarChart : Chart{

    [ChartType] $type = [ChartType]::horizontalBar
    
    horizontalBarChart(){
        #$Type = [ChartType]::bar

    }

    horizontalBarChart([ChartData]$Data,[ChartOptions]$Options){
        $this.data = $Data
        $This.options = $Options
    }

}

Class LineChart : Chart{

    [ChartType] $type = [ChartType]::line
    
    LineChart(){
        #$Type = [ChartType]::bar

    }

    LineChart([ChartData]$Data,[ChartOptions]$Options){
        $this.data = $Data
        $This.options = $Options
    }

}

Class PieChart : Chart{

    [ChartType] $type = [ChartType]::pie
    
    PieChart(){
        

    }

    PieChart([ChartData]$Data,[ChartOptions]$Options){
        $this.data = $Data
        $This.options = $Options
    }

}

Class doughnutChart : Chart {
    [ChartType] $type = [ChartType]::doughnut
    
    DoughnutChart(){
        
    }

    DoughnutChart([ChartData]$Data,[ChartOptions]$Options){
        $this.data = $Data
        $This.options = $Options
    }
}

Class RadarChart : Chart{

    [ChartType] $type = [ChartType]::radar
    
    RadarChart(){
        #$Type = [ChartType]::bar

    }

    RadarChart([ChartData]$Data,[ChartOptions]$Options){
        $this.data = $Data
        $This.options = $Options
    }

}

Class polarAreaChart : Chart{

    [ChartType] $type = [ChartType]::polarArea
    
    polarAreaChart(){
        #$Type = [ChartType]::bar

    }

    polarAreaChart([ChartData]$Data,[ChartOptions]$Options){
        $this.data = $Data
        $This.options = $Options
    }

}




#endregion


Class IncludeFile {

}

Class Include : IncludeFile {
    [String]$Name
    [System.IO.DirectoryInfo]$FolderPath
    [System.IO.FileInfo]$FilePath

    Include([System.IO.FileInfo]$FilePath){
        $this.FilePath = $FilePath
        $this.FolderPath = $FilePath.Directory
        $this.Name = $FilePath.BaseName
    }

    [String]ToString(){

        $Rawcontent = [IO.File]::ReadAllText($this.FilePath.FullName)
        $Content = [scriptBlock]::Create($Rawcontent).Invoke()
        return $content

    }
}

Class IncludeFactory {
    
    Static [Include[]] Create([System.IO.DirectoryInfo]$Path){
        If(test-Path $Path){

            $Items = Get-ChildItem $Path.FullName -Filter "*.ps1"
            $AllIncludes = @()
            Foreach($Item in $Items){
                $AllIncludes += [Include]::New($Item)
                
            }
    
            Return $AllIncludes
        }Else{
            Return $null
        }
    }
}

#From Jakub Jares (Thanks!)
function Clear-WhiteSpace ($Text) {
    "$($Text -replace "(`t|`n|`r)"," " -replace "\s+"," ")".Trim()
}
Function Get-HTMLTemplate{
    <#
        .Example



html{
    Body{

        include -name body

    }
    Footer{
        Include -Name Footer
    }
}

#Generates the following HTML code

        <html>
            <body>

            h2 "This comes a template file"
            </body>
            <footer>
            div {
                h4 "This is the footer from a template"
                p{
                    CopyRight from template
                }
            }
            </footer>
        </html>
    #>
    [CmdletBinding()]
    Param(
        $Name
    )

    Throw "This function has been renamed to 'Get-PSHTMLTemplate' and will be removed in a future release .Either use the Alias 'include' or rename your function calls from Get-PSHTMLTemplate to Get-PSHTMLTemplate"
}
Function Get-LogfilePath{
    return $Script:Logfile
}
Function Get-ModuleRoot {
    [CmdletBinding()]
    Param(
        )
        return $MyInvocation.MyCommand.Module.ModuleBase
}
Function Set-HtmlTag {
    <#
    .Synopsis
        This function is the base function for all the html elements in pshtml.

    .Description
        although it can be this function is not intended to be used directly.
    .EXAMPLE
    Set-HtmlTag -TagName div -PSBParameters $PSBoundParameters -MyCParametersKeys $MyInvocation.MyCommand.Parameters.Keys

    .EXAMPLE
    Set-HtmlTag -TagName style -PSBParameters $PSBoundParameters -MyCParametersKeys $MyInvocation.MyCommand.Parameters.Keys

    .NOTES
    Current version 3.1
        History:
            2018.10.24;@ChristopheKumor;include tag parameters to version 3.0
            2018.05.07;stephanevg;
            2018.05.07;stephanevg;Creation
    #>
    [Cmdletbinding()]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSProvideCommentHelp", "", Justification = "Manipulation of text")]
    Param(

        [Parameter(Mandatory=$True)]
        $TagName,

        [Parameter(Mandatory=$True)]
        $Parameters,

        [Parameter(Mandatory=$true)]
        [ValidateSet('void', 'NonVoid')]
        $TagType,

        [Parameter(Mandatory=$False)]
        $Content
    )

    Begin {

        Function GetCustomParameters {
            [CmdletBinding()]
            Param(
                [HashTable]$Parameters
            )
    
            $CommonParameters = [System.Management.Automation.PSCmdlet]::CommonParameters + [System.Management.Automation.PSCmdlet]::OptionalCommonParameters
            $CleanedHash = @{}
            foreach($key in $Parameters.Keys){
                if(!($key -in $CommonParameters)){
                    $CleanedHash.$Key = $Parameters[$key]
                }
            }
            if(!($CleanedHash)){
                write-verbose "[GetCustomParameters] No custom parameters passed."
            }
            Return $cleanedHash
    }
        $CommonParameters = [System.Management.Automation.PSCmdlet]::CommonParameters + [System.Management.Automation.PSCmdlet]::OptionalCommonParameters
    }
    Process {
        $attr = $output = ''
        $outcontent = ''

        $AttributesToSkip = "Content","Attributes","httpequiv","content_tag"


        $Attributes = GetCustomParameters -parameters $Parameters


        $KeysToPostProcess = @()
        foreach ($key in $Attributes.Keys) {
            if($key -notin $AttributesToSkip){

                $attr += '{0}="{1}" ' -f $key, $Attributes[$key]
            }else{
                $KeysToPostProcess += $Key 
            }
        }

        

        foreach($PostKey in $KeysToPostProcess){

            switch ($PostKey) {
                'Content' { 
                    if ($Parameters[$($PostKey)] -is [System.Management.Automation.ScriptBlock]) {
                        $outcontent = $Parameters[$($PostKey)].Invoke()
                        break
                    }
                    else {
                        $outcontent = $Parameters[$($PostKey)]
                        break
                    }
                }
                'Attributes' { 
    
                    foreach ($entry in $Parameters['Attributes'].Keys) {
                        if ($entry -eq 'content' -or $entry -eq 'Attributes') {
                            write-verbose "[Set-HTMLTAG] attribute $($entry) is a reserved value, and should not be passed in the Attributes HashTable"
                            continue
                        }
                        $attr += '{0}="{1}" ' -f $entry, $Parameters['Attributes'].$entry
                    }

                    continue
                }
                'httpequiv' {
                    $attr += 'http-equiv="{0}" ' -f $Parameters[$PostKey]
                    continue
                }
                'content_tag' {
                    $attr += 'content="{0}" ' -f $Parameters[$PostKey]
                    continue
                }
                default { 
                
                    write-verbose "[SET-HTMLTAG] Not found"
    
                }
            }
        }




    #Generating OutPut string
        #$TagBegin - TagAttributes - <TagContent> - TagEnd
        

        $TagBegin = '<{0}' -f $TagName

    
        if($tagType -eq 'nonvoid'){
            $ClosingFirstTag = ">"
            $TagEnd = '</{0}>' -f $tagname
        }else{
            $ClosingFirstTag = "/>"
        }
        
        
        if($attr){

            $TagAttributes = ' {0} {1} ' -f  $attr,$ClosingFirstTag
        }else{
            $TagAttributes = ' {0}' -f  $ClosingFirstTag
        }

        #Fix to avoid a additional space before the content
        $TagAttributes = $TagAttributes.TrimEnd(" ")
    
        if($null -ne $outcontent){

            $TagContent = -join $outcontent 
        }

        $Data = $TagBegin + $TagAttributes + $TagContent + $TagEnd


        return $Data

    }
}
function Write-Error {
    <#
        .SYNOPSIS
            Proxy function for Write-Error that adds a timestamp and write the message to a log file.
    #>
        [CmdletBinding()]
        param (
            [Parameter(ValueFromPipeline, ValueFromPipelineByPropertyName)]
            [AllowNull()]
            [System.String] $Message
        )
        process {
    
            if (-not [System.String]::IsNullOrEmpty($Message)) {
    
                #$Message = Get-FormattedMessage -Message $Message;
                $Type = 'Error'
                $Msgobj = [LogMessage]::new($Message,$Type)
                $FormatedMessage = $Msgobj.ToString()
                Write-PSHTMLLog -message $FormatedMessage -type $Type
                #Microsoft.PowerShell.Utility\Write-Error -Message $FormatedMessage;
                #Overwriting Write-Error would not display message. See https://stackoverflow.com/questions/4998173/how-do-i-write-to-standard-error-in-powershell
                $host.ui.WriteErrorLine($FormatedMessage)
            }
    
        } # end process
    } #end function
Function Write-PSHTMLLog {
    [Cmdletbinding()]
    Param(
        [String]$Message,

        [ValidateSet("Info","Warning","Error","Information")]
        [String]$Type = "info"
    )

    
    $Script:Logger.Log($Message)


}
function Write-Verbose {
    <#
        .SYNOPSIS
            Proxy function for Write-verbose that adds a timestamp and write the message to a log file.
    #>
        [CmdletBinding()]
        param (
            [Parameter(ValueFromPipeline, ValueFromPipelineByPropertyName)]
            [AllowNull()]
            [System.String] $Message
        )
        process {
    
            if (-not [System.String]::IsNullOrEmpty($Message)) {
    
                #$Message = Get-FormattedMessage -Message $Message;
                $Type = 'Information'
                $Msgobj = [LogMessage]::new($Message,$Type)
                $FormatedMessage = $Msgobj.ToString()
                Write-PSHTMLLog -message $FormatedMessage -type $Type
                Microsoft.PowerShell.Utility\Write-Verbose -Message $FormatedMessage;
            }
    
        } # end process
    } #end function
function Write-Warning {
    <#
        .SYNOPSIS
            Proxy function for Write-Warning that adds a timestamp and write the message to a log file.
    #>
        [CmdletBinding()]
        param (
            [Parameter(ValueFromPipeline, ValueFromPipelineByPropertyName)]
            [AllowNull()]
            [System.String] $Message
        )
        process {
    
            if (-not [System.String]::IsNullOrEmpty($Message)) {
    
                #$Message = Get-FormattedMessage -Message $Message;
                $Type = 'Warning'
                $Msgobj = [LogMessage]::new($Message,$Type)
                $FormatedMessage = $Msgobj.ToString()
                Write-PSHTMLLog -message $FormatedMessage -type $Type
                Microsoft.PowerShell.Utility\Write-Warning -Message $FormatedMessage;
            }
    
        } # end process
    } #end function
Function a {
    <#
        .SYNOPSIS

        Generates a <a> HTML tag.
        The <a> tag defines a hyperlink, which is used to link from one page to another.
        
        .DESCRIPTION

        The most important attribute of the <a> element is the href attribute, which indicates the link's destination.

        .PARAMETER HREF
            Specify where the link should point to (Destination).

        .PARAMETER TARGET
        
        Specify where the new page should open to.
        
        Should be one of the following values:
        "_self","_blank","_parent","_top"


        .PARAMETER Class
        Allows to specify one (or more) class(es) to assign the html element.
        More then one class can be assigned by seperating them with a white space.

        .PARAMETER Id
        Allows to specify an id to assign the html element.

        .PARAMETER Style
        Allows to specify in line CSS style to assign the html element.

        .PARAMETER Content
        Allows to add child element(s) inside the current opening and closing HTML tag(s).


        .EXAMPLE
        The following exapmles show cases how to create an empty a, with a class, an ID, and, custom attributes.
        
        a -Class "myclass1 MyClass2" -Id myid -Attributes @{"custom1"='val1';custom2='val2'}

        Generates the following code:

        <a Class="myclass1 MyClass2" Id="myid" custom1="val1" custom2="val2"  >
        </a>


        .NOTES
        Current version 3.1
        History:
            2018.10.30;@Stephanevg;Updated to version 3.1
            2018.10.30;@ChristopheKumor;Updated to version 3.0
            2018.09.30;Stephanevg;Updated to version 2.0
            2018.04.10;Stephanevg; Added parameters
            2018.04.01;Stephanevg;Creation.
        .LINK
            https://github.com/Stephanevg/PSHTML
    #>

    Param(

        [Parameter(Mandatory = $false)]
        [AllowEmptyString()]
        [AllowNull()]
        $Content,

        [Parameter(Mandatory = $true)]
        [String]$href,

        [ValidateSet("_self", "_blank", "_parent", "_top")]
        [String]$Target,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class,

        [String]$Id,
        
        [String]$Style,

        [Hashtable]$Attributes

    )
    $tagname = "a"

    if(!($Target)){
          
        $PSBoundParameters.Target = "_self"
    }

    Set-htmltag -TagName $tagName -Parameters $PSBoundParameters -TagType NonVoid
    
    

}
 
Function address {
    <#
    .SYNOPSIS

    Generates <address> HTML tag.
    
    
    .DESCRIPTION
    The <address> tag defines the contact information for the author/owner of a document or an article.

    If the <address> element is inside the <body> element, it represents contact information for the document.

    If the <address> element is inside an <article> element, it represents contact information for that article.

    The text in the <address> element usually renders in italic. Most browsers will add a line break before and after the address element.


    .PARAMETER Class
    Allows to specify one (or more) class(es) to assign the html element.
    More then one class can be assigned by seperating them with a white space.

    .PARAMETER Id
    Allows to specify an id to assign the html element.

    .PARAMETER Style
    Allows to specify in line CSS style to assign the html element.

    .PARAMETER Content
    Allows to add child element(s) inside the current opening and closing HTML tag(s).


    .EXAMPLE

    address {
        $twitterLink = a -href "http://twitter/stephanevg" -Target _blank -Content {"@stephanevg"}
        $bloglink = a -href "http://www.powershelldistrict.com" -Target _blank -Content {"www.powershelldistrict.com"}
        "written by: Stephane van Gulick"
        "blog: $($bloglink)";
        "twitter: $($twitterLink)"
    }

    Generates the following code:

    <address>
        written by: Stephane van Gulick
        blog: <a href=http://www.powershelldistrict.com target="_blank" > www.powershelldistrict.com </a>
        twitter: <a href=http://twitter/stephanevg target="_blank" > @stephanevg </a>
    </address>

    .NOTES
     Current version 3.1
        History:
            2018.11.08;Stephanevg; Updated to version 3.1
            2018.10.30;@ChristopheKumor;Updated to version 3.0
            2018.09.30;Stephanevg; Updated to version 2.0
            2018.04.10;Stephanevg; Added parameters
            2018.04.01;Stephanevg;Creation.
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [CmdletBinding()]
    Param(

        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $false,
            Position = 0
        )]
        $Content,

        [Parameter(Position = 1)]
        [String]$Class,

        [Parameter(Position = 2)]
        [String]$Id,

        [Parameter(Position = 3)]
        [String]$Style,

        [Parameter(Position = 4)]
        [Hashtable]$Attributes
    )
    Process {

        $tagname = "address"

        Set-htmltag -TagName $tagName -Parameters $PSBoundParameters -TagType NonVoid

    }


}
Function area {
    <#
    .SYNOPSIS
    Generates <area> HTML tag.

    .DESCRIPTION
    The are tag must be used in a <map> element (Use the 'map' function)

    The <area> element is always nested inside a <map> tag.

    More information can be found here --> https://www.w3schools.com/tags/tag_area.asp


    .PARAMETER Class
    Allows to specify one (or more) class(es) to assign the html element.
    More then one class can be assigned by seperating them with a white space.

    .PARAMETER Id
    Allows to specify an id to assign the html element.

    .PARAMETER Style
    Allows to specify in line CSS style to assign the html element.

    .PARAMETER Content
    Allows to add child element(s) inside the current opening and closing HTML tag(s).


    .EXAMPLE
    area -href "link.php" -alt "alternate description" -coords "0,0,10,10"

   Generates the following code:

    <area href="link.php" alt="alternate description" coords="0,0,10,10" >

    .EXAMPLE
    area -href image.png -coords "0,0,20,20" -shape rect

    Generates the following code:

    <area href="image.png"coords="0,0,20,20"shape="rect" >

    .NOTES
     Current version 3.1
        History:
            2018.11.08;Stephanevg; Updated to version 3.1
            2018.10.30;@ChristopheKumor;Updated to version 3.0
            2018.04.10;Stephanevg; Added parameters
            2018.04.01;Stephanevg;Creation.
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [CmdletBinding()]
    Param(


        [Parameter(Position = 0)]
        [String]$href,

        [Parameter(Position = 1)]
        [String]$alt,

        [Parameter(Position = 2)]
        [String]$coords,

        [Parameter(Position = 3)]
        [validateset("default", "rect", "circle", "poly")]
        [String]$shape,

        [Parameter(Mandatory = $false, Position = 4)]
        [ValidateSet("_blank", "_self", "_parent", "top")]
        [String]$target,

        [Parameter(Position = 5)]
        [String]$type,

        [Parameter(Position = 6)]
        [String]$Class,

        [Parameter(Position = 7)]
        [String]$Id,

        [Parameter(Position = 8)]
        [String]$Style,

        [Parameter(Position = 9)]
        [Hashtable]$Attributes


    )
    Process {

        $tagname = "area"

        if(!($Target)){
          
            $PSBoundParameters.Target = "_Blank"
        }

        Set-htmltag -TagName $tagName -Parameters $PSBoundParameters -TagType void
    }#End process


}
Function article {
    <#
    .SYNOPSIS
    Generates article HTML tag.

    .PARAMETER Class
    Allows to specify one (or more) class(es) to assign the html element.
    More then one class can be assigned by seperating them with a white space.

    .PARAMETER Id
    Allows to specify an id to assign the html element.

    .PARAMETER Style
    Allows to specify in line CSS style to assign the html element.

    .PARAMETER Content
    Allows to add child element(s) inside the current opening and closing HTML tag(s).


    .EXAMPLE

    article {
        h1 "This is blog post number 1"
        p {
            "This is content of blog post 1"
        }
    }

    Generates the following code:

    <article>
        <h1>This is blog post number 1</h1>
        <p>
            This is content of blog post 1
        </p>
    </article>

    .EXAMPLE

    It is also possible to use regular powershell logic inside a scriptblock. The example below, generates a article element
    based on values located in a powershell object. The content is generated dynamically through the usage of a foreach loop.

    $objs = @()
    $objs += new-object psobject -property @{"title"="this is title 2";content="this is the content of article 2"}
    $objs += new-object psobject -property @{"title"="this is title 3";content="this is the content of article 3"}
    $objs += new-object psobject -property @{"title"="this is title 4";content="this is the content of article 4"}
    $objs += new-object psobject -property @{"title"="this is title 5";content="this is the content of article 5"}
    $objs += new-object psobject -property @{"title"="this is title 6";content="this is the content of article 6"}

    body {

        foreach ($article in $objs){
            article {
                h2 $article.title
                p{
                    $article.content
                }
            }
        }
    }

    Generates the following code:

        <body>
            <article>
                <h2>this is title 2</h2>
                <p>
                this is the content of article 2
                </p>
            </article>
            <article>
                <h2>this is title 3</h2>
                <p>
                this is the content of article 3
                </p>
            </article>
            <article>
                <h2>this is title 4</h2>
                <p>
                this is the content of article 4
                </p>
            </article>
            <article>
                <h2>this is title 5</h2>
                <p>
                this is the content of article 5
                </p>
            </article>
            <article>
                <h2>this is title 6</h2>
                <p>
                this is the content of article 6
                </p>
            </article>
        </body>

    .NOTES
     Current version 3.1
        History:
            2018.11.1; Stephanevg;Updated to version 3.1
            2018.10.30;@ChristopheKumor;Updated to version 3.0
            2018.04.10;Stephanevg; Added parameters
            2018.04.01;Stephanevg;Creation.
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [CmdletBinding()]
    Param(

        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $false,
            Position = 0
        )]
        $Content,

        [Parameter(Position = 1)]
        [String]$Class,

        [Parameter(Position = 2)]
        [String]$Id,

        [Parameter(Position = 3)]
        [String]$Style,

        [Parameter(Position = 4)]
        [Hashtable]$Attributes
    )
    Process {

        $tagname = "article"

        Set-htmltag -TagName $tagName -Parameters $PSBoundParameters -TagType NonVoid
    }


}

Function aside {
    <#
    .SYNOPSIS
    Generates aside HTML tag.

    .PARAMETER Class
    Allows to specify one (or more) class(es) to assign the html element.
    More then one class can be assigned by seperating them with a white space.

    .PARAMETER Id
    Allows to specify an id to assign the html element.

    .PARAMETER Style
    Allows to specify in line CSS style to assign the html element.

    .PARAMETER Content
    Allows to add child element(s) inside the current opening and closing HTML tag(s).


    .EXAMPLE

    aside {
        h4 "This is an aside"
        p{
            "This is a paragraph inside the aside block"
        }
    }

    Generates the following code:

    <aside>
        <h4>This is an aside</h4>
        <p>
            This is a paragraph inside the aside block
        </p>
    </aside>

    .LINK
        https://github.com/Stephanevg/PSHTML
    
    .NOTES
        Current version 3.1
        History:
            2018.11.1; Stephanevg;Updated to version 3.1
    #>
    [CmdletBinding()]
    Param(

        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $false,
            Position = 0
        )]
        $Content,

        [Parameter(Position = 1)]
        [String]$Class,

        [Parameter(Position = 2)]
        [String]$Id,

        [Parameter(Position = 3)]
        [String]$Style,

        [Parameter(Position = 4)]
        [Hashtable]$Attributes
    )
    Process {

        $tagname = "aside"

        Set-htmltag -TagName $tagName -Parameters $PSBoundParameters  -TagType NonVoid
    }


}
Function b {
    <#
        .SYNOPSIS

        Generates a <b> HTML tag.
        The <b> tag defines a hyperlink, which is used to link from one page to another.
        
        .DESCRIPTION

        .PARAMETER Class
        Allows to specify one (or more) class(es) to assign the html element.
        More then one class can be assigned by seperating them with a white space.

        .PARAMETER Id
        Allows to specify an id to assign the html element.

        .PARAMETER Content
        Allows to add child element(s) inside the current opening and closing HTML tag(s).


        .EXAMPLE
        The following exapmles show cases how to create an empty b, with a class, an ID, and, custom attributes.
        
        b -Class "myclass1 MyClass2" -Id myid -Attributes @{"custom1"='val1';custom2='val2'}

        Generates the following code:

        <b Class="myclass1 MyClass2" Id="myid" custom1="val1" custom2="val2"  >
        </b>


        .NOTES
        Current version 3.1
        History:
            2019.06.18;@Josh_Burkard;initial version
        .LINK
            https://github.com/Stephanevg/PSHTML
    #>

    Param(

        [Parameter(Mandatory = $false)]
        [AllowEmptyString()]
        [AllowNull()]
        $Content,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class,

        [String]$Id,
        
        [Hashtable]$Attributes

    )
    $tagname = "b"

    Set-htmltag -TagName $tagName -Parameters $PSBoundParameters -TagType NonVoid
    
    

}
 
Function base {
    <#
    .SYNOPSIS
    Create a base title in an HTML document.

    .DESCRIPTION
    The <base> tag specifies the base URL/target for all relative URLs in a document.

    There can be at maximum one <base> element in a document, and it must be inside the <head> element.

    .EXAMPLE

    base
    .EXAMPLE
    base "woop1" -Class "class"

    .Notes
    Author: StÃ©phane van Gulick
    Current Version: 3.1
    History:
        2018.11.1; Stephanevg;Updated to version 3.1
        2018.10.30;@ChristopheKumor;Updated to version 3.0
        2018.05.11;@Stephanevg; fixed minor bugs
        2018.05.09;@Stephanevg; Creation

    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [Cmdletbinding()]
    Param(

        [Parameter(Mandatory = $true)]
        [String]$href,

        [ValidateSet("_self", "_blank", "_parent", "_top")]
        [String]$Target,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class,

        [String]$Id,

        [Hashtable]$Attributes
    )

    $tagname = "base"

    if(!($Target)){
          
        $PSBoundParameters.Target = "_self"
    }

    Set-htmltag -TagName $tagName -Parameters $PSBoundParameters -TagType void


}
Function blockquote {
    <#
    .SYNOPSIS
    Create a blockquote tag in an HTML document.

    .EXAMPLE
    blockquote -cite "https://www.google.com" -Content @"
        Google is a
        great website
        to search for information
    "@

    .EXAMPLE
    blockquote -cite "https://www.google.com" -class "classy" -style "stylish" -Content @"
        Google is a
        great website
        to search for information
    "@

    .NOTES
    Current version 3.1
       History:
            2018.11.1; Stephanevg;Updated to version 3.1
            2018.10.30;@ChristopheKumor;Updated to version 3.0
            2018.10.29;@ChristopheKumor;New Set-HtmlTag function to version 2.2
            2018.10.02;@NicolasBaudin;Fixed pipeline support bug. to version 2.1
            2018.10.02;@stephanevg;Fixed error when no content passed. to version 2.0
            2018.10.02;bateskevin;updated to version 2.0
            2018.05.07;stephanevg;updated to version 1.0
            2018.04.01;bateskevinhanevg;Creation.
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [Cmdletbinding()]
    Param(

        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $false,
            Position = 0
        )]
        [AllowEmptyString()]
        [AllowNull()]
        $Content,

        [string]$cite,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class,

        [String]$Id,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Style,

        [String]$title,

        [Hashtable]$Attributes
    )

    $tagname = "blockquote"
    Set-htmltag -TagName $tagName -Parameters $PSBoundParameters -TagType NonVoid    


}
Function Body {
    <#
        .SYNOPSIS
        Generates a Body HTML tag.

        .PARAMETER Class
        Allows to specify one (or more) class(es) to assign the html element.
        More then one class can be assigned by seperating them with a white space.

        .PARAMETER Id
        Allows to specify an id to assign the html element.

        .PARAMETER Style
        Allows to specify in line CSS style to assign the html element.

        .PARAMETER Content
        Allows to add child element(s) inside the current opening and closing HTML tag(s).


        .EXAMPLE
        The following exapmles show cases how to create an empty Body, with a class, an ID, and, custom attributes.
        Body -Class "myclass1 MyClass2" -Id myid -Attributes @{"custom1"='val1';custom2='val2'}

        Generates the following code:

        <Body Class="myclass1 MyClass2" Id="myid" custom1="val1" custom2="val2"  >
        </Body>


        .NOTES
        Current version 3.1
        History:
            2018.11.1; Stephanevg;Updated to version 3.1
            2018.10.30;@ChristopheKumor;Updated to version 3.0
            2018.04.10;bateskevin; Updated to version 2.0
            2018.04.10;Stephanevg; Added parameters
            2018.04.01;Stephanevg;Creation.
        .LINK
            https://github.com/Stephanevg/PSHTML
    #>

    Param(

        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $false,
            Position = 0
        )]
        $Content,

        [Parameter(Position = 1)]
        [String]$Class,

        [Parameter(Position = 2)]
        [String]$Id,

        [Parameter(Position = 3)]
        [String]$Style,

        [Parameter(Position = 4)]
        [Hashtable]$Attributes
    )
    Process {
        $tagname = "Body"

        Set-htmltag -TagName $tagName -Parameters $PSBoundParameters -TagType NonVoid
    }


}
Function br
{
    <#
    .SYNOPSIS
    Create a br in an HTML document.

    .EXAMPLE

    br
    
    .Notes
    Author: Ravikanth Chaganti
    Version: 3.1.0
    History:
        2018.10.29;rchaganti; Adding br element
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [Cmdletbinding()]
    param
    (

        [Parameter(Position = 1)]
        [String]$Class,

        [Parameter(Position = 2)]
        [String]$Id,

        [Parameter(Position = 3)]
        [String]$Style,

        [Parameter(Position = 4)]
        [Hashtable]$Attributes
    )

    $tagname = "br"
    Set-htmltag -TagName $tagName -Parameters $PSBoundParameters -TagType void
}
Function button {
    <#
    .SYNOPSIS
    Creates a <button> html tag.

    .DESCRIPTION
    Should be used in conjunction with a form attribute.


    .EXAMPLE

    button
    .EXAMPLE
    button "woop1" -Class "class"

    .EXAMPLE

    <form>
    <fieldset>
        <button>Personalia:</button>
        Name: <input type="text" size="30"><br>
        Email: <input type="text" size="30"><br>
        Date of birth: <input type="text" size="10">
    </fieldset>
    </form>

    .Notes
    Author: StÃ©phane van Gulick
    Version: 3.1
    History:
        2018.11.1; Stephanevg;Updated to version 3.1
        2018.10.30;@ChristopheKumor;Updated to version 3.0
        2018.05.09;@Stephanevg; Creation
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [Cmdletbinding()]
    Param(
        [Parameter(Mandatory = $false)]
        [AllowEmptyString()]
        [AllowNull()]
        $Content,

        [String]$Id,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class,

        

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Style,

        [Hashtable]$Attributes
    )


    $tagname = "button"

    Set-htmltag -TagName $tagName -Parameters $PSBoundParameters -TagType nonVoid




}
Function canvas {
    <#
    .SYNOPSIS
    Create a canvas tag in an HTML document.

    .DESCRIPTION

    Will create a canvas. Perfect to draw beautfill art.

    Note: Any text inside the <canvas> element will be displayed in browsers that does not support <canvas>.

    .EXAMPLE
    
     canvas -Height 300 -Width 400

     generates

    <canvas Height="300" Width="400"  >
    </canvas>

    .EXAMPLE
    
    #text will be displayed, only if the canvas cannot be displayed in the browser.
    canvas -Height 300 -Width 400 -Content "Not supported in your browser"

    <canvas Width="400" Height="300"  >
        Not supported in your browser
    </canvas>

    .NOTES
    Current version 3.1
       History:
            2018.11.1; Stephanevg;Updated to version 3.1
            2018.10.30;@ChristopheKumor;Updated to version 3.0
            2018.04.01;stephanevg;Creation.
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [Cmdletbinding()]
    Param(

        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $false,
            Position = 0
        )]
        [AllowEmptyString()]
        [AllowNull()]
        $Content,

        [AllowEmptyString()]
        [AllowNull()]
        $Height,

        [AllowEmptyString()]
        [AllowNull()]
        $Width,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class = "",

        [String]$Id,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Style,

        [String]$title,

        [Hashtable]$Attributes
    )


    Process {       
        $tagname = "canvas"
        Set-htmltag -TagName $tagName -Parameters $PSBoundParameters -TagType nonVoid
    }

}

Function Caption {
    <#
        .SYNOPSIS
        Generates a caption HTML tag.

        .PARAMETER Class
        Allows to specify one (or more) class(es) to assign the html element.
        More then one class can be assigned by seperating them with a white space.

        .PARAMETER Id
        Allows to specify an id to assign the html element.

        .PARAMETER Style
        Allows to specify in line CSS style to assign the html element.

        .PARAMETER Content
        Allows to add child element(s) inside the current opening and closing HTML tag(s).


        .EXAMPLE
        The following exapmles show cases how to create an empty caption, with a class, an ID, and, custom attributes.
        caption -Class "myclass1 MyClass2" -Id myid -Attributes @{"custom1"='val1';custom2='val2'}

        Generates the following code:

        <caption Class="myclass1 MyClass2" Id="myid" custom1="val1" custom2="val2"  >
        </caption>

        .EXAMPLE
        The caption is used in the construction of the HTML table. The following example illustrates how the caption could be used.

        table{
                    caption "This is a table generated with PSHTML"
                    thead {
                        tr{
                            th "number1"
                            th "number2"
                            th "number3"
                        }
                    }
                    tbody{
                        tr{
                            td "Child 1.1"
                            td "Child 1.2"
                            td "Child 1.3"
                        }
                        tr{
                            td "Child 2.1"
                            td "Child 2.2"
                            td "Child 2.3"
                        }
                    }
                    tfoot{
                        tr{
                            td "Table footer"
                        }
                    }
                }
            }
        .LINK
            https://github.com/Stephanevg/PSHTML
        .NOTES
        Current version 3.1.0
        History:
            2018.11.1; Stephanevg;Updated to version 3.1
            2018.10.30;@ChristopheKumor;Updated to version 3.0
            2018.04.10;Stephanevg; Added parameters
            2018.04.01;Stephanevg;Creation.

        Information on the Caption HTML tag can be found here --> https://www.w3schools.com/tags/tag_caption.asp
    #>

    Param(

        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $false,
            Position = 0
        )]
        $Content,

        [Parameter(Position = 1)]
        [String]$Class,

        [Parameter(Position = 2)]
        [String]$Id,

        [Parameter(Position = 3)]
        [String]$Style,

        [Parameter(Position = 4)]
        [Hashtable]$Attributes

    )
    Process {

        $tagname = "caption"
        Set-htmltag -TagName $tagName -Parameters $PSBoundParameters -TagType nonVoid
    }


}

#From Jakub Jares (Thanks!)
function Clear-WhiteSpace ($Text) {
    "$($Text -replace "(`t|`n|`r)"," " -replace "\s+"," ")".Trim()
}
Function Col {
    <#
    .SYNOPSIS
    Generates col HTML tag.

    .DESCRIPTION
    The <col> tag specifies column properties for each column within a <colgroup> element.
    The <col> tag is useful for applying styles to entire columns, instead of repeating the styles for each cell, for each row.

    .PARAMETER Class
    Allows to specify one (or more) class(es) to assign the html element.
    More then one class can be assigned by seperating them with a white space.

    .PARAMETER Id
    Allows to specify an id to assign the html element.

    .PARAMETER Style
    Allows to specify in line CSS style to assign the html element.


    .EXAMPLE

    col -span 3 -Class "Table1"

    Generates the following code

    <col span="3" Class="Table1"  >

    .EXAMPLE

    Col is often used in conjunction with 'colgroup'. See below for an example using colgroup and two col

    Colgroup {
        col -span 3 -Style "Background-color:red"
        col -Style "Backgroung-color:yellow"
    }

    Generates the following code
   <colgroup>
        <col span="3" Style="Background-color:red"  >
        <col Style="Backgroung-color:yellow"  >
    </colgroup>

    .NOTES
    Current version 3.1
    History:
        2018.11.1; Stephanevg;Updated to version 3.1
        2018.10.30;@ChristopheKumor;Updated to version 3.0
        2018.04.08;Stephanvg; Updated to version 1.0
        2018.04.01;Stephanevg;Fix disyplay bug.
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    Param(
        [Parameter(Position = 0)]
        [int]
        $span,

        [Parameter(Position = 1)]
        [String]$Class,

        [Parameter(Position = 2)]
        [String]$Id,

        [Parameter(Position = 3)]
        [String]$Style,

        [Parameter(Position = 4)]
        [Hashtable]$Attributes

    )

    Process {
        $tagname = "col"
        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType Void
    }

}
Function Colgroup {
    <#

    .SYNOPSIS
    Generates colgroup HTML tag.

    .DESCRIPTION
    The <colgroup> tag is useful for applying styles to entire columns, instead of repeating the styles for each cell, for each row.


    .PARAMETER Class
    Allows to specify one (or more) class(es) to assign the html element.
    More then one class can be assigned by seperating them with a white space.

    .PARAMETER Id
    Allows to specify an id to assign the html element.

    .PARAMETER Style
    Allows to specify in line CSS style to assign the html element.


    .EXAMPLE

    Colgroup {
        col -span 2
    }

    <colgroup>
        <col span="2"  >
    </colgroup>

    .EXAMPLE

    Colgroup {
        col -span 3 -Style "Background-color:red"
        col -Style "Backgroung-color:yellow"
    }

    Generates the following code
   <colgroup>
        <col span="3" Style="Background-color:red"  >
        <col Style="Backgroung-color:yellow"  >
    </colgroup>

    .NOTES
    Current version 3.1
    History:
    2018.10.30;@ChristopheKumor;Updated to version 3.0
        2018.04.08;Stephanevg; Updated to version 1.0
        2018.04.01;Stephanevg;Fix disyplay bug.
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    Param(

        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $false,
            Position = 0
        )]
        $Content,

        [Parameter(Position = 1)]
        [int]
        $span,

        [Parameter(Position = 2)]
        [String]$Class,

        [Parameter(Position = 3)]
        [String]$Id,

        [Parameter(Position = 4)]
        [String]$Style,

        [Parameter(Position = 5)]
        [Hashtable]$Attributes


    )
  
    Process {
        $tagname = "colgroup"
        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid
    }

}
Function ConvertTo-HTMLTable {

    <#
    .SYNOPSIS
        This cmdlet is deprecated. Use ConvertTo-PSHTMLTable instead.
    
    
            
    
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        $Object,
        [String[]]$Properties
    )
    Write-Warning "ConvertTo-HTMLTable is deprecated and will be removed in a future version. Please use ConvertTo-PSHTMLTable instead"
    ConvertTo-PSHTMLTable @PSBoundParameters
}

function ConvertTo-PSHTMLTable {
    
    <#
    .SYNOPSIS
        Converts a powershell object to a HTML table.
    
    .DESCRIPTION
        This cmdlet is intended to be used when powershell objects should be rendered in an HTML table format.
    
    .PARAMETER Object
        Specifies the object to use
    
    .PARAMETER Properties
        Properties you want as table headernames
    
    .EXAMPLE
        $service = Get-Service -Name Sens,wsearch,wscsvc | Select-Object -Property DisplayName,Status,StartType
        ConvertTo-PSHTMLtable -Object $service
    
    .EXAMPLE
        $proc = Get-Process | Select-Object -First 2
        ConvertTo-PSHTMLtable -Object $proc 
    
    .EXAMPLE
        $proc = Get-Process | Select-Object -First 2
        ConvertTo-PSHTMLtable -Object $proc -properties name,handles
    
        Returns the following HTML code
    
        <table>
            <thead>
                <tr>
                    <td>name</td>
                    <td>handles</td>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>AccelerometerSt</td>
                    <td>155</td>
                </tr>
                <tr>
                    <td>AgentService</td>
                    <td>190</td>
                </tr>
            </tbody>
        </table>
    
    .NOTES
            Current version 0.7.1
            History:
            2019.02.14;LxLeChat;Miaou
            2018.05.09;stephanevg;Made Linux compatible (changed Get-Serv).
            2018.10.14;Christophe Kumor;Update.
            2018.05.09;stephanevg;Creation.
            
    
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        $Object,
        [String[]]$Properties,
        [String]$Caption,

        [String]$TableID,
        [String]$TableClass,
        [String]$TableStyle,
        [HashTable]$TableAttributes,

        [String]$TheadId,
        [String]$TheadClass,
        [String]$TheadStyle,
        [HashTable]$TheadAttributes,

        [String]$TBodyId,
        [String]$TBodyClass,
        [String]$TBodyStyle,
        [HashTable]$TBodyAttributes
    )
    
    begin {
        ## Creation of hastable to store the thead, caption, and trs generated in the process
        ## caption and thead will be generated onlyc one.
        $Hashtable = @{
            caption = $null
            thead   = $null
            trs     = $null
            properties = @()
        }
    }
    
    process {
        
        Foreach ($item in $Object) {
            
            ## thead is null, it means we are in the first iteration, this condition will never be met after the first iteration
            If ( $null -eq $Hashtable.thead ) {
                if ($Properties) {
                    $HeaderNames = $Properties
                    $Hashtable.properties = $properties
                }
                else {
                    $props = $item | Get-Member -MemberType Properties | Select-Object Name
                    $HeaderNames = @()
                    foreach ($i in $props) {
                        $HeaderNames += $i.name.tostring()
                        $Hashtable.properties += $i.name.tostring()
                    }
                }

                if ($Caption) {
                    $Hashtable.caption = Caption -Content {
                        $Caption
                    }
                }

                ## Thead Params
                $TheadParams = @{}

                if ($TheadId) {
                    $TheadParams.id = $TheadId
                }
            
                if ($TheadClass) {
                    $TheadParams.Class = $TheadClass
                }
            
                if ($TheadStyle) {
                    $TheadParams.Style = $TheadStyle
                }
            
                if ($TheadAttributes) {
                    $TheadParams.Attributes = $TheadAttributes
                }
                
                $Hashtable.thead = Thead @TheadParams -content {
            
                    tr {
            
                        foreach ($Name in $HeaderNames) {
            
                            th {
                                $Name
                            }
            
                        }
            
                    }
            
                }
            } ## end of the thead is null
            
            ## Trs must be  generated for every iteration
            $tr = tr {
                        
                foreach ($propertyName in $Hashtable.properties) {
                    
                    td {
                        $item.$propertyName
                    }
                    
                }

            }

            $Hashtable.TRs = $Hashtable.TRs + $tr
            
        }
    }
    
    end {

        ## No need to generate TableParams in the process block
        $TableParams = @{}
        if ($TableID) {
            $TableParams.Id = $TableID
        }
    
        if ($TableClass) {
            $TableParams.Class = $TableClass
        }
    
        if ($TableStyle) {
            $TableParams.Style = $TableStyle
        }

        ## TBodyParams
        $TBodyParams = @{}

        if ($TBodyId) {
            $TBodyParams.Id = $TBodyId
        }
    
        if ($TBodyClass) {
            $TBodyParams.Class = $TBodyClass
        }
    
        If ($TBodyStyle) {
            $TBodyParams.Style = $TBodyStyle
        }
    
        If ($TBodyAttributes) {
            $TBodyParams.Attributes = $TBodyAttributes
        }
        
        Table @TableParams -Content { $Hashtable.caption + $Hashtable.thead + (Tbody @TBodyParams {$Hashtable.trs} ) }
    }
}
Function datalist {
    <#
    .SYNOPSIS
    Create a datalist tag in an HTML document.

    .DESCRIPTION

    The <datalist> tag specifies a list of pre-defined options for an <input> element.

    The <datalist> tag is used to provide an "autocomplete" feature on <input> elements. Users will see a drop-down list of pre-defined options as they input data.

    Use the <input> element's list attribute to bind it together with a <datalist> element.

    .EXAMPLE
    
    datalist {
        option -value "Volvo" -Content "Volvo" 
        option -value Saab -Content "saab"
    }


    Generates the following code:

    <datalist>
        <option value="Volvo"  >volvo</option>
        <option value="Saab"  >saab</option>
    </datalist>
    .EXAMPLE
    

    .NOTES
    Current version 3.1
       History:
       2018.10.30;@ChristopheKumor;Updated to version 3.0
            2018.10.05;@stephanevg;Creation.
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [Cmdletbinding()]
    Param(
        [Parameter(Mandatory = $false)]
        [AllowEmptyString()]
        [AllowNull()]
        $Content,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class = "",

        [String]$Id,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Style,

        [String]$title,

        [Hashtable]$Attributes
    )

    Process {

        $tagname = "datalist"

        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid
    }
}
Function dd {
    <#
    .SYNOPSIS
    Create a dd tag in an HTML document.

    .EXAMPLE

    dd
    .EXAMPLE
    dd "woop1" -Class "class"

    .EXAMPLE
    dd "woop2" -Class "class" -Id "Something"

    .EXAMPLE
    dd "woop3" -Class "class" -Id "something" -Style "color:red;"

    .NOTES
    Current version 3.1
       History:
       2018.10.30;@ChristopheKumor;Updated to version 3.0
           2018.10.02;bateskevin;Updated to v2.
           2018.04.01;bateskevin;Creation.
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [Cmdletbinding()]
    Param(
        [Parameter(Mandatory = $true)]
        [AllowEmptyString()]
        [AllowNull()]
        [String]
        $Content,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class = "",

        [String]$Id,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Style,

        [String]$value,

        [HashTable]$Attributes


    )

    Process {

        $tagname = "dd"

        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid
        
    }
}
Function Div {
    <#
        .SYNOPSIS
        Generates a DIV HTML tag.

        .EXAMPLE
        The following exapmles show cases how to create an empty div, with a class, an ID, and, custom attributes.
        div -Class "myclass1 MyClass2" -Id myid -Attributes @{"custom1"='val1';custom2='val2'}

        Generates the following code:

        <div Class="myclass1 MyClass2" Id="myid" custom1="val1" custom2="val2"  >
        </div>


        .NOTES
        Current version 2.0
        History:
        2018.10.30;@ChristopheKumor;Updated to version 3.0
            2018.10.02;bateskevin; Updated to v2.0
            2018.04.10;Stephanevg; Added parameters
            2018.04.01;Stephanevg;Creation.
        .LINK
            https://github.com/Stephanevg/PSHTML
    #>

    Param(

        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $false,
            Position = 0
        )]
        $Content,

        [Parameter(Position = 1)]
        [String]$Class,

        [Parameter(Position = 2)]
        [String]$Id,

        [Parameter(Position = 3)]
        [String]$Style,

        [Parameter(Position = 4)]
        [Hashtable]$Attributes
    )
    Process {

        $tagname = "div"

        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid
    }


}
Function dl {
    <#
    .SYNOPSIS
    Create a dl tag in an HTML document.

    .EXAMPLE
    dl

    .EXAMPLE
    dl -Content {dt -Content "Coffe";dl -Content "Black hot drink"}

    .EXAMPLE
    dl -Class "class" -Id "something" -Style "color:red;"

    .NOTES
    Current version 3.1
       History:
       2018.10.30;@ChristopheKumor;Updated to version 3.0
            2018.10.02;bateskevin;Updated to v2.
            2018.05.01;Removed reversed as this is not supported.
            2018.04.01;bateskevin;Creation.
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [CmdletBinding()]
    Param(

        [Parameter(Mandatory = $false, position = 0)]
        [AllowEmptyString()]
        [AllowNull()]
        $Content,

        [Parameter(Position = 1)]
        [String]$Class,

        [Parameter(Position = 2)]
        [String]$Id,

        [Parameter(Position = 3)]
        [String]$Style,

        [Parameter(Position = 4)]
        [Hashtable]$Attributes,

        [Parameter(Position = 5)]
        [string]$start

    )
    Process {

        $tagname = "dl"

        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid
        
    }

}
Function doctype {
    <#
        .SYNOPSIS
        Generates a html doctype tag.

        .DESCRIPTION

        The <!DOCTYPE> declaration must be the very first thing in your HTML document, before the <html> tag.

        The <!DOCTYPE> declaration is not an HTML tag; it is an instruction to the web browser about what version of HTML the page is written in.



        .EXAMPLE

        doctype

        .NOTES
        Current version 0.1.0
        History:
            2019.07.09;@stephanevg;created

        .LINK
            https://github.com/Stephanevg/PSHTML
    #>

    Param(

    )

    #As described here: https://www.w3schools.com/tags/tag_doctype.asp
    #$tagname = "doctype"
    
    #Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType 'void'
    return "<!DOCTYPE html>"

}
Function dt {
    <#
    .SYNOPSIS
    Create a dt tag in an HTML document.

    .EXAMPLE

    dt
    .EXAMPLE
    dt "woop1" -Class "class"

    .EXAMPLE
    dt "woop2" -Class "class" -Id "Something"

    .EXAMPLE
    dt "woop3" -Class "class" -Id "something" -Style "color:red;"

    .NOTES
    Current version 3.1
       History:
       2018.10.30;@ChristopheKumor;Updated to version 3.0
           2018.10.02;bateskevin;Updated to v2.
           2018.04.01;bateskevin;Creation.
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [Cmdletbinding()]
    Param(
        [Parameter(Mandatory = $true)]
        [AllowEmptyString()]
        [AllowNull()]
        $Content,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class = "",

        [String]$Id,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Style,

        [String]$value,

        [Hashtable]$Attributes
    )

    Process {
        $tagname = "dt"


        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid

        
    }
}
Function em {
    <#
    .SYNOPSIS
    Generates em HTML tag.

    .Description
    This tag is a phrase tag. It renders as emphasized text.

    .EXAMPLE
    p{
        "This is";em {"cool"}
    }

    Will generate the following code

    <p>
        This is
        <em>
        cool
        </em>
    </p>

    .Notes
    Author: Andrew Wickham
    Version: 3.1.0
    History:
    2018.10.30;@ChristopheKumor;Updated to version 3.0
        2018.10.04;@awickham10; Creation

    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [CmdletBinding()]
    Param(

        [Parameter(
            ValueFromPipeline = $true,
            Position = 0
        )]
        $Content,

        [Parameter(Position = 1)]
        [String]$Class,

        [Parameter(Position = 2)]
        [String]$Id,

        [Parameter(Position = 3)]
        [String]$Style,

        [Parameter(Position = 4)]
        [Hashtable]$Attributes

    )

    $tagname = "em"

    Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType NonVoid



}
Function fieldset {
    <#
    .SYNOPSIS
    Create a fieldset title in an HTML document.

    .EXAMPLE

    fieldset
    .EXAMPLE
    fieldset "woop1" -Class "class"

    .EXAMPLE
    $css = @"
        "p {color:green;}
        h1 {color:orange;}"
    "@
    fieldset {$css} -media "print" -type "text/css"

    .Notes
    Author: StÃ©phane van Gulick
    Version: 3.1
    History:
    2018.10.30;@ChristopheKumor;Updated to version 3.0
        2018.05.09;@Stephanevg; Creation
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [Cmdletbinding()]
    Param(
        [Parameter(Mandatory = $false)]
        [AllowEmptyString()]
        [AllowNull()]
        $Content,

        [switch]$disabled,

        [String]$form,

        [String]$name,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class,

        [String]$Id,

        [Hashtable]$Attributes
    )


    $tagname = "fieldset"

    Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid



}

Function figcaption {
    <#
    .SYNOPSIS
    Create a figcaption tag in an HTML document.

    .EXAMPLE

    figcaption
    .EXAMPLE
    figcaption "woop1" -Class "class"

    .EXAMPLE
    figcaption "woop2" -Class "class" -Id "Something"

    .EXAMPLE
    figcaption "woop3" -Class "class" -Id "something" -Style "color:red;"

    .NOTES
    Current version 3.1.0
       History:
       2018.10.30;@ChristopheKumor;Updated to version 3.0
           2018.10.02;bateskevin;Updated to v2.
           2018.04.01;bateskevin;Creation.
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [Cmdletbinding()]
    Param(
        [Parameter(Mandatory = $true)]
        [AllowEmptyString()]
        [AllowNull()]
        $Content,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class = "",

        [String]$Id,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Style,

        [String]$title,

        [Hashtable]$Attributes
    )

    Process {

        $tagname = "figcaption"

        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid
        
    }
}
Function figure {
    <#
        .SYNOPSIS
        Generates a figure HTML tag.

        .EXAMPLE
        The following exapmles show cases how to create an empty figure, with a class, an ID, and, custom attributes.
        figure -Class "myclass1 MyClass2" -Id myid -Attributes @{"custom1"='val1';custom2='val2'}

        Generates the following code:

        <figure Class="myclass1 MyClass2" Id="myid" custom1="val1" custom2="val2"  >
        </figure>


        .NOTES
        Current version 3.1
        History:
        2018.10.30;@ChristopheKumor;Updated to version 3.0
           2018.10.02;bateskevin;Updated to v2.
           2018.04.01;bateskevin;Creation.
        .LINK
            https://github.com/Stephanevg/PSHTML
    #>

    Param(

        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $false,
            Position = 0
        )]
        $Content,

        [Parameter(Position = 1)]
        [String]$Class,

        [Parameter(Position = 2)]
        [String]$Id,

        [Parameter(Position = 3)]
        [String]$Style,

        [Parameter(Position = 4)]
        [Hashtable]$Attributes
    )
    Process {

        $tagname = "figure"

        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid
        
    }
}
Function Footer {
    <#
        .SYNOPSIS
        Generates a Footer HTML tag.

        .PARAMETER Class
        Allows to specify one (or more) class(es) to assign the html element.
        More then one class can be assigned by seperating them with a white space.

        .PARAMETER Id
        Allows to specify an id to assign the html element.

        .PARAMETER Style
        Allows to specify in line CSS style to assign the html element.

        .PARAMETER Content
        Allows to add child element(s) inside the current opening and closing HTML tag(s).


        .EXAMPLE
        Footer {
                h6 "This is h6 Title in Footer"
        }

        Generates the following code

        <footer>
            <h6>This is h6 Title in Footer</h6>
        </footer>

        Generates the following code:

        <Body Class="myclass1 MyClass2" Id="myid" custom1="val1" custom2="val2"  >
        </Body>


        .NOTES
        Current version 3.1
        History:
        2018.10.30;@ChristopheKumor;Updated to version 3.0
            2018.04.10;Stephanevg; Added parameters
            2018.04.01;Stephanevg;Creation.
        .LINK
            https://github.com/Stephanevg/PSHTML
    #>
    Param(
        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $false,
            Position = 0
        )]
        $Content,

        [Parameter(Position = 1)]
        [String]$Class,

        [Parameter(Position = 2)]
        [String]$Id,

        [Parameter(Position = 3)]
        [String]$Style,

        [Parameter(Position = 4)]
        [Hashtable]$Attributes
    )

    Process {
        $tagname = "footer"
        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid
    }

}
Function Form {
    <#
    .SYNOPSIS
    Generates Form HTML tag.

    .DESCRIPTION 
    Generates the HTML FORM tag for form manipulations.

    .PARAMETER Action
    Specifiy which URL should be called when the form is called.

    .PARAMETER Method
    The HTTP method to use when sending form-data.
    Acceptable values are:
    GET
    POST

    .PARAMETER Target
    Specifies where to display the response that is received after submitting the form.
    Acceptable values are:
    _blank
    _self (default)
    _parent
    _top

    If this parameter is not called, it will default to target=_self

    .Parameter Enctyp
    This is a dynamic parameter, which is only available when 'Method' is set to 'post'.
    The available values are:
    -"application/x-www-form-urlencoded"
    -"multipart/form-data"
    -"text/plain"

    See here for more information --> https://www.w3schools.com/tags/att_form_enctype.asp

    .PARAMETER Class
    Allows to specify one (or more) class(es) to assign the html element.
    More then one class can be assigned by seperating them with a white space.

    .PARAMETER Id
    Allows to specify an id to assign the html element.

    .PARAMETER Style
    Allows to specify in line CSS style to assign the html element.

    .PARAMETER Content
    Allows to add child element(s) inside the current opening and closing HTML tag(s).


    .EXAMPLE

    form "/action_Page.php" post _self

    Generates the following html element: (Not very usefull, we both agree on that)

    <from action="/action_Page.php" method="post" target="_self" >
    </form>

    .EXAMPLE
    The following Example show how to pass custom HTML tag and their values
    form "/action_Page.php" post _self -attributes @{"Woop"="Wap";"sap"="sop"}

    .NOTES
    Current version 3.1
    History:
    2018.10.30;@ChristopheKumor;Updated to version 3.0
        2018.04.08;Stephanevg; Fixed custom Attributes display bug. Updated help
        2018.04.01;Stephanevg;Fix disyplay bug.
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [CmdletBinding()]
    Param(

        [Parameter(Mandatory = $true, Position = 0)]
        [String]$action,

        [Parameter(Mandatory = $true, Position = 1)]
        [ValidateSet("get", "post")]
        [String]$method = "get",

        [Parameter(Mandatory = $false, Position = 2)]
        [ValidateSet("_blank", "_self", "_parent", "top")]
        [String]$target,

        [Parameter(Position = 3)]
        [String]$Class,

        [Parameter(Position = 4)]
        [String]$Id,

        [Parameter(Position = 5)]
        [String]$Style,

        [Parameter(Position = 6)]
        [Hashtable]$Attributes,

        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $false,
            Position = 7
        )]
        $Content
    )
    DynamicParam{
        If($method -eq 'Post'){
            $ParameterName = 'enctype'
            $Attribute = New-Object System.Management.Automation.ParameterAttribute
            $Attribute.HelpMessage = "Please enter encoding type"
            $Attribute.Mandatory = $True

            $ValidateSetValues = @("application/x-www-form-urlencoded","multipart/form-data","text/plain")
            $ValidateSet = New-Object System.Management.Automation.ValidateSetAttribute($ValidateSetValues)
            $attributeCollection = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
            $attributeCollection.add($ValidateSet)
            $attributeCollection.Add($Attribute)
            $Para = New-Object System.Management.Automation.RuntimeDefinedParameter($ParameterName, [string], $attributeCollection)
            $paramDictionary = new-object System.Management.Automation.RuntimeDefinedParameterDictionary
            $paramDictionary.Add($ParameterName, $para)
            return $paramDictionary
        }
    }
    Process {
        $tagname = "form"

        if(!($Target)){
          
            $PSBoundParameters.Target = "_self"
        }
        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid
    }
}

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
        Author: StÃ©phane van Gulick
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
function Get-PSHTMLColor {
    <#
    .SYNOPSIS
    
    Returns a color string based on a color type and name
    
    .DESCRIPTION
    
    Returns a color string based on one of the W3C defined color names, using one of the
    formats typically used in HTML.
    
    .PARAMETER Type
    
    The type of color returned. Possible values: hex, hsl, hsla, rgb, rgba
    
    .PARAMETER Color
    
    A color name as defined by the W3C
    
    .EXAMPLE
    
    Get-PSHTMLColor -Type hex -Color lightblue
    #ADD8E6
    
    .EXAMPLE
    
    Get-PSHTMLColor -Type hsl -Color lightblue
    hsl(194,52%,79%)
    
    .EXAMPLE
    
    Get-PSHTMLColor -Type hsla -Color lightblue
    hsla(194,52%,79%,0)
    
    .EXAMPLE
    
    Get-PSHTMLColor -Type rgb -Color lightblue
    rgb(173,216,230)
    
    .EXAMPLE
    
    Get-PSHTMLColor -Type rgba -Color lightblue
    rgba(173,216,230,0)
    
    #>
        Param(
            [Parameter(Mandatory=$false)]
            [ValidateSet("hex","hsl","hsla","rgb","rgba")]
            [string]
            $Type="rgb", 
            [Parameter(Mandatory=$true)]
            [ArgumentCompleter({[Color]::colornames})]
            [String]
            $Color
        )
    
        $colordef =  "$($color)_def"
        switch ($Type){
            'rgb' {
                Return [Color]::$color
                }
            'rgba' {
                Return [Color]::rgba([Color]::$colordef.R,[Color]::$colordef.G,[Color]::$colordef.B,0)
                }
            'hex' {
                Return [Color]::hex([Color]::$colordef.R,[Color]::$colordef.G,[Color]::$colordef.B)
                }
            'hsl'{
                Return [Color]::hsl([Color]::$colordef.R,[Color]::$colordef.G,[Color]::$colordef.B)
            }
            'hsla' {
                Return [Color]::hsla([Color]::$colordef.R,[Color]::$colordef.G,[Color]::$colordef.B,0)
            }
            default {
                Return [Color]::$Color
                }
        }
        
    }
Function Get-PSHTMLConfiguration {
    <#
    .SYNOPSIS
        Returns the PSHTML current configuration
    .DESCRIPTION
        Use this cmdlet to get the configuration that is currently loaded.
        It is possible to access the different parts off the configuration using specific methods (See example section).

        Use (Get-PSHTMLConfiguration).LoadConfigurationData() to reapply a configuration file.

    .EXAMPLE
        Get-PSHTMLConfiguration
    .EXAMPLE
        (Get-PSHTMLConfiguration).GetGeneralConfig()
        Returns the global settings current applied in PSHTML
    .EXAMPLE
        (Get-PSHTMLConfiguration).GetAssetsConfig()
        Returns the assets that are currently present in PSHTML
    .EXAMPLE
        (Get-PSHTMLConfiguration).GetLogConfig()
        Returns the logging settings currently set for PSHTML

    .Example
        (Get-PSHTMLConfiguration).LoadConfigurationData()
        Allows to relead the configuration file data into memory.

    .Example
         It is possible to set new values to for the PSHTML environment as follows:

        $Settings = Get-PSHTMLConfiguration
        $Settings.Data.Logging.MaxFiles = 100

        This will change the default allowed number of log files to 100.

        This setting will be present only during this session. It will be overwritten at each reload of the module, or when the .LoadConfiguration() method is used.

    .INPUTS
        None
    .OUTPUTS
        [ConfigurationFile]
    .NOTES
        General notes
    #>
    return $Script:PSHTML_Configuration

}
Function Get-PSHTMLInclude {
    <#
    .SYNOPSIS
    Retrieve the list of available PSHTML include files.

    .DESCRIPTION
    Allows to list the current existing include documents available to use.

    .PARAMETER Name

    Specifiy the name of an include file. (The name of an include file is the name of the powershell script containing the code, without the extension.)
    Example: Footer.ps1 The name will be 'Footer'

    This parameter is a dynamic parameter, and you can tab through the different values up until you find the one you wish to use.

    .Example

    Get-PSHTMLInclude

    .Example

    Get-PSHTMLInclude -Name Footer
#>
    [CmdletBinding()]
    Param(
        
    )

    DynamicParam {
        $ParameterName = 'Name'

        $Includes = (Get-PSHTMLConfiguration).GetInclude()

        if ($Includes) {
            $Names = $Includes.Name
 
            $Attribute = New-Object System.Management.Automation.ParameterAttribute
            $Attribute.Position = 1
            $Attribute.Mandatory = $False
            $Attribute.HelpMessage = 'Select which file to include'
 
            $Collection = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
            $Collection.add($Attribute)
 
            $ValidateSet = New-Object System.Management.Automation.ValidateSetAttribute($Names)
            $Collection.add($ValidateSet)
 
            $Param = New-Object System.Management.Automation.RuntimeDefinedParameter($ParameterName, [string], $Collection)
 
            $Dictionary = New-Object System.Management.Automation.RuntimeDefinedParameterDictionary
            $Dictionary.Add($ParameterName, $Param)
            return $Dictionary
        }
        
 
    }

    Begin {
        $Name = $PsBoundParameters[$ParameterName]
    }
    Process {

        If ($Name) {
            $Includes = (Get-PSHTMLConfiguration).GetInclude($Name)
        }
        else {
            $Includes = (Get-PSHTMLConfiguration).GetInclude()
        }
    
        

    }
    End {

        return $Includes
    }

}
Function H1 {
    <#
    .SYNOPSIS
    Create a h1 title in an HTML document.

    .EXAMPLE

    h1
    .EXAMPLE
    h1 "woop1" -Class "class"

    .EXAMPLE
    h1 "woop2" -Class "class" -Id "MainTitle"

    .EXAMPLE
    h1 {"woop3"} -Class "class" -Id "MaintTitle" -Style "color:red;"

    .Notes
    Author: StÃ©phane van Gulick
    Version: 3.1.0
    History:
    2018.10.30;@ChristopheKumor;Updated to version 3.0
        2018.04.08;Stephanevg; Updated to version 1.0: Updated content block to support string & ScriptBlock
        2018.04.08;Stephanevg; Fixed custom Attributes display bug. Updated help
        2018.03.25;@Stephanevg; Added Styles, ID, CLASS attributes functionality
        2018.03.25;@Stephanevg; Creation
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [Cmdletbinding()]
    Param(
        [Parameter(Mandatory = $false)]
        [AllowEmptyString()]
        [AllowNull()]
        $Content,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class,

        [String]$Id,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Style,

        [Hashtable]$Attributes
    )

    Process {
        $tagname = "h1"
        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid
    }
}
Function h2 {
    <#
    .SYNOPSIS
    Create a h2 title in an HTML document.

    .EXAMPLE

    h2
    .EXAMPLE
    h2 "woop1" -Class "class"

    .EXAMPLE
    h2 "woop2" -Class "class" -Id "MainTitle"

    .EXAMPLE
    h2 {"woop3"} -Class "class" -Id "MaintTitle" -Style "color:red;"

    .Notes
    Author: StÃ©phane van Gulick
    Version: 3.1.0
    History:
    2018.10.30;@ChristopheKumor;Updated to version 3.0
        2018.04.08;Stephanevg; Updated to version 1.0: Updated content block to support string & ScriptBlock
        2018.03.25;@Stephanevg; Creation
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [Cmdletbinding()]
    Param(
        [Parameter(Mandatory = $false)]
        [AllowEmptyString()]
        [AllowNull()]
        $Content,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class,

        [String]$Id,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Style,

        [Hashtable]$Attributes
    )

    Process {
        $tagname = "h2"
        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid
    }
}
Function h3 {
    <#
    .SYNOPSIS
    Create a h3 title in an HTML document.

    .EXAMPLE

    h3
    .EXAMPLE
    h3 "woop1" -Class "class"

    .EXAMPLE
    h3 "woop2" -Class "class" -Id "MainTitle"

    .EXAMPLE
    h3 {"woop3"} -Class "class" -Id "MaintTitle" -Style "color:red;"

    .Notes
    Author: StÃ©phane van Gulick
    Version: 3.1.0
    History:
    2018.10.30;@ChristopheKumor;Updated to version 3.0
        2018.04.08;Stephanevg; Updated to version 1.0: Updated content block to support string & ScriptBlock
        2018.03.25;@Stephanevg; Creation
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [Cmdletbinding()]
    Param(
        [Parameter(Mandatory = $false)]
        [AllowEmptyString()]
        [AllowNull()]
        $Content,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class,

        [String]$Id,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Style,

        [Hashtable]$Attributes
    )

    Process {
        $tagname = "h3"
        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid
    }
}
Function h4 {
    <#
    .SYNOPSIS
    Create a h4 title in an HTML document.

    .EXAMPLE

    h4
    .EXAMPLE
    h4 "woop1" -Class "class"

    .EXAMPLE
    h4 "woop2" -Class "class" -Id "MainTitle"

    .EXAMPLE
    h4 {"woop3"} -Class "class" -Id "MaintTitle" -Style "color:red;"

    .Notes
    Author: StÃ©phane van Gulick
    Version: 3.1.0
    History:
    2018.10.30;@ChristopheKumor;Updated to version 3.0
        2018.04.08;Stephanevg; Updated to version 1.0: Updated content block to support string & ScriptBlock
        2018.03.25;@Stephanevg; Creation
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [Cmdletbinding()]
    Param(
        [Parameter(Mandatory = $false)]
        [AllowEmptyString()]
        [AllowNull()]
        $Content,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class,

        [String]$Id,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Style,

        [Hashtable]$Attributes
    )

    Process {
        $tagname = "h4"
        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid
    }
}
Function h5 {
    <#
    .SYNOPSIS
    Create a h5 title in an HTML document.

    .EXAMPLE

    h5
    .EXAMPLE
    h5 "woop1" -Class "class"

    .EXAMPLE
    h5 "woop2" -Class "class" -Id "MainTitle"

    .EXAMPLE
    h5 {"woop3"} -Class "class" -Id "MaintTitle" -Style "color:red;"

    .Notes
    Author: StÃ©phane van Gulick
    Version: 3.1.0
    History:
    2018.10.30;@ChristopheKumor;Updated to version 3.0
        2018.04.08;Stephanevg; Updated to version 1.0: Updated content block to support string & ScriptBlock
        2018.03.25;@Stephanevg; Creation
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [Cmdletbinding()]
    Param(
        [Parameter(Mandatory = $false)]
        [AllowEmptyString()]
        [AllowNull()]
        $Content,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class,

        [String]$Id,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Style,

        [Hashtable]$Attributes
    )

    Process {
        $tagname = "h5"
        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid
    }
}
Function h6 {
    <#
    .SYNOPSIS
    Create a h6 title in an HTML document.

    .EXAMPLE

    h6
    .EXAMPLE
    h6 "woop1" -Class "class"

    .EXAMPLE
    h6 "woop2" -Class "class" -Id "MainTitle"

    .EXAMPLE
    h6 {"woop3"} -Class "class" -Id "MaintTitle" -Style "color:red;"

    .Notes
    Author: StÃ©phane van Gulick
    Version: 3.1.0
    History:
    2018.10.30;@ChristopheKumor;Updated to version 3.0
        2018.04.08;Stephanevg; Updated to version 1.0: Updated content block to support string & ScriptBlock
        2018.03.25;@Stephanevg; Creation
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [Cmdletbinding()]
    Param(
        [Parameter(Mandatory = $false)]
        [AllowEmptyString()]
        [AllowNull()]
        $Content,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class,

        [String]$Id,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Style,

        [Hashtable]$Attributes
    )

    Process {
        $tagname = "h6"
        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid
    }
}
Function head {
    <#
    .SYNOPSIS
    Generates a head HTML tag.

    .DESCRIPTION


    The <head> element is a container for all the head elements.

    The <head> element can include a title for the document, scripts, styles, meta information, and more.

    The following elements can go inside the <head> element:

    <title> (this element is required in an HTML document)
    <style>
    <base>
    <link>
    <meta>
    <script>
    <noscript>

    (Source --> https://www.w3schools.com/tags/tag_head.asp)

    .PARAMETER Class
    Allows to specify one (or more) class(es) to assign the html element.
    More then one class can be assigned by seperating them with a white space.

    .PARAMETER Id
    Allows to specify an id to assign the html element.

    .PARAMETER Style
    Allows to specify in line CSS style to assign the html element.

    .PARAMETER Content
    Allows to add child element(s) inside the current opening and closing HTML tag(s).

    .NOTES
    Current version 3.1
    History:
    2018.10.30;@ChristopheKumor;Updated to version 3.0
        2018.04.10;Stephanevg; Added parameters
        2018.04.01;Stephanevg;Creation.
    .LINK
        https://github.com/Stephanevg/PSHTML
#>
    Param(
        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $false,
            Position = 0
        )]
        $Content,

        [Parameter(Position = 1)]
        [String]$Class,

        [Parameter(Position = 2)]
        [String]$Id,

        [Parameter(Position = 3)]
        [String]$Style,

        [Parameter(Position = 4)]
        [Hashtable]$Attributes
    )

    Process {
        $tagname = "head"
        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid
    }

}
Function header {
    <#
    .SYNOPSIS
    Generates a header HTML tag.

    .DESCRIPTION


    The <header> element represents a container for introductory content or a set of navigational links.

    A <header> element typically contains:

    one or more heading elements (<h1> - <h6>)
    logo or icon
    authorship information
    You can have several <header> elements in one document.

    (Source -> https://www.w3schools.com/tags/tag_header.asp)

    .PARAMETER Class
    Allows to specify one (or more) class(es) to assign the html element.
    More then one class can be assigned by seperating them with a white space.

    .PARAMETER Id
    Allows to specify an id to assign the html element.

    .PARAMETER Style
    Allows to specify in line CSS style to assign the html element.

    .PARAMETER Content
    Allows to add child element(s) inside the current opening and closing HTML tag(s).


    .EXAMPLE
    header {
            h1 "This is h1 Title in header"
            h2 "This is h2 Title in header"
            p "Some text in paragraph"
    }

    Generates the following code

    <header>
        <h1>
        This is h1 Title in header
        </h1>
        <h2>
        This is h2 Title in header
        </h2>
        <p>
        Some text in paragraph
        </p>
    </header>


    .NOTES
    Current version 3.1.0
    History:
    2018.10.30;@ChristopheKumor;Updated to version 3.0
        2018.04.10;Stephanevg; Added parameters
        2018.04.01;Stephanevg;Creation.
    .LINK
        https://github.com/Stephanevg/PSHTML
#>
    Param(
        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $false,
            Position = 0
        )]
        $Content,

        [Parameter(Position = 1)]
        [String]$Class,

        [Parameter(Position = 2)]
        [String]$Id,

        [Parameter(Position = 3)]
        [String]$Style,

        [Parameter(Position = 4)]
        [Hashtable]$Attributes
    )

    Process {
        $tagname = "header"
        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid
    }
}
Function hr {
    <#
    .SYNOPSIS
    Create a hr title in an HTML document.

    .EXAMPLE

    hr

    #Generates the following code:

    <hr>

    .EXAMPLE

    hr -Attributes @{"Attribute1"="val1";"Attribute2"="val2"}

    Generates the following code

    <hr Attribute1="val1" Attribute2="val2"  >

    .EXAMPLE

    $Style = "font-family: arial; text-align: center;"
    hr -Style $style

    Generates the following code

    <hr Style="font-family: arial; text-align: center;"  >

    .Notes
    Author: StÃ©phane van Gulick
    Version: 2.0.0
    History:
    2018.10.30;@ChristopheKumor;Updated to version 3.0
        2018.04.08;bateskevin; Updated to v2.0 
        2018.04.08;Stephanevg; Updated to version 1.0: Updated content block to support string & ScriptBlock
        2018.03.25;@Stephanevg; Added Styles, ID, CLASS attributes functionality
        2018.03.25;@Stephanevg; Creation
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [Cmdletbinding()]
    Param(

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class,

        [String]$Id,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Style,

        [Hashtable]$Attributes
    )

    Process {
        $tagname = "hr"

        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType void
        
    }

}
Function html {
    <#
    .SYNOPSIS
    Generates a html HTML tag.

    .DESCRIPTION

    The <html> tag tells the browser that this is an HTML document.

    The <html> tag represents the root of an HTML document.

    The <html> tag is the container for all other HTML elements (except for the <!DOCTYPE> tag).

    Detailed information can be found here --> https://www.w3schools.com/tags/tag_html.asp

    .PARAMETER Class
    Allows to specify one (or more) class(es) to assign the html element.
    More then one class can be assigned by seperating them with a white space.

    .PARAMETER Id
    Allows to specify an id to assign the html element.

    .PARAMETER Style
    Allows to specify in line CSS style to assign the html element.

    .PARAMETER Content
    Allows to add child element(s) inside the current opening and closing HTML tag(s).


    .EXAMPLE


    .NOTES
    Current version 3.1.0
    History:
    2018.10.30;@ChristopheKumor;Updated to version 3.0
        2018.04.10;Stephanevg; Added parameters
        2018.04.01;Stephanevg;Creation.
    .LINK
        https://github.com/Stephanevg/PSHTML
#>
    Param(

        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $false,
            Position = 0
        )]
        [AllowEmptyString()]
        [AllowNull()]
        $Content,

        [Parameter(Position = 1)]
        [String]$Class,

        [Parameter(Position = 2)]
        [String]$Id,

        [Parameter(Position = 3)]
        [String]$Style,

        [Parameter(Position = 4)]
        [Hashtable]$Attributes,

        [String]$xmlns
    )

    Process {
        $tagname = "html"
        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid
    }
}
Function i {
    <#
        .SYNOPSIS

        Generates a <i> HTML tag.
        The <a> tag defines a hyperlink, which is used to link from one page to another.
        
        .DESCRIPTION

        .PARAMETER Class
        Allows to specify one (or more) class(es) to assign the html element.
        More then one class can be assigned by seperating them with a white space.

        .PARAMETER Id
        Allows to specify an id to assign the html element.

        .PARAMETER Content
        Allows to add child element(s) inside the current opening and closing HTML tag(s).


        .EXAMPLE
        The following exapmles show cases how to create an empty i, with a class, an ID, and, custom attributes.
        
        i -Class "myclass1 MyClass2" -Id myid -Attributes @{"custom1"='val1';custom2='val2'}

        Generates the following code:

        <i Class="myclass1 MyClass2" Id="myid" custom1="val1" custom2="val2"  >
        </i>


        .NOTES
        Current version 3.1
        History:
            2019.06.19;@Josh_Burkard;initial version
        .LINK
            https://github.com/Stephanevg/PSHTML
    #>

    Param(

        [Parameter(Mandatory = $false)]
        [AllowEmptyString()]
        [AllowNull()]
        $Content,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class,

        [String]$Id,
        
        [Hashtable]$Attributes

    )
    $tagname = "i"

    Set-htmltag -TagName $tagName -Parameters $PSBoundParameters -TagType NonVoid
    
    

}
 
Function img {
    <#
        .SYNOPSIS
        Generates a html img tag.

        .DESCRIPTION

        The <img> tag defines an image in an HTML page.

        The <img> tag has two required attributes: src and alt.

        .PARAMETER SRC

        Defines the source location of the image

        .PARAMETER ALT

        Alternative display when the image cannot be displayed.

        .PARAMETER Class
        Allows to specify one (or more) class(es) to assign the img element.
        More then one class can be assigned by seperating them with a white space.

        .PARAMETER Id
        Allows to specify an id to assign the img element.

        .PARAMETER Style
        Allows to specify in line CSS style to assign the img element.

        .PARAMETER Content
        Allows to add child element(s) inside the current opening and closing img tag(s).


        .EXAMPLE


        .NOTES
        Current version 3.1
        History:
        2018.10.30;@ChristopheKumor;Updated to version 3.0
            2018.10.10;Stephanevg; Updated code to version 2.0
            2018.05.07;Stephanevg; Updated code to version 1.0
            2018.04.01;Stephanevg;Creation.
        .LINK
            https://github.com/Stephanevg/PSHTML
    #>

    Param(

        [Parameter(Mandatory = $false)]
        [String]
        $src = "",

        [Parameter(Mandatory = $false)]
        [string]
        $alt = "",

        [Parameter(Mandatory = $false)]
        [string]
        $height,

        [Parameter(Mandatory = $false)]
        [string]
        $width,

        [String]$Class,

        [String]$Id,

        [String]$Style,

        [Hashtable]$Attributes
    )


    $tagname = "img"

    Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType 'void'

}
Function input {
    
    <#
    .SYNOPSIS
    Generates input HTML tag.
    .DESCRIPTION
    The <input> tag specifies an input field where the user can enter data.

    <input> elements are used within a <form> element to declare input controls that allow users to input data.

    An input field can vary in many ways, depending on the type attribute.

    Note: The <input> element is empty, it contains attributes only.

    Tip: Use the <label> element to define labels for <input> elements.

    More info: https://www.w3schools.com/tags/tag_input.asp
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [CmdletBinding()]
    Param(

        #Need to add the other ones from --> https://www.w3schools.com/tags/tag_input.asp
        [Parameter(Mandatory = $true, Position = 0)]
        [ValidateSet("button", "checkbox", "color", "date", "datetime-local", "email", "file", "hidden", "image", "month", "number", "password", "radio", "range", "reset", "search", "submit", "tel", "text", "time", "url", "week")]
        [String]$type,

        [Parameter(Mandatory = $true, Position = 1)]
        [String]$name,

        [Parameter(Mandatory = $false, Position = 2)]
        [switch]$required,

        [Parameter(Mandatory = $false, Position = 3)]
        [switch]$readonly,

        [Parameter(Position = 4)]
        [String]$Class,

        [Parameter(Position = 5)]
        [String]$Id,

        [Parameter(Position = 6)]
        [String]$Style,

        [Parameter(Position = 7)]
        [String]$value,

        [Parameter(Position = 8)]
        [Hashtable]$Attributes
    )

    Process {
        $tagname = "input"
        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType Void
    }

}
function Install-PSHTMLVSCodeSnippets {
    <#
    .SYNOPSIS
        Copy the PSHTML VSCode Snippets to the right location
    .DESCRIPTION
        Gets the PSHTML VSCode snippet files and copies them to users appdata folder

    .EXAMPLE

    .EXAMPLE



    .NOTES
            Current version 1.0
            History:
            2018.10.21;Stephanevg;Fix wrong path due to module restrucutre.
            2018.10.17;stephanev;updated to v 1.0 - added error handling, and -force parameter
            2018.10.16;FishFenly;Creation.
    #>
    [CmdletBinding()]
    Param(
        [String]$Path ,
        [Switch]$Force
    )


    if(!($Path)){

        if($IsLinux){
            $Path = "$($home)/vscode/Snippets/"
        }else{
            $Path = "$($env:APPDATA)\Code\User\Snippets"
        }
    }

    $ModuleRoot = Get-ModuleRoot

    Write-verbose "Module Root is: $($ModuleRoot)"

   
    $snippetsfolder = join-path $ModuleRoot -ChildPath "Snippets"

    $AllSnipets = Get-childItem -path $snippetsfolder

    if(!(Test-Path $Path)){
        $Null = New-Item -Path $Path -ItemType Directory -Force
    }

    $Paras = @{}
    $Paras.Destination = $Path
    $Paras.errorAction =  "Stop"
    #$Paras.Force = $true
    $Paras.Recurse = $true
    
    if($Force){
        $Paras.Force = $true
    }

    if($AllSnipets){
        foreach ($snippet in $AllSnipets) {
            $Paras.Path = $null
            $Paras.Path = $snippet.FullName 
            Write-Verbose "Copying $($snippet.FullName) to $($Paras.Destination)"
            try {
                Copy-Item @Paras
            }Catch{
                
                    Write-warning "$_"
            }
        }
    }else{
        write-warning "No snippts found in $SnippetsFolder"
    }
}
Function Keygen {
    <#
    .SYNOPSIS
    Create a Keygen tag in an HTML document.

    .DESCRIPTION

    The name attribute specifies the name of a <keygen> element.

    The name attribute of the <keygen> element is used to reference form data after the form has been submitted.

    .EXAMPLE

     keygen -Name "Secure"

     Returns:

    <Keygen Name="Secure"  />

    .NOTES
    Current version 3.1
       History:
       2018.10.30;@ChristopheKumor;Updated to version 3.0
            2018.10.10;Stephanevg;Creation.
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [Cmdletbinding()]
    Param(
        
        [AllowEmptyString()]
        [AllowNull()]
        [String]$Name = "",

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class = "",

        [String]$Id,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Style,

        [String]$title,

        [Hashtable]$Attributes
    )

    Process {
        $tagname = "Keygen"

        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType Void
    }
}
Function label {
    <#
    .SYNOPSIS
    Creates a <label> HTML element tag


    .EXAMPLE

    label
    .EXAMPLE
    label "woop1" -Class "class"

    .EXAMPLE

    <form>
    <fieldset>
        <label>Personalia:</label>
        Name: <input type="text" size="30"><br>
        Email: <input type="text" size="30"><br>
        Date of birth: <input type="text" size="10">
    </fieldset>
    </form>

    .Notes
    Author: StÃ©phane van Gulick
    Version: 1.0.0
    History:
    2018.10.30;@ChristopheKumor;Updated to version 3.0
        2018.05.09;@Stephanevg; Creation
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [Cmdletbinding()]
    Param(
        [Parameter(Mandatory = $false)]
        [AllowEmptyString()]
        [AllowNull()]
        $Content,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class,

        [String]$Id,

        [Hashtable]$Attributes
    )


    $tagname = "label"

    Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid



}
Function legend {
    <#
    .SYNOPSIS
    The <legend> tag defines a caption for the <fieldset> element.


    .EXAMPLE

    legend
    .EXAMPLE
    legend "woop1" -Class "class"

    .EXAMPLE

    <form>
    <fieldset>
        <legend>Personalia:</legend>
        Name: <input type="text" size="30"><br>
        Email: <input type="text" size="30"><br>
        Date of birth: <input type="text" size="10">
    </fieldset>
    </form>

    .Notes
    Author: StÃ©phane van Gulick
    Version: 3.1.0
    History:
    2018.10.30;@ChristopheKumor;Updated to version 3.0
        2018.05.09;@Stephanevg; Creation
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [Cmdletbinding()]
    Param(
        [Parameter(Mandatory = $false)]
        [AllowEmptyString()]
        [AllowNull()]
        $Content,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class,

        [String]$Id,

        [Hashtable]$Attributes
    )

    $tagname = "legend"

    Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid



}
Function li {
    <#
    .SYNOPSIS
    Create a li tag in an HTML document.

    .DESCRIPTION
        he <li> tag defines a list item.

        The <li> tag is used in ordered lists(<ol>), unordered lists (<ul>), and in menu lists (<menu>).
    .EXAMPLE

    li
    .EXAMPLE
    li "woop1" -Class "class"

    .EXAMPLE
    li "woop2" -Class "class" -Id "Something"

    .EXAMPLE
    li "woop3" -Class "class" -Id "something" -Style "color:red;"

    .EXAMPLE

    The following code snippet will get all the 'snoverism' from www.snoverisms.com and put them in an UL.

        $Snoverisms += (Invoke-WebRequest -uri "http://snoverisms.com/page/2/").ParsedHtml.getElementsByTagName("p") | Where-Object -FilterScript {$_.ClassName -ne "site-description"} | Select-Object -Property innerhtml

        ul -id "snoverism-list" -Content {
            Foreach ($snov in $Snoverisms){

                li -Class "snoverism" -content {
                    $snov.innerHTML
                }
            }
        }


    .NOTES
    Current version 3.1.0
       History:
       2018.10.30;@ChristopheKumor;Updated to version 3.0
        2018.10.02;bateskevin;Updated to v2
        2018.04.14;stephanevg;Added Attributes parameter. Upgraded to v1.1.1
        2018.04.14;stephanevg;fix Content bug. Upgraded to v1.1.0
        2018.04.01;bateskevinhanevg;Creation.
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [Cmdletbinding()]
    Param(

        [Parameter(Mandatory = $false, Position = 0)]
        [AllowEmptyString()]
        [AllowNull()]
        $Content,

        [Parameter(Position = 1)]
        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class = "",

        [Parameter(Position = 2)]
        [String]$Id,

        [Parameter(Position = 3)]
        [AllowEmptyString()]
        [AllowNull()]
        [String]$Style,

        [Parameter(Position = 4)]
        [Hashtable]$Attributes,

        [Parameter(Position = 5)]
        [int]$Value
    )

    Process {
        $tagname = "li"

        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid
        
    }


}
Function Link {
    <#
    .SYNOPSIS
    Create a link title in an HTML document.

    .EXAMPLE

    link

    #Generates the following code:

    <link>

    .EXAMPLE

    link -Attributes @{"Attribute1"="val1";"Attribute2"="val2"}

    Generates the following code

    <link Attribute1="val1" Attribute2="val2"  >

    .EXAMPLE

    $Style = "font-family: arial; text-align: center;"
    link -Style $style

    Generates the following code

    <link Style="font-family: arial; text-align: center;"  >

    .Notes
    Author: StÃ©phane van Gulick
    Version: 3.1.0
    History:
    2018.10.30;@ChristopheKumor;Updated to version 3.0
        2018.04.08;Stephanevg; Updated to version 1.0: Updated content block to support string & ScriptBlock
        2018.03.25;@Stephanevg; Added Styles, ID, CLASS attributes functionality
        2018.03.25;@Stephanevg; Creation
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    Param(
        [Parameter(Mandatory = $true)]
        [String]
        $href,

        [AllowEmptyString()]
        [AllowNull()]
        $type,

        [Parameter(Mandatory = $False)]
        [Validateset("alternate", "author", "dns-prefetch", "help", "icon", "license", "next", "pingback", "preconnect", "prefetch", "preload", "prerender", "prev", "search", "stylesheet")]
        [string]
        $rel,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Integrity,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$CrossOrigin,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class,

        [String]$Id,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Style,

        [Hashtable]$Attributes
    )


    Process {
        $tagname = "link"
        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType Void
    }

}

Function map {
    <#
    .SYNOPSIS
    Generates map HTML tag.

    .DESCRIPTION
    The map must be used in conjunction with area. Pass an 'area' parameter with its arguments in the 'Content' parameter

    .EXAMPLE

    map -Content {area -href "map.png" -coords "0,0,50,50" -shape circle -target top }

    Generates the following code

    <map>
        <area href="map.png" coords="0,0,50,50" shape="circle" target="top" >
    </map>

    .NOTES
        Version: 3.1.0

    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [CmdletBinding()]
    Param(

        [Parameter(Position = 1)]
        [String]$Class,

        [Parameter(Position = 2)]
        [String]$Id,

        [Parameter(Position = 3)]
        [String]$Style,

        [Parameter(Position = 4)]
        [Hashtable]$Attributes,

        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $false,
            Position = 5
        )]
        [scriptblock]
        $Content
    )

    Process {
        $tagname = "map"
        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid
    }
}
Function math {
    <#
    .SYNOPSIS
    Create a math tag in an HTML document.

    .EXAMPLE
    
    math -dir ltr -MathbackGround "#234"

    #Generates the following

    <math dir="ltr" MathbackGround="#234"  >
    </math>

    .EXAMPLE
    
     math -dir ltr -MathbackGround "#234" -Display Inline -Overflow linebreak
    
     #Generates the following

     <math Overflow="linebreak" dir="ltr" Display="Inline" MathbackGround="#234"  >
    </math>

    .NOTES
    Current version 3.1.0
       History:
       2018.10.30;@ChristopheKumor;Updated to version 3.0
            2018.04.01;stephanevg;Creation.
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [Cmdletbinding()]
    Param(

        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $false,
            Position = 0
        )]
        [AllowEmptyString()]
        [AllowNull()]
        $Content,

        [ValidateSet("ltr", "rtl")]
        [AllowEmptyString()]
        [AllowNull()]
        [String]$dir = "",

        [AllowEmptyString()]
        [AllowNull()]
        [String]$href = "",

        [AllowEmptyString()]
        [AllowNull()]
        [String]$MathbackGround = "",

        [AllowEmptyString()]
        [AllowNull()]
        [String]$MathColor = "",

        [ValidateSet("Block", "Inline")]
        [AllowEmptyString()]
        [AllowNull()]
        [String]$Display = "",


        [ValidateSet("linebreak", "scrolle", "elide", "truncate", "scale")]
        [AllowEmptyString()]
        [AllowNull()]
        [String]$Overflow,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class = "",

        [String]$Id,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Style,

        [String]$title,

        [Hashtable]$Attributes
    )

    Begin {

        $tagname = "math"
    }
    Process {       

        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid
    }
}

Function meta {
    <#
    .SYNOPSIS
    Create a meta title in an HTML document.

    .DESCRIPTION

    Metadata is data (information) about data.

    The <meta> tag provides metadata about the HTML document. Metadata will not be displayed on the page, but will be machine parsable.

    Meta elements are typically used to specify page description, keywords, author of the document, last modified, and other metadata.

    The metadata can be used by browsers (how to display content or reload page), search engines (keywords), or other web services.

    (source --> https://www.w3schools.com/tags/tag_meta.asp)
    .EXAMPLE

    meta
    .EXAMPLE
    meta "woop1" -Class "class"

    .EXAMPLE
    meta "woop2" -Class "class" -Id "MainTitle"

    .EXAMPLE
    meta {"woop3"} -Class "class" -Id "MaintTitle" -Style "color:red;"

    .EXAMPLE

    meta -name author -content "Stephane van Gulick"

    Generates the following code:

    <meta name="author" content="Stephane van Gulick"  >

    .Notes
    Author: StÃ©phane van Gulick
    Version: 3.1.0
    History:
    2018.10.30;@ChristopheKumor;Updated to version 3.0
        2018.04.14;@Stephanevg; Creation
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [Cmdletbinding()]
    Param(
        [Parameter(Mandatory = $false)]
        [AllowEmptyString()]
        [AllowNull()]
        [string]$content_tag,

        [Parameter(Mandatory = $false)]
        [AllowEmptyString()]
        [AllowNull()]
        [string]$charset,

        [ValidateSet("content-type", "default-style", "refresh")]
        [Parameter(Mandatory = $false)]
        [AllowEmptyString()]
        [AllowNull()]
        [string]$httpequiv,

        [ValidateSet("application-name", "author", "description", "generator", "keywords", "viewport")]
        [Parameter(Mandatory = $false)]
        [AllowEmptyString()]
        [AllowNull()]
        [string]$name,

        [Parameter(Mandatory = $false)]
        [AllowEmptyString()]
        [AllowNull()]
        [string]$scheme,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$class,

        [String]$id,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Style,

        [Hashtable]$Attributes
    )

    Process {
        $tagname = "meta"
        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType Void
    }
}
Function meter {
    <#
    .SYNOPSIS
    Create a meter tag in an HTML document.

    .DESCRIPTION

    The <meter> tag defines a scalar measurement within a known range, or a fractional value. This is also known as a gauge.

    Examples: Disk usage, the relevance of a query result, etc.

    Note: The <meter> tag should not be used to indicate progress (as in a progress bar). For progress bars, use the <progress> tag.

    .EXAMPLE
    
    <meter Min="0" Value="58" Max="100"  >
    Represents 58%
    </meter>

    .EXAMPLE
     meter -Value 0.75

     Returns:

    <meter Value="0.75"  >
    </meter>

    .NOTES
    Current version 3.1.0
       History:
    2018.10.30;@ChristopheKumor;Updated to version 3.0
            2018.10.10;stephanevg;Creation.
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [Cmdletbinding()]
    Param(

        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $false,
            Position = 0
        )]
        [AllowEmptyString()]
        [AllowNull()]
        $Content,

        [Parameter(Mandatory = $false)]
        [AllowEmptyString()]
        [AllowNull()]
        [String]
        $Value,

        [Parameter(Mandatory = $false)]
        [AllowEmptyString()]
        [AllowNull()]
        [String]
        $Min,

        [Parameter(Mandatory = $false)]
        [AllowEmptyString()]
        [AllowNull()]
        [String]
        $Max,

        [string]$cite,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class = "",

        [String]$Id,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Style,

        [String]$title,

        [Hashtable]$Attributes
    )

    Process {

        $tagname = "meter"

        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid
    }
}
Function nav {
    <#
    .SYNOPSIS
    Generates nav HTML tag.

    .EXAMPLE

    nav -Content {
        a -href "\home.html" -Target _blank
        a -href "\about.html" -Target _blank
        a -href "\blog.html" -Target _blank
        a -href "\contact.html" -Target _blank
    }

    Generates the following code:

    <nav>
        <a href=\home.html target="_blank" ></a>
        <a href=\about.html target="_blank" ></a>
        <a href=\blog.html target="_blank" ></a>
        <a href=\contact.html target="_blank" ></a>
    </nav>

    .EXAMPLE

    It is also possible to use regular powershell logic inside a scriptblock. The example below, generates a nav element
    based on values located in a array. The various links are build using a foreach loop.

    $Pages = "home.html","login.html","about.html"
    nav -Content {
        foreach($page in $pages){
            a -href "\$($page)" -Target _blank
        }

    } -Class "mainnavigation" -Style "border 1px"

    Generates the following code:

    <nav Class="mainnavigation" Style="border 1px" >
        <a href=\home.html target="_blank" >
        </a>
        <a href=\login.html target="_blank" >
        </a>
        <a href=\about.html target="_blank" >
        </a>
    </nav>

    .Notes
    Author: StÃ©phane van Gulick
    Version: 3.1.0
    History:
    2018.10.30;@ChristopheKumor;Updated to version 3.0
        2018.05.09;@Stephanevg; Creation
        2018.05.21;@Stephanevg; Updated function to use New-HTMLTag

    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [CmdletBinding()]
    Param(

        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $true,
            Position = 0
        )]
        $Content,

        [Parameter(Position = 1)]
        [String]$Class,

        [Parameter(Position = 2)]
        [String]$Id,

        [Parameter(Position = 3)]
        [String]$Style,

        [Parameter(Position = 4)]
        [Hashtable]$Attributes

    )
    $tagname = "nav"

    Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid
    


}


Function New-PSHTMLCDNAssetFile {
    <#
    .SYNOPSIS
        Allows to create a CDN file.
        
    .DESCRIPTION
        Creates a .CDN file to use as a PSHTML Asset.
        The CDN file is automatically supported by Write-PSHTMLAsset and will create the CDN automatically based on the content of the CDN file.

    .PARAMETER TYPE
    Specify if the Asset should cover Script or Style references
    Parameters allowd: Script / Style

    .PARAMETER Source

    Specify the src attribute of a script tag.

    .PARAMETER Rel

    Specify the rel attribute of a link tag.

    .PARAMETER Href

    Specify the href attribute of a link tag.

    .PARAMETER Integrity

    Specify the integrity attribute.

    .PARAMETER CrossOrigin

    Specify the CrossOrigin attribute.

    .PARAMETER Path

    Specify in which folder path the file should be created (will use the parameter FileName to create the full path)

    .PARAMETER FileName

    Specify the name of the file that the cdn asset file will have (will use the parameter Path to create the full path).
    The FileName should end with the extension .CDN 
    If the extension .CDN is omitted, PSHTML will dynamically add it

    .EXAMPLE
        Add the latest version of Bootstrap CDN
        #Information of this example comes from -> https://getbootstrap.com/docs/4.3/getting-started/introduction/

        $Source = 'https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js'
        $Integrity = 'sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM'
        $CrossOrigin = 'anonymous'
        $BootStrapFolder =  $home\BootStrap4.3.1
        New-PSHTMLCDNAssetFile -Type script -Source $Source -Integrity $Integrity -CrossOrigin $CrossOrigin -Path $BootStrapFolder -FileName 'BootStrap4.3.1.cdn'

    .EXAMPLE
        Adds the latest version of MetroUI as an CDN asset

        $Href = 'https://cdn.metroui.org.ua/v4/css/metro-all.min.css'
        $Folder =  $home\MetroUI\
        New-PSHTMLCDNAssetFile -Type style -href $href -Path $Folder -FileName 'MetroUI.cdn'

    .INPUTS
        Inputs (if any)
    .OUTPUTS
        System.IO.FileInfo
    .NOTES
        Author: Stephane van Gulick
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [CmdletBinding()]
    Param(
        [ValidateSet('Style','script')]
        [String]$Type,

        [Parameter(
            ParametersetName = "Script"
        )]
        [String]$source,

        [Parameter(
            ParametersetName = "Style"
        )]
        [String]$rel= "stylesheet",

        [Parameter(
            ParametersetName = "Style"
        )]
        [String]$href,

        [String]$Integrity,

        [String]$CrossOrigin,

        
        [Parameter(mandatory=$false)]
        [String]$FileName = (Throw "Please specifiy a file name"),

        [Parameter(mandatory=$false)]
        [String]$Path
    )

    $hash = @{}
    $Hash.Integrity = $Integrity
    $Hash.Crossorigin = $CrossOrigin
    
    switch($type){
        "Script" {

            $Hash.source = $Source
            break
        }
        "Style" {
            $Hash.rel = $rel
            $hash.href = $href
            break
        }
        default {"Type $($Type) no supported."}
    }

    If(!($FileName.EndsWith('.cdn'))){
        $FileName = $FileName + '.cdn'
    }

    $FilePath = Join-Path -Path $Path -ChildPath $FileName

    $obj = New-Object psobject -Property $hash

    $obj | ConvertTo-Json | out-file -FilePath $FilePath -Encoding utf8

    return Get-Item $FilePath

}
Function New-PSHTMLChart {
    <#
    
        .SYNOPSIS
            Creates a PSHMTL Chart.
    
        .DESCRIPTION
            Will render a Graph in Javascript using Chart.JS
    
        .PARAMETER Type
    
        Specifies the type of chart to generate.
    
        .EXAMPLE
    
            This example creates 3 different doughnut charts.
            In the oposite of a bar or line chart, mixing different datasets on the same doughnut chart won't be as much value as with the other types of charts.
            It is recommended to create a doughnut chart per dataset.
    
            $Data1 = @(34,7,11,19)
            $Data2 = @(40,2,13,17)
            $Data3 = @(53,0,0,4)
    
            $Labels = @("Closed","Unresolved","Pending","Open")
            $colors = @("Yellow","red","Green","Orange")
            $dsd1 = New-PSHTMLChartDoughnutDataSet -Data $data1 -label "March" -backgroundcolor $colors
            $dsd2 = New-PSHTMLChartDoughnutDataSet -Data $data2 -label "April" -BackgroundColor $colors
            $dsd3 = New-PSHTMLChartDoughnutDataSet -Data $data3 -label "Mai" -BackgroundColor $Colors
    
            New-PSHTMLChart -type doughnut -DataSet @($dsd1) -title "Doughnut Chart v1" -Labels $Labels -CanvasID $DoughnutCanvasID
            New-PSHTMLChart -type doughnut -DataSet @($dsd2) -title "Doughnut Chart v2" -Labels $Labels -CanvasID $DoughnutCanvasID
            New-PSHTMLChart -type doughnut -DataSet @($dsd3) -title "Doughnut Chart v3" -Labels $Labels -CanvasID $DoughnutCanvasID -tobase64
    #>
        [CmdletBinding()]
        Param(
            #[ValidateSet("Bar","horizontalBar","Line","Pie","doughnut", "radar", "polarArea")]
            [ChartType]$Type = $(Throw '-Type is required'),
    
            [dataSet[]]$DataSet = $(Throw '-DataSet is required'),
    
            [String[]]
            $Labels = $(Throw '-Labels is required'),
    
            [String]$CanvasID = $(Throw '-CanvasID is required'),
    
            [Parameter(Mandatory=$False)]
            [String]$Title,
    
            [ChartOptions]$Options
            #[switch]$tobase64 = $false

        )
    
    
    
    #Chart -> BarChart (?)
    switch($Type){
        "doughnut" {
            $Chart = [DoughnutChart]::New()
            $ChartOptions = [DoughnutChartOptions]::New()
            ;Break
        }
        "Pie" {
            $Chart = [PieChart]::New()
            $ChartOptions = [PieChartOptions]::New()
            ;Break
        }
        "Bar"{
            $Chart = [BarChart]::New()
            $ChartOptions = [BarChartOptions]::New()
            ;Break
        }
        "horizontalBar" {
            $Chart = [horizontalBarChart]::New()
            $ChartOptions = [horizontalBarChartOptions]::New()
            ;Break
        }
        "Line"{
            $Chart = [LineChart]::New()
            $ChartOptions = [LineChartOptions]::New()
            
            ;Break
        }
        "radar"{
            $Chart = [RadarChart]::New()
            $ChartOptions = [RadarChartOptions]::New()
            
            ;Break
        }
        "polarArea" {
            $Chart = [polarAreaChart]::New()
            $ChartOptions = [polarAreaChartOptions]::New()
            
            ;Break
        }
        default{
            Throw "Graph type not supported. Please use a valid value from Enum [ChartType]"
        }
    }
    
    if($Responsive){
    
    }
    
        #Type [String]
            #[ENUM]ChartType
        #Data [ChartData]
            #Labels
            #DataSets
        $ChartData = [ChartData]::New()
        #Hack to avoid to have a 'null' value displayed in the graph 
        #This could be fixed by not creating a new empty DataSet on construction.(Just in case, if you have time ;)
            #$ChartData.datasets = $null 
            $Chartdata.datasets.RemoveAt(0) #Removing null one.
    
                #$DataSet1.backgroundColor = [Color]::blue
                foreach($ds in $dataSet){
    
                    $ChartData.AddDataSet($ds)
                }
                
                $ChartData.SetLabels($Labels)
                $Chart.SetData($ChartData)
        #Options [ChartOptions]
           
            
            if($Title){
    
                $ChartOptions.Title.Display = $true
                $ChartOptions.Title.text = $Title
            }
            if ($tobase64) {
                $ChartOptions.animation.onComplete = 'RemoveCanvasAndCreateBase64Image'
            }
            $Chart.SetOptions($ChartOptions)
            $Chart.GetDefinition($CanvasID)
    
            <#
            Chunk ready for 8.1

            if ($tobase64) {
                script -content {
                    $Chart.GetDefinition($CanvasID,$true)
                } -Id "pshtml_script_chart_$CanvasID"
            } else {
                script -content {
                    $Chart.GetDefinition($CanvasID)
                } -Id "pshtml_script_chart_$CanvasID"
            }
            #>
        
    
    }
    
function New-PSHTMLChartBarDataSet {
    <#
    .SYNOPSIS
        Create a dataset object for a Bar chart
    .DESCRIPTION
        Use this function to generate a Dataset for a bar chart. 
        It allows to specify options such as, the label name, Background / border / hover colors etc..
    .EXAMPLE
       
    .PARAMETER Data
        Specify an array of values.
        ex: @(3,5,42,69)
    .PARAMETER Label
        Name of the dataset
    .PARAMETER xAxisID
        X axis ID 
    .PARAMETER yAxisID
        Y axis ID 
    .PARAMETER BackgroundColor
        The background color of the bar chart values.
        Use either: [Color] to generate a color,
        Or specify directly one of the following formats:
        RGB(120,240,50)
        RGBA(120,240,50,0.4)
    .PARAMETER BorderColor
        The border color of the bar chart values.
        Use either: [Color] to generate a color,
        Or specify directly one of the following formats:
        RGB(120,240,50)
        RGBA(120,240,50,0.4)
    .PARAMETER BorderWidth
        expressed in px's
    .PARAMETER BorderSkipped
        border is skipped

    .PARAMETER HoverBorderColor
        The HoverBorder color of the bar chart values.
        Use either: 
        [Color] to generate a color,
        Or specify directly one of the following formats:
        RGB(120,240,50)
        RGBA(120,240,50,0.4)
    .EXAMPLE
            $Data1 = @(34,7,11,19)
            $dsb1 = New-PSHTMLChartBarDataSet -Data $data1 -label "March" -BackgroundColor ([Color]::Orange)

            #Dataset containg data from 'March'
            
    .EXAMPLE

            $Data2 = @(40,2,13,17)
            $dsb2 = New-PSHTMLChartBarDataSet -Data $data2 -label "April" -BackgroundColor ([Color]::red)

            #DataSet Containg data from 'April'
    
    .OUTPUTS
        DataSetBar
    .NOTES
        Made with love by Stephanevg
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [CmdletBinding()]
    [OutputType([datasetBar])]
    param (
        [Array]$Data,
        [String]$label,
        [String] $xAxisID,
        [String] $yAxisID,
        [string]  $backgroundColor,
        [string]  $borderColor,
        [int]    $borderWidth = 1,
        [String] $borderSkipped,
        [string]  $hoverBackgroundColor,
        [string]  $hoverBorderColor,
        [int]    $hoverBorderWidth
        

    )
    
    $Datachart = [datasetBar]::New()

    if($Data){
        $null = $Datachart.AddData($Data)
    }

    If($Label){
        $Datachart.label = $label
    }

    if($xAxisID){
        $Datachart.xAxisID = $xAxisID
    }

    if($yAxisID){
        $Datachart.yAxisID = $yAxisID
    }

    if($backgroundColor){
        $Datachart.backgroundColor = $backgroundColor
    }

    If($borderColor){
        $Datachart.borderColor = $borderColor
    }
    else {
        $Datachart.borderColor = ''
    }
    if ($borderWidth){
        $Datachart.borderWidth = $borderWidth
    }

    if($borderSkipped){
        $Datachart.borderSkipped = $borderSkipped
    }

    If($hoverBackgroundColor){
        $Datachart.hoverBackgroundColor = $hoverBackgroundColor
    }
    
    If($HoverBorderColor){
        $Datachart.hoverBorderColor = $HoverBorderColor
    }
    if($HoverBorderWidth){
        $Datachart.HoverBorderWidth = $HoverBorderWidth
    }

    return $Datachart
}
Function New-PSHTMLChartDataSet {
    <#
    .SYNOPSIS
        Creates a data set for any type of chart
    .DESCRIPTION
        This cmdlet must be used to format the data set to get data in correct fromat for any of the New-PSHTMLChart* cmdlets.

    .PARAMETER Name
        Name of the dataset.
    
    .PARAMETER Data
        Array of values 

    .EXAMPLE
        #Creating a simple dataset
         $Data = @("4","7","11","21")

         New-PSHTMLChartDataSet -Data $Data -Name "Grades"

    .EXAMPLE
         New-PSHTMLChartDataSet -Data @(1,2,3) -Name plop -BackgroundColor Blue -BorderColor Green -HoverBackgroundColor Red -hoverBorderColor Green -BorderWidth 3 -HoverBorderWidth 1 -xAxisID 0 -yAxisID 22 -borderSkipped bottom

        data                 : {1, 2, 3}
        label                : plop
        xAxisID              : 0
        yAxisID              : 22
        backgroundColor      : rgb(30,144,255)
        borderColor          : rgb(173,255,47)
        borderWidth          : 0
        borderSkipped        : bottom
        hoverBackgroundColor : rgb(220,20,60)
        hoverBorderColor     : rgb(173,255,47)
        hoverBorderWidth     : 0

    .EXAMPLE
        #Creating a simple dataset and creating a chart
        $Data = @("4","7","11","21")

        $DataSet = New-PSHTMLChartDataSet -Data $Data -Name "Grades"

        $Labels = @("Math","History","Sport","French")
        New-PSHTMLBarChart -DataSet $DataSet -Labels $Labels -CanvasID "Canvas01" -Title "Schoold grades"
    .INPUTS
        Inputs (if any)
    .OUTPUTS
        [DataSet]
    .NOTES
        Author: StÃ©phane van Gulick
    #>
    [CmdletBInding()]
    Param(
        [Parameter(Mandatory=$true)]
        [Array]$Data,

        [Parameter(Mandatory=$true)]
        [String]$Name,

        [Parameter(Mandatory=$false)]
        [Parameter(ParameterSetName="Line")]
        [Parameter(ParameterSetName="Bar")]
        [Parameter(ParameterSetName="Pie")]
        [Parameter(ParameterSetName="Doughnut")]
        [ValidateSet("Blue","Red","Yellow","Green")]
        $BackgroundColor,

        [Parameter(Mandatory=$false)]
        [Parameter(ParameterSetName="Line")]
        [Parameter(ParameterSetName="Bar")]
        [Parameter(ParameterSetName="Pie")]
        [Parameter(ParameterSetName="Doughnut")]
        [ValidateSet("Blue","Red","Yellow","Green")]
        $BorderColor,

        [Parameter(Mandatory=$false)]
        [ValidateSet("Blue","Red","Yellow","Green")]
        [Parameter(ParameterSetName="Bar")]
        [Parameter(ParameterSetName="Pie")]
        [Parameter(ParameterSetName="Doughnut")]
        #Not line
        $HoverBackgroundColor,

        [Parameter(Mandatory=$false)]
        [ValidateSet("Blue","Red","Yellow","Green")]
        [Parameter(ParameterSetName="Bar")]
        [Parameter(ParameterSetName="Pie")]
        [Parameter(ParameterSetName="Doughnut")]
        #Not line 
        $hoverBorderColor,

        [Parameter(Mandatory=$false)]
        [Parameter(ParameterSetName="Line")]
        [Parameter(ParameterSetName="Bar")]
        [Parameter(ParameterSetName="Pie")]
        [Parameter(ParameterSetName="Doughnut")]
        [int]
        $BorderWidth,

        [Parameter(Mandatory=$false)]
        [Parameter(ParameterSetName="Bar")]
        [Parameter(ParameterSetName="Pie")]
        [Parameter(ParameterSetName="Doughnut")]
        #Not Line 
        [int]
        $HoverBorderWidth,

        [Parameter(Mandatory=$false)]
        [Parameter(ParameterSetName="Line")]
        #Not in Bar,Pie & Doughnut
        [String]
        $xAxisID,

        [Parameter(Mandatory=$false)]
        [Parameter(ParameterSetName="Line")]
        #Not in Bar,Pie & Doughnut
        [String]
        $yAxisID,

        [ValidateSet("top","bottom","Left","right")]
        [Parameter(ParameterSetName="Bar")]
        #Not Line,Pie & Doughnut
        [String]
        $borderSkipped
    )

        $dataSet = [dataSet]::New($Data,$Name)
        if($BackgroundColor){

            $dataSet.backgroundColor = [Color]::$BackgroundColor
        }

        if($HoverBackgroundColor){

            $dataSet.HoverBackgroundColor = [Color]::$HoverBackgroundColor
        }

        if($hoverBorderColor){

            $dataSet.hoverBorderColor = [Color]::$hoverBorderColor
        }

        if($BorderColor){

            $dataSet.BorderColor = [Color]::$BorderColor
        }

        if($yAxisID){

            $dataSet.yAxisID = $yAxisID
        }

        if($xAxisID){

            $dataSet.XAxisID = $xAxisID
        }

        if($borderSkipped){

            $dataSet.borderSkipped = $borderSkipped
        }

        return $dataset
    
}

function New-PSHTMLChartDoughnutDataSet {
    <#
    .SYNOPSIS
        Create a dataset object for a dougnut chart
    .DESCRIPTION
        Create a dataset object for a dougnut chart

    .PARAMETER HoverBordercolor
        Accepts RGB values:
        Examples: RGB(255,255,0)

        Accepts RGBA values:
        Examples: RGBA(255,255,0,0.4)

        Accept color names:

        (Must be a lower case values)
        
        Examples:
        white,black,orange,red,blue,green,gray,cyan


    .EXAMPLE
       
    .INPUTS
        Inputs (if any)
    .OUTPUTS
        DataSetLine
    .NOTES
    
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [CmdletBinding()]
    param (
        [Array]$Data,
        [String]$label,
        [Array]$backgroundColor,
        [String]$borderColor,
        [int]$borderWidth = 1,
        [Array]$hoverBackgroundColor,
        [Array]$HoverBorderColor,
        [int]$HoverBorderWidth
        

    )
    
    $Datachart = [datasetdoughnut]::New()

    if($Data){
        $Null =$Datachart.AddData($Data)
    }

    If($Label){
        $Datachart.label = $label
    }

    if($backgroundColor){
        $Datachart.AddBackGroundColor($backgroundColor)
        #$Datachart.backgroundColor = $backgroundColor
    }

    If($borderColor){
        $Datachart.borderColor = $borderColor
    }
    if ($borderWidth){
        $Datachart.borderWidth = $borderWidth
    }

    If($hoverBackgroundColor){
        $Datachart.AddHoverBackGroundColor($hoverBackgroundColor)
        #$Datachart.hoverBackgroundColor = $hoverBackgroundColor
    }else{
        $Datachart.AddHoverBackGroundColor($backgroundColor)
    }
    
    If($HoverBorderColor){
        $Datachart.hoverBorderColor = $HoverBorderColor
    }
    if($HoverBorderWidth){
        $Datachart.HoverBorderWidth = $HoverBorderWidth
    }

    return $Datachart
}

function New-PSHTMLChartLineDataSet {
    <#
    .SYNOPSIS
        Create a dataset object for a Line chart
    .DESCRIPTION
        Create a dataset object for a Line chart
     .PARAMETER FillbackgroundColor
        Allows to specify the background color between the line and the X axis.
        This should not be used in conjunction with FillBackGround 
    .PARAMETER Fillbackground
        fillBackground allows to specify that color should be added between the line and the X Axis.
        The color will be the Line color, whi
    .EXAMPLE
       
    .NOTES
    
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [CmdletBinding()]
    param (
        [String]$LineColor,
        [String]$label,
        [Color]  $FillbackgroundColor,
        [int]    $LineWidth = 1,
        [int[]]    $LineDash = 0,
        [int]    $LineDashOffSet = 0,
        [Array]$Data,
        [Switch]$FillBackground,
        [float]$PointRadius = 4,
        [float]$PointHitRadius = 0,
        [float]$PointHoverRadius = 0,
        
        [ValidateSet("rounded","Straight")]
        $LineChartType = "rounded",

        [ValidateSet("Full","Dashed")]
        $LineType = "Full"

    )
    
    $Datachart = [datasetline]::New()
    
    
    if($Data){
        $Null = $Datachart.AddData($Data)
    }


    if($lineType -eq "Dashed"){
        $datachart.borderDash = 10
    }

    if($Label){
        $Datachart.label = $label
    }

    if($LineWidth){
        $Datachart.borderWidth = $LineWidth
    }

    if($LineDash){
        $Datachart.borderDash = $LineDash
    }

    if($LineDashOffSet){
        $Datachart.borderDashOffSet = $LineDashOffSet
    }

    if($LineColor){
        $DataChart.SetLineColor($LineColor,$false)
        $Datachart.PointHoverBackgroundColor = $LineColor
    }

    if($FillBackground){
        $Datachart.SetLineBackGroundColor()
    }
    if($FillbackgroundColor){
        $Datachart.SetLineBackGroundColor($FillbackgroundColor)
    }

    if($LineChartType){
        switch($LineChartType){
            "rounded"{
                $Datachart.lineTension = 0.5
                ;Break
            }
            "Straight"{
                $Datachart.lineTension = 0
                ;break
            }
        }
    }

    $Datachart.SetPointSettings($PointRadius,$PointHitRadius,$PointHoverRadius)

    Return $Datachart
}
function New-PSHTMLChartPieDataSet {
    <#
    .SYNOPSIS
        Create a dataset object for a Pie chart
    .DESCRIPTION
        Create a dataset object for a Line chart
    .EXAMPLE
       
    .INPUTS
        Inputs (if any)
    .OUTPUTS
        DataSetLine
    .NOTES
    
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [CmdletBinding()]
    param (
        [Array]$Data,
        [String]$label,
        [array]$backgroundColor,
        [String]$borderColor,
        [int]$borderWidth = 1,
        [array]$hoverBackgroundColor,
        [string]$HoverBorderColor,
        [int]$HoverBorderWidth
        

    )
    
    $Datachart = [datasetPie]::New()

    if($Data){
        $null = $Datachart.AddData($Data)
    }

    If($Label){
        $Datachart.label = $label
    }

    if($backgroundColor){
        $Datachart.AddBackGroundColor($backgroundColor)
        #$Datachart.backgroundColor = $backgroundColor
    }

    If($borderColor){
        $Datachart.borderColor = $borderColor
    }
    if ($borderWidth){
        $Datachart.borderWidth = $borderWidth
    }

    If($hoverBackgroundColor){
        $Datachart.AddHoverBackGroundColor($hoverBackgroundColor)
        #$Datachart.hoverBackgroundColor = $hoverBackgroundColor
    }else{
        $Datachart.AddHoverBackGroundColor($backgroundColor)
    }

    if($HoverBorderColor){
        $Datachart.HoverBorderColor = $HoverBorderColor
    }

    if ($HoverborderWidth){
        $Datachart.HoverBorderWidth = $HoverborderWidth
    }

    return $Datachart
}
function New-PSHTMLChartPolarAreaDataSet {
    <#
    .SYNOPSIS
        Create a dataset object for a PolarArea chart
    .DESCRIPTION
        Use this function to generate a Dataset for a PolarArea chart. 
        It allows to specify options such as, the label name, Background / border / hover colors etc..
    .EXAMPLE
       
    .PARAMETER Data
        Specify an array of values.
        ex: @(3,5,42,69)

    .PARAMETER Label
        this String Array defines the labels

    .PARAMETER BackgroundColor
        The background colors of the PolarArea chart values.
        
        Use either: [Color] to generate a color,
        Or specify directly one of the following formats:
        RGB(120,240,50)
        RGBA(120,240,50,0.4)

    .PARAMETER BorderColor
        The border colors of the PolarArea chart values.

        Use either: [Color] to generate a color,
        Or specify directly one of the following formats:
        RGB(120,240,50)
        RGBA(120,240,50,0.4)

    .PARAMETER BorderWidth
        expressed in px's

    .PARAMETER BorderSkipped
        border is skipped

    .PARAMETER HoverBorderColor
        The HoverBorder color of the PolarArea chart values.
        Use either: 
        [Color] to generate a color,
        Or specify directly one of the following formats:
        RGB(120,240,50)
        RGBA(120,240,50,0.4)

    .EXAMPLE
            $Labels = @('red', 'green', 'yellow', 'grey', 'blue')
            $BackgroundColor = @('red', 'green', 'yellow', 'grey', 'blue')
            $Data1 = @(34,7,11,19,12)
            $dsb1 = New-PSHTMLChartPolarAreaDataSet -Data $data1 -label $Labels -BackgroundColor $BackgroundColor

            
    .OUTPUTS
        DataSetPolarArea

    .NOTES
        Made with love by Stephanevg

    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [CmdletBinding()]
    [OutputType([datasetPolarArea])]
    param (
        [Array]  $Data,
        [Array]  $label,
        [Array]  $backgroundColor,
        [Array]  $borderColor,
        [int]    $borderWidth = 1,
        [String] $borderSkipped,
        [Array]  $hoverBackgroundColor,
        [Array]  $hoverBorderColor,
        [int]    $hoverBorderWidth
        

    )
    
    $Datachart = [datasetPolarArea]::New()
    
    if($Data){
        $null = $Datachart.AddData($Data)
    }

    If($Label){
        $Datachart.label = $label
    }

    if($xAxisID){
        $Datachart.xAxisID = $xAxisID
    }

    if($yAxisID){
        $Datachart.yAxisID = $yAxisID
    }

    if($backgroundColor){
        $Datachart.backgroundColor = $backgroundColor
    }

    If($borderColor){
        $Datachart.borderColor = $borderColor
    }
    else {
        $Datachart.borderColor = ''
    }
    if ($borderWidth){
        $Datachart.borderWidth = $borderWidth
    }

    if($borderSkipped){
        $Datachart.borderSkipped = $borderSkipped
    }

    If($hoverBackgroundColor){
        $Datachart.hoverBackgroundColor = $hoverBackgroundColor
    }
    else {
        $Datachart.hoverBackgroundColor = ''
    }
    
    If($HoverBorderColor){
        $Datachart.hoverBorderColor = $HoverBorderColor
    }
    else {
        $Datachart.hoverBorderColor = ''
    }
    if($HoverBorderWidth){
        $Datachart.HoverBorderWidth = $HoverBorderWidth
    }

    return $Datachart
}
function New-PSHTMLDropDownList {
    <#
    .SYNOPSIS
        Generate a New Drop Down List.
    .DESCRIPTION
        Generate a New Drop Down List.
    .EXAMPLE
        PS C:\> Get-Service | New-DropDownList -Property Name
        Create a dropdownlist of service names
    .EXAMPLE
        PS C:\> $items = 'apples','oranges','tomatoes','blueberries'
        PS C:\> New-PSHTMLDropDownList -Items $Items
        Create new simple dropdownlist, array based
    .EXAMPLE
        PS C:\> $ArrayOfDropDownOptions = @()
        PS C:\> $items = 'apples','oranges','tomatoes','blueberries'
        PS C:\> Foreach ( $item in $items ) { $ArrayOfDropDownOptions += New-PSHTMLDropDownListItem -value $item -content $item }
        PS C:\> New-PSHTMLDropDownList -Items $ArrayOfDropDownOptions
        Create new simple dropdownlist, array based
    .INPUTS
        Array
    .OUTPUTS
        Output (if any)
    .NOTES
        Issue #201: https://github.com/Stephanevg/PSHTML/issues/201
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$False,ValueFromPipeline=$True)]
        [AllowNull()]
        [Array]
        $Items,
        [Parameter(Mandatory = $False)]
        [String]$Property,
        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class,
        [String]$Id,
        [Hashtable]$Attributes
    )
    
    begin {
        $Option = @()
    }
    
    process {
        If ( $null -ne $items ) {

            ## Assuming its coming from New-DropDownListItem
            If ( $items[0] -match '^<option') {
                $Option += $items
            } Else {
                If ( $Property) {
                    $Option += New-PSHTMLDropDownListItem -Items $items -Property $Property
                } Else {
                    foreach ( $item in $items ) {
                        $Option += New-PSHTMLDropDownListItem -Content $item -value $item
                    }
                }
            }
        }
    }
    
    end {
        selecttag -Content {
            $option
        } -Class $Class -Id $Id -Attributes $Attributes
    }
}
function New-PSHTMLDropDownListItem {
    <#
    .SYNOPSIS
        Generate a New Drop Down Item.
    .DESCRIPTION
        Generate a New Drop Down Item.
    .EXAMPLE
        PS C:\> Get-Service | New-PSHTMLDropDownListItem -Property Name
        Create a String representing a list of drop down items representing service name.
    .EXAMPLE
        PS C:\> $Services = Get-Service
        PS C:\> New-PSHTMLDropDownListItem -Items $Services -Property Name
        Create a String representing a list of drop down items representing service name.
    .EXAMPLE
        PS C:\> New-PSHTMLDropDownListItem -value 'aaaa' -content 'aaaaaaa'
        Create a new dropdown option
    .INPUTS
        Inputs (if any)
    .OUTPUTS
        Output (if any)
    .NOTES
        Issue #201: https://github.com/Stephanevg/PSHTML/issues/201
    #>
    [CmdletBinding(DefaultParameterSetName='Classic')]
    param (
        [Parameter(Mandatory=$True,ValueFromPipeline=$True,ParameterSetName='Items')]
        [Array]$Items,
        [Parameter(Mandatory=$True,ParameterSetName='Items')]
        [string]$Property,
        [Parameter(Mandatory=$false,ParameterSetName='Classic')]
        [AllowEmptyString()]
        [AllowNull()]
        $Content = '',
        [Parameter(Mandatory=$false,ParameterSetName='Classic')]
        [AllowEmptyString()]
        [AllowNull()]
        [string]$value = '',
        [string]$label,
        [Switch]$Disabled,
        [Switch]$Selected,
        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class = "",
        [String]$Id,
        [AllowEmptyString()]
        [AllowNull()]
        [String]$Style,
        [String]$title,
        [Hashtable]$Attributes

    )
    
    begin {
        $options = @()
    }
    
    process {

        $BoundParameters = $PSBoundParameters

        Switch ( $PSCmdlet.ParameterSetName ) {

            'Items' {

                If ( @($items | get-member -name $property).Count -eq 0  ) {
                    Throw ("Please specify an existing property. {0} does not exist ...." -f $property)
                } 

                Foreach ( $item in $items ) {

                    $Content = ($Item | Select-Object -Property $property).$property
                    $value = $Property

                    $BoundParameters.Remove('Items') | out-null
                    $BoundParameters.Remove('Property') | out-null
                    $BoundParameters.Value = $value
                    $BoundParameters.Content = $Content

                    $options += option @BoundParameters
                }
            }

            'Classic' {
                $options += option @PSBoundParameters
            }

            Default {
            }
        }
    }
    
    end {
        $options -join ''
    }
}
function New-PSHTMLMenu {
    <#
    .SYNOPSIS
        Generate a New Menu.
    .DESCRIPTION
        With this function you can generate a Menubar out of a Hashtable.
    .EXAMPLE 
    Create the Hashtables. You have to use the Names of the Keys
        $Hash1 = @{
            Content        = "top"
            href      = "https://plop.com/Home"
            Style   ="Height: 5px;"
            Id      = "nav_home_top"
            Class   = "TestClass2"
            Target      = "_self"
        }

        $Hash2 = @{
            Content        = "Contact"
            href      = "https://testwebsite.com/Contact"
            Style   ="Height: 5px;"
            Id      = "nav_home_contact"
            Class   = "Class001"
            Target      = "_Parent"
            Attributes = @{
                'Plop' = 'rop'
                'wep'  = 'sep'
            }
        }

        $arr = @()
        $arr += $Hash1
        $arr += $Hash2

    #Create a Menublock
        New-PSHTMLMenu -InputValues $arr -NavClass "JustAClass" -NavId "Menu_top" -NavStyle "display:block;"
    .INPUTS
        Inputs (if any)
    .OUTPUTS
        Output (if any)
    .NOTES
        Author: BatesKevin
    #>
    [CmdletBinding(DefaultParameterSetName='Classic')]
    param (
        [Parameter(Mandatory=$True,ValueFromPipeline=$True)]
        [Array]$InputValues,
        
        [AllowEmptyString()]
        [AllowNull()]
        [String]$NavClass,
        [String]$NavId,
        [AllowEmptyString()]
        [AllowNull()]
        [String]$NavStyle,
        [Hashtable]$NavAttributes,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$ulClass,
        [String]$ulId,
        [AllowEmptyString()]
        [AllowNull()]
        [String]$ulStyle,
        [Hashtable]$ulAttributes,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$LiClass,
        [String]$liId,
        [AllowEmptyString()]
        [AllowNull()]
        [String]$liStyle,
        [Hashtable]$liAttributes


    )
    
    begin {
        $options = @()
    }
    
    process {

        $BoundParameters = $PSBoundParameters

        nav -Content {

            ul -Content {

                Foreach($Link in $InputValues){
                    li -Content {

                        a @link
                    }
                } 
            } -Class $ulClass -Id $ulId -Style $ulStyle -Attributes $ulAttributes

        } -Class $NavClass -Id $NavId -Style $NavStyle -Attributes $NavAttributes

    }
    
    end {
        $options -join ''
    }
}
Function Noscript {
    <#
    .SYNOPSIS
    Generates Noscript HTML tag.

    .EXAMPLE
    Noscript "Your browser doesn`'t support javascript"

    Generates the following code:

    <noscript >Your browser doesn't support javascript</noscript>

    .NOTES
        version: 3.1.0

    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [CmdletBinding()]
    Param(


        [Parameter(Position = 1)]
        $content,

        [Parameter(Position = 2)]
        [String]$Class,

        [Parameter(Position = 3)]
        [String]$Id,

        [Parameter(Position = 4)]
        [String]$Style,

        [Parameter(Position = 5)]
        [Hashtable]$Attributes


    )

    Process {

        $tagname = "noscript"

        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid
    }

}
Function ol {
    <#
    .SYNOPSIS
    Create a ol tag in an HTML document.

    .EXAMPLE
    ol

    .EXAMPLE
    ol -Content {li -Content "asdf"}

    .EXAMPLE
    ol -Class "class" -Id "something" -Style "color:red;"

    .EXAMPLE

    ol {li -Content "asdf"} -reversed -type a

    #Generates the following content

    <ol type="a" reversed >
        <li>
            asdf
        </li>
    </ol>

    .NOTES
    Current version 3.1.0
       History:
       2018.10.30;@ChristopheKumor;Updated to version 3.0
        2018.10.02;bateskevin;Updated to v2.
        2018.04.14;stephanevg;fix Content bug, Added parameter 'type'. Upgraded to v1.1.
        2018.04.01;bateskevin;Creation.
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [CmdletBinding()]
    Param(

        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $false,
            Position = 0
        )]
        $Content,

        [Parameter(Position = 1)]
        [String]$Class,

        [Parameter(Position = 2)]
        [String]$Id,

        [Parameter(Position = 3)]
        [String]$Style,

        [Parameter(Position = 4)]
        [Hashtable]$Attributes,

        [Parameter(Position = 5)]
        [Switch]$reversed,

        [Parameter(Position = 6)]
        [int]$start,

        [ValidateSet("1", "A", "a", "I", "i")]
        [Parameter(Position = 7)]
        [String]$type


    )
    Process {

        $tagname = "ol"

        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid
    }

}

Function optgroup {
    <#
    .SYNOPSIS
    Create a optgroup title in an HTML document.

    .DESCRIPTION
    The <optgroup> is used to group related options in a drop-down list.

    If you have a long list of options, groups of related options are easier to handle for a user.

    .EXAMPLE

    optgroup
    .EXAMPLE
    

    .Notes
    Author: StÃ©phane van Gulick
    Version: 3.1.0
    History:
    2018.10.30;@ChristopheKumor;Updated to version 3.0
        2018.05.11;@Stephanevg; fixed minor bugs
        2018.05.09;@Stephanevg; Creation

    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [Cmdletbinding()]
    Param(

        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $false,
            Position = 0
        )]
        [AllowEmptyString()]
        [AllowNull()]
        $Content,

        [Parameter(Mandatory = $false)]
        [String]$Label,

        [Switch]
        $Disabled,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Id,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Style,

        [Hashtable]$Attributes
    )

    $tagname = "optgroup"

    Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid


}
Function option {
    <#
    .SYNOPSIS
    Create a <option> tag in an HTML document.

    .DESCRIPTION

    The <option> tag defines an option in a select list.

    <option> elements go inside a <select> or <datalist> element.


    .EXAMPLE
    
        
    datalist {
        option -value "Volvo" -Content "Volvo" 
        option -value Saab -Content "saab"
    }


    Generates the following code:

    <datalist>
        <option value="Volvo"  >volvo</option>
        <option value="Saab"  >saab</option>
    </datalist>


    .EXAMPLE
    

    .NOTES
    Current version 3.1
       History:
       2018.10.30;@ChristopheKumor;Updated to version 3.0
            2018.10.05;@stephanevg;Creation.
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [Cmdletbinding()]
    Param(
        [Parameter(Mandatory = $false)]
        [AllowEmptyString()]
        [AllowNull()]
        $Content,

        [string]$value,

        [string]$label,

        [Switch]$Disabled,

        [Switch]$Selected,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class = "",

        [String]$Id,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Style,

        [String]$title,

        [Hashtable]$Attributes
    )


    $tagname = "option"
 
    Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType NonVoid

}

function Out-PSHTMLDocument {
    <#
    .SYNOPSIS
    Outputs the HTML document to an output location
    .DESCRIPTION
        Output the html string into a file.
    .EXAMPLE
        The following example gets the list of first 5 processes. Converts it into an HTML Table. It outputs the results in a file, and opens the results imÃ©diatley.

        $o = Get-PRocess | select ProcessName,Handles | select -first 5
        $FilePath = "C:\temp\OutputFile.html"
        $E = ConvertTo-PSHTMLTable -Object $o 
        $e | Out-PSHTMLDocument -OutPath $FilePath -Show

    .INPUTS
        String
    .OUTPUTS
        None
    .NOTES

        Author: StÃ©phane van Gulick
                
        
    .LINK
        https://github.com/Stephanevg/PSHTML
#>
    [CmdletBinding()]
    param (
        $OutPath = $(Throw "Must provide a path"),

        [Parameter(ValueFromPipeline = $true)]
        $HTMLDocument = $(Throw "HTMLDocument cannot be empty"),

        [Parameter(Mandatory = $False)]
        [Switch]$Show
    )
    
    begin {
        $Writer = [System.IO.StreamWriter]::New($OutPath,$false,[System.Text.Encoding]::UTF8)
    }
    
    process {
        #[System.IO.TextWriter]
        Foreach ($Line in $HTMLDocument) {
            $writer.WriteLine($Line)
        }
    }
    
    end {
        $Writer.Close()
        If ($Show) {
            Invoke-Item -Path $OutPath
        }
    }
}
Function output {
    <#
    .SYNOPSIS
    Create a output tag in an HTML document.

    .Description

    The <output> tag represents the result of a calculation (like one performed by a script).

    .EXAMPLE
   
    output -Name "plop" -For "a b" -Form MyForm

    REturns:
    
    <output Form="MyForm" Name="plop" For="a b"  >
    </output>

    .EXAMPLE
    
    .NOTES
    Current version 3.1.0
       History:
       2018.10.30;@ChristopheKumor;Updated to version 3.0
            2018.10.10;stephanevg;Creation.
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [Cmdletbinding()]
    Param(

        [Parameter(Mandatory = $false)]
        [AllowEmptyString()]
        [AllowNull()]
        $Content,

        [Parameter(Mandatory = $false)]
        [AllowEmptyString()]
        [AllowNull()]
        [String]
        $Name,

        [Parameter(Mandatory = $false)]
        [AllowEmptyString()]
        [AllowNull()]
        [String]
        $Form,

        [Parameter(Mandatory = $false)]
        [AllowEmptyString()]
        [AllowNull()]
        [String]
        $For,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class = "",

        [String]$Id,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Style,

        [String]$title,

        [Hashtable]$Attributes
    )

    Process {
        $tagname = "output"

        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid
    }
}
Function p {
    <#
    .SYNOPSIS
    Create a p tag in an HTML document.

    .PARAMETER Class
    Allows to specify one (or more) class(es) to assign the html element.
    More then one class can be assigned by seperating them with a white space.

    .PARAMETER Id
    Allows to specify an id to assign the html element.

    .PARAMETER Style
    Allows to specify in line CSS style to assign the html element.

    .PARAMETER Content
    Allows to add child element(s) inside the current opening and closing HTML tag(s).

    .EXAMPLE

    p
    .EXAMPLE
    p "woop1" -Class "class"

    .EXAMPLE
    p "woop2" -Class "class" -Id "Something"

    .EXAMPLE
    p "woop3" -Class "class" -Id "something" -Style "color:red;"

    .EXAMPLE
    p {
        $Important = strong{"This is REALLY important"}
        "This is regular test in a paragraph " + $Important
    }

    Generates the following code

    <p>
    This is regular test in a paragraph <strong>"This is REALLY important"</strong>
    </p>

    .NOTES
    Current version 3.1.0
       History:
            2018.11.1; Stephanevg;Updated to version 3.1
            2018.10.30;@ChristopheKumor;Updated to version 3.0
            2018.04.10;Stephanevg;Updated content (removed string, added if for selection between scriptblock and string).
            2018.04.01;bateskevinhanevg;Creation.
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [Cmdletbinding()]
    Param(
        [Parameter(Mandatory = $false)]
        [AllowEmptyString()]
        [AllowNull()]
        $Content,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class,

        [String]$Id,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Style,

        [String]$title,

        [Hashtable]$Attributes
    )
    
    $tagname = "p"
 
    Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType NonVoid

}
Function pre {
    <#
    .SYNOPSIS
    Create a pre tag in an HTML document.

    .EXAMPLE

    pre
    .EXAMPLE
    pre -Content @"

        whatever
        it       is

        you ne  ed
    "@

    .EXAMPLE
    pre -class "classy" -style "stylish" -Content @"

        whatever
        it       is

        you ne  ed
    "@

    .NOTES
    Current version 3.1.0
       History:
       2018.10.30;@ChristopheKumor;Updated to version 3.0
       2018.10.02:bateskevin; Updated to v2 
       2018.04.01;bateskevin;Creation.
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [Cmdletbinding()]
    Param(
        [Parameter(Mandatory = $true)]
        [AllowEmptyString()]
        [AllowNull()]
        $Content,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class = "",

        [String]$Id,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Style,

        [String]$title,

        [Hashtable]$Attributes
    )

    Process {
        $tagname = "pre"

        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid
        
    }
}
Function progress {
    <#
    .SYNOPSIS
    Create a progress tag in an HTML document.

    .DESCRIPTION

    Tip: Use the <progress> tag in conjunction with JavaScript to display the progress of a task.

    Note: The <progress> tag is not suitable for representing a gauge (e.g. disk space usage or relevance of a query result). To represent a gauge, use the <meter> tag instead.

    .EXAMPLE
    

    .EXAMPLE

    .NOTES
    Current version 3.1.0
       History:
        2018.10.30;@ChristopheKumor;Updated to version 3.0
            2018.10.10;bateskevinhanevg;Creation.
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [Cmdletbinding()]
    Param(
        [Parameter(Mandatory = $false)]
        [AllowEmptyString()]
        [AllowNull()]
        $Content,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Max = "",

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Value = "",

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class = "",

        [String]$Id,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Style,

        [String]$title,

        [Hashtable]$Attributes
    )

    Process {
        $tagname = "progress"

        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid
    }
}
Function script {
    <#
    .SYNOPSIS
    Generates script HTML tag.

    .EXAMPLE
    script -type text/javascript -src "myscript.js"

    Generates the following code:

    <script type="text/javascript" src="myscript.js"></script>

    .EXAMPLE
    script -type text/javascript  -content "alert( 'Hello, world!' );"

    Generates the following code:

    <script type="text/javascript">alert( 'Hello, world!' );</script>
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [CmdletBinding()]
    Param(


        [Parameter(Position = 0)]
        [String]$src,

        [Parameter(Mandatory = $false, Position = 1)]
        [ValidateSet("text/javascript")]
        [String]$type,

        [Parameter(Position = 2)]
        [String]$integrity,

        [Parameter(Position = 3)]
        [String]$crossorigin,

        [Parameter(Position = 4)]
        $content,

        [Parameter(Position = 5)]
        [String]$Class,

        [Parameter(Position = 6)]
        [String]$Id,

        [Parameter(Position = 7)]
        [String]$Style,

        [Parameter(Position = 8)]
        [Hashtable]$Attributes



    )
 
    Process {

        $tagname = "script"

        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid
    }
}
Function section {
    <#
    .SYNOPSIS
    Generates section HTML tag.

    .EXAMPLE

    section -Attributes @{"class"="MyClass";"id"="myid"} -Content {
        h1 "This is a h1"
        P{
            "This paragraph is part of a section with id 'myid'"
        }
    }

    Generates the following code:

    <section class="MyClass" id="myid" >
        <h1>This is a h1</h1>
        <p>
            This paragraph is part of a section with id 'myid'
        </p>
    </section>

    .EXAMPLE

    section -Class "myclass" -Style "section {border:1px dotted black;}" -Content {
        h1 "This is a h1"
        P{
            "This paragraph is part of section with id 'myid'"
        }
    }

    Generates the following code:

    <section Class="myclass" Style="section {border:1px dotted black;}" >
    <h1>This is a h1</h1>
        <p>
        This paragraph is part of section with id 'myid'
        </p>
    </section>
    .LINK
        https://github.com/Stephanevg/PSHTML

    .NOTES
        Current version 3.1.0
        History:
        2018.10.30;@ChristopheKumor;Updated to version 3.0
            2018.04.10;bateskevin; Updated to version 2.0
            2018.04.10;Stephanevg; Added parameters
            2018.04.01;Stephanevg;Creation.

    #>
    [CmdletBinding()]
    Param(


        [Parameter(Position = 1)]
        [String]$Class,

        [Parameter(Position = 2)]
        [String]$Id,

        [Parameter(Position = 3)]
        [String]$Style,

        [Parameter(Position = 4)]
        [Hashtable]$Attributes,

        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $false,
            Position = 5
        )]
        [scriptblock]
        $Content
    )
    Process {
        $tagname = "Section"

        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid
        
    }


}
Function selecttag {
    <#
    .SYNOPSIS

    creates a "select" html tag.

    .Description
    The name of the cmdlet has volontarly been changed from "select" to "selectag" in order to avoid a conflict with
    with the built-in powershell alias "select" (which points to Select-object)


    .EXAMPLE

    selecttag
    .EXAMPLE
    selecttag "woop1" -Class "class"

    .EXAMPLE

    <select>
        <option value="volvo">Volvo</option>
        <option value="saab">Saab</option>
        <option value="mercedes">Mercedes</option>
        <option value="audi">Audi</option>
    </select>

    .PARAMETER Form
        Specify the form ID to wich the selecttag statement should be a part of.
        

    .Notes
    Author: StÃ©phane van Gulick
    Version: 3.2.0
    History:
    2018.10.30;@ChristopheKumor;Updated to version 3.0
        2018.05.09;@Stephanevg; Creation
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [Cmdletbinding()]
    Param(
        [Parameter(Mandatory = $false)]
        [AllowEmptyString()]
        [AllowNull()]
        $Content,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class,

        [String]$Id,

        [String]$Form,

        [string]$Name,

        [Hashtable]$Attributes
    )

    $tagname = "select"

    Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid



}
Function small {
    <#
    .SYNOPSIS
    Create a <small> element in an HTML document.

    .DESCRIPTION
    The <small> tag defines smaller text (and other side comments).


    .EXAMPLE

    small

    Returns>

    <small>
    </small>
    .EXAMPLE
    small "woop1" -Class "class"

    <small Class="class"  >
        woop1
    </small>

    .Notes
    Author: StÃ©phane van Gulick
    Version: 3.1.0
    History:
    2018.10.30;@ChristopheKumor;Updated to version 3.0
        2018.10.04;@Stephanevg; Creation

    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [Cmdletbinding()]
    Param(

        [Parameter(Mandatory = $false)]
        [AllowEmptyString()]
        [AllowNull()]
        $Content,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class,

        [String]$Id,

        [String]$Style,

        [Hashtable]$Attributes
    )

    $tagname = "small"

    Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid
}

Function span {
    <#
    .SYNOPSIS
    Create a span tag in an HTML document.

    .EXAMPLE

    span
    .EXAMPLE
    span "woop1" -Class "class"

    .EXAMPLE
    span "woop2" -Class "class" -Id "Something"

    .EXAMPLE
    span "woop3" -Class "class" -Id "something" -Style "color:red;"

    .NOTES
    Current version 3.1
       History:
       
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [Cmdletbinding()]
    Param(
        [Parameter(Mandatory = $false)]
        [AllowEmptyString()]
        [AllowNull()]
        $Content,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class = "",

        [String]$Id,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Style,

        [String]$value,

        [HashTable]$Attributes


    )

    Process {

        $tagname = "span"

        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid
        
    }
}
Function strong {
    <#
    .SYNOPSIS
    Generates strong HTML tag.

    .Description
    This tag is a "Textual semantic" tag. To use it in a "P" tag, be sure to prefix it with a semicolon (";").
    See example for more details.

    .EXAMPLE
    p{
        "This is";strong {"cool"}
    }

    Will generate the following code

    <p>
        This is
        <strong>
        cool
        </strong>
    </p>



    .Notes
    Author: StÃ©phane van Gulick
    Version: 3.1.0
    History:
    2018.10.30;@ChristopheKumor;Updated to version 3.0
        2018.05.23;@Stephanevg; Updated function to use New-HTMLTag
        2018.05.09;@Stephanevg; Creation

    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [CmdletBinding()]
    Param(

        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $true,
            Position = 0
        )]
        $Content,

        [Parameter(Position = 1)]
        [String]$Class,

        [Parameter(Position = 2)]
        [String]$Id,

        [Parameter(Position = 3)]
        [String]$Style,

        [Parameter(Position = 4)]
        [Hashtable]$Attributes

    )
    $tagname = "strong"

    Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid

}


Function style {
    <#
    .SYNOPSIS
    Create a style title in an HTML document.

    .EXAMPLE

    style
    .EXAMPLE
    style "woop1" -Class "class"

    .EXAMPLE
    $css = @"
        "p {color:green;}
        h1 {color:orange;}"
    "@
    style {$css} -media "print" -type "text/css"

    .Notes
    Author: StÃ©phane van Gulick
    Version: 3.1.0
    History:
    2018.10.30;@ChristopheKumor;Updated to version 3.0
        2018.05.09;@Stephanevg; Creation
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [Cmdletbinding()]
    Param(
        [Parameter(Mandatory = $false)]
        [AllowEmptyString()]
        [AllowNull()]
        $Content,

        [String]$media,

        [String]$Type,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class,

        [String]$Id,

        [Hashtable]$Attributes
    )

    $tagname = "style"

    Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid



}
Function SUB {
    <#
    .SYNOPSIS
        Create a SUB tag in an HTML document.
    .DESCRIPTION
        The <sub> tag defines subscript text. 
        Subscript text appears half a character below the normal line, and is sometimes rendered in a smaller font. 
        Subscript text can be used for chemical formulas, like H2O. 
    .EXAMPLE
        p -content {
            "The Chemical Formula for water is H"
            SUB -Content {
                2
            }
            "O"
        } 
        The above example renders the html as illustrated below
        <p>
        The Chemical Formula for water is H
        <SUB>
            2
        </SUB>
        O
        </p>
    .NOTES
        Current version 3.1.0
        History:
        2018.10.30;@ChristopheKumor;Updated to version 3.0
                2018.10.18;@ChendrayanV;Updated to version 2.0
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [Cmdletbinding()]
    Param(
    
        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $false,
            Position = 0
        )]
        [AllowEmptyString()]
        [AllowNull()]
        $Content,
    
        [string]$cite,
    
        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class = "",
    
        [String]$Id,
    
        [AllowEmptyString()]
        [AllowNull()]
        [String]$Style,
    
        [String]$title,
    
        [Hashtable]$Attributes
    )
    
    Process {

        $tagname = "SUB"

        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid
            
    }
}
Function SUP {
    <#
    .SYNOPSIS
        Create a SUP tag in an HTML document.
    .DESCRIPTION
        The <sup> tag defines superscript text. 
        Superscript text appears half a character above the normal line, and is sometimes rendered in a smaller font. 
        Superscript text can be used for footnotes, like WWW[1].
    .EXAMPLE
        $Power = 3
        p -content {
            "The Value of 2"
            SUP $Power
            "is {0}" -f ([Math]::Pow(2,$Power))
        } 
        The above example renderes the HTML code as illustrated below
        <p>
        The Value of 2
        <SUP>
            3
        </SUP>
        is 8
        </p>
    .NOTES
        Current version 3.1.0
        History:
        2018.10.30;@ChristopheKumor;Updated to version 3.0
                2018.10.18;@ChendrayanV;Updated to version 2.0
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [Cmdletbinding()]
    Param(
    
        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $false,
            Position = 0
        )]
        [AllowEmptyString()]
        [AllowNull()]
        $Content,
    
        [string]$cite,
    
        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class = "",
    
        [String]$Id,
    
        [AllowEmptyString()]
        [AllowNull()]
        [String]$Style,
    
        [String]$title,
    
        [Hashtable]$Attributes
    )
    
    Begin {
            
        $tagname = "SUP"
    }
        
    Process {       

        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid
            
    }
        
}
Function Table {
    <#
    .SYNOPSIS
    Allows to create an table HTML element (<table> </table>)

    .Description
    The Table html element defined the contents of a table.

    .EXAMPLE

    Table {

    }

    .LINK
    https://github.com/Stephanevg/PSHTML

    .NOTES
    Version 1.0.0

#>
    Param(

        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $false,
            Position = 0
        )]
        $Content,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class = "",
    
        [String]$Id,
    
        [AllowEmptyString()]
        [AllowNull()]
        [String]$Style,

        [Hashtable]$Attributes
    )

    Process {

        $tagname = "Table"

        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid
    }
}



Function Tbody {
    <#
    .SYNOPSIS
    Allows to create an Thead HTML element (<Tbody> </Tbody>)
    .Description
    Tbody should be used inside a 'table' block, and after a Thead.

    .Example

    Tbody {
        
    }

    .LINK
    https://github.com/Stephanevg/PSHTML
    .NOTES
    Version 3.1.0
#>
    Param(

        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $false,
            Position = 0
        )]
        
        $Content,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class = "",
    
        [String]$Id,
    
        [AllowEmptyString()]
        [AllowNull()]
        [String]$Style,

        [Hashtable]$Attributes
    )

    Process {

        $tagname = "tbody"

        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid
    }
}
Function td {
    <#
    .SYNOPSIS
    Generates td HTML tag.

    .PARAMETER Class
    Allows to specify one (or more) class(es) to assign the html element.
    More then one class can be assigned by seperating them with a white space.

    .PARAMETER Id
    Allows to specify an id to assign the html element.

    .PARAMETER Style
    Allows to specify in line CSS style to assign the html element.

    .PARAMETER Content
    Allows to add child element(s) inside the current opening and closing HTML tag(s).

    .NOTES
    Current version 3.1.0
    History:
    2018.10.30;@ChristopheKumor;Updated to version 3.0
        2018.04.08;Stephanevg; Fixed custom Attributes display bug. Updated help
        2018.04.01;Stephanevg;
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [CmdletBinding()]
    Param(

        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $false,
            Position = 0
        )]
        [AllowEmptyString()]
        [AllowNull()]
        $Content,

        [Parameter(Position = 1)]
        [String]$Class,

        [Parameter(Position = 2)]
        [String]$Id,

        [Parameter(Position = 3)]
        [String]$Style,

        [Parameter(Position = 4)]
        [Hashtable]$Attributes


    )

    Process {

        $tagname = "td"

        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid
    }
}

Function textarea {
    <#
    .SYNOPSIS
    Create a textarea tag in an HTML document.

    .DESCRIPTION

    The <textarea> tag defines a multi-line text input control.

    A text area can hold an unlimited number of characters, and the text renders in a fixed-width font (usually Courier).

    The size of a text area can be specified by the cols and rows attributes, or even better; through CSS' height and width properties.

    .EXAMPLE
    
    textarea -Rows 3 -Cols 4 -Content "Please fill in text here and press ok"
    
    Returns:

    <textarea Cols="4" Rows="3"  >
    Please fill in text here and press ok
    </textarea>

    .EXAMPLE
   

    .NOTES
    Current version 3.1.0
       History:
           2018.10.30;@ChristopheKumor;Updated to version 3.0
            2018.04.01;stephanevg;Creation.
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [Cmdletbinding()]
    Param(
        [Parameter(Mandatory = $false)]
        [AllowEmptyString()]
        [AllowNull()]
        $Content,
        
        [AllowEmptyString()]
        [AllowNull()]
        [String]$Name = "",

        [AllowEmptyString()]
        [AllowNull()]
        [int]$Rows = "",

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Cols = "",


        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class = "",

        [String]$Id,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Style,

        [String]$title,

        [Hashtable]$Attributes
    )

    Process {
        $tagname = "textarea"

        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid
    }
}
Function tfoot {
    <#
    .SYNOPSIS
    Generates tfoot HTML tag.

    .PARAMETER Class
    Allows to specify one (or more) class(es) to assign the html element.
    More then one class can be assigned by seperating them with a white space.

    .PARAMETER Id
    Allows to specify an id to assign the html element.

    .PARAMETER Style
    Allows to specify in line CSS style to assign the html element.

    .PARAMETER Content
    Allows to add child element(s) inside the current opening and closing HTML tag(s).

    .NOTES
    Current version 3.1.0
    History:
    2018.10.30;@ChristopheKumor;Updated to version 3.0
        2018.04.08;Stephanevg; Fixed custom Attributes display bug. Updated help
        2018.04.01;Stephanevg;
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [CmdletBinding()]
    Param(

        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $false,
            Position = 0
        )]
        $Content,

        [Parameter(Position = 1)]
        [String]$Class,

        [Parameter(Position = 2)]
        [String]$Id,

        [Parameter(Position = 3)]
        [String]$Style,

        [Parameter(Position = 4)]
        [Hashtable]$Attributes


    )
 
    Process {

        $tagname = "tfoot"

        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid
    }
}

Function Th {
    <#
    .LINK
    https://github.com/Stephanevg/PSHTML
    .NOTES
        Version 3.1.0
#>
    Param(
        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $false,
            Position = 0
        )]
        $Content,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class = "",
    
        [String]$Id,
    
        [AllowEmptyString()]
        [AllowNull()]
        [String]$Style,

        [Hashtable]$Attributes
    )

    Process {

        $tagname = "th"

        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid
    }

}
Function Thead {
    <#
    .SYNOPSIS
    Allows to create an Thead HTML element (<Thead> </Thead>)
    .Description
    Thead should be used inside a 'table' block.

    .Example

    Thead {
        
    }

    .LINK
    https://github.com/Stephanevg/PSHTML
    .NOTES
        Version 3.1.0
#>
    Param(

        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $false,
            Position = 0
        )]
        $Content,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class = "",
    
        [String]$Id,
    
        [AllowEmptyString()]
        [AllowNull()]
        [String]$Style,

        [Hashtable]$Attributes
    )

    Process {

        $tagname = "thead"
    
        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid
    }

}
Function Title {
    <#
    .LINK
    https://github.com/Stephanevg/PSHTML
    .NOTES
    Version 3.1.0
#>
    Param(
        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $false,
            Position = 0
        )]
        $Content,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class = "",
    
        [String]$Id,
    
        [AllowEmptyString()]
        [AllowNull()]
        [String]$Style,

        [Hashtable]$Attributes
    )

    Process {

        $tagname = "title"
    
        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid
    }

}
Function tr {
    <#
    .SYNOPSIS
    Generates tr HTML tag.

    .PARAMETER Class
    Allows to specify one (or more) class(es) to assign the html element.
    More then one class can be assigned by seperating them with a white space.

    .PARAMETER Id
    Allows to specify an id to assign the html element.

    .PARAMETER Style
    Allows to specify in line CSS style to assign the html element.

    .PARAMETER Content
    Allows to add child element(s) inside the current opening and closing HTML tag(s).

    .NOTES
    Current version 3.1.0
    History:
    2018.10.30;@ChristopheKumor;Updated to version 3.0
        2018.04.08;Stephanevg; Fixed custom Attributes display bug. Updated help
        2018.04.01;Stephanevg;
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [CmdletBinding()]
    Param(

        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $false,
            Position = 0
        )]
        $Content,

        [Parameter(Position = 1)]
        [String]$Class,

        [Parameter(Position = 2)]
        [String]$Id,

        [Parameter(Position = 3)]
        [String]$Style,

        [Parameter(Position = 4)]
        [Hashtable]$Attributes,

        [ScriptBlock]
        $ClassScript

    )
    Process {
        
        $tagname = "tr"
        If($ClassScript){

            If (!($Class)){
                $Class = ""
            }

            
            $PSBoundParameters.Class = $ClassScript.Invoke($Content)

        }



        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid
    }
}

Function ul {
    <#
    .SYNOPSIS
    Create a ul tag in an HTML document.

    .EXAMPLE
    ul

    .EXAMPLE
    ul -Content {li -Content "asdf"}

    .EXAMPLE
    ul -Class "class" -Id "something" -Style "color:red;"

    .NOTES
    Current version 3.1.0
       History:
       2018.10.30;@ChristopheKumor;Updated to version 3.0
           2018.10.02;bateskevin;Updated to v2.
           2018.04.14;stephanevg;fix Content bug. Upgraded to v1.1.
           2018.04.01;bateskevinhanevg;Creation.
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [CmdletBinding()]
    Param(

        [Parameter(
            ValueFromPipeline = $false,
            Mandatory = $false,
            Position = 0
        )]
        $Content,

        [Parameter(Position = 1)]
        [String]$Class,

        [Parameter(Position = 2)]
        [String]$Id,

        [Parameter(Position = 3)]
        [String]$Style,

        [Parameter(Position = 4)]
        [Hashtable]$Attributes,

        [Parameter(Position = 5)]
        [Switch]$reversed,

        [Parameter(Position = 6)]
        [string]$start

    )
    Process {

        $tagname = "ul"

        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid
        
    }

}

function Write-PSHTMLAsset {
    <#
    .SYNOPSIS
        Add asset references to your PSHTML scripts.
    .DESCRIPTION
        Write-PSHTML will scan the 'Assets' folders in the PSHTML module folder, and 
        One can Use Write-PSHTML (Without any parameter) to add dynamically a link / script tag for every asset that is available in the Asset Folder.

    .PARAMETER Name

    Specify the name of an Asset. This is a dynamic parameter, and calculates the names based on the content of Assets folder.

    .PARAMETER Type

    Allows to specifiy what type of Asset to return. Script (.js) Style (.css) or CDN (.CDN) are the currently supported ones.

    The CDN file type must have a specifiy structure, which can be obtained by using the cmdlet New-CDNAssetFile

    .EXAMPLE
        Write-PSHTMLAsset

        Will generate all the asset tags, regardless of their type.

    .EXAMPLE
        Write-PSHTMLAsset -Type Script -Name ChartJs

        Generates the following results:
        
        <Script src='Chartjs/Chart.bundle.min.js'></Script

    .EXAMPLE
        Write-PSHTMLAsset -Type Style -Name Bootstrap

        Generates the following results:
        
        <Link src='BootStrap/bootstrap.min.css'></Link>

    .EXAMPLE
        Write-PSHTMLAsset -Name Bootstrap

        Generates all the links regardless of their type.


    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [CmdletBinding()]
    param (
        [ValidateSet("Script","Style","CDN")]$Type

    )

    DynamicParam {
        $ParameterName = 'Name'
        if($Type){

            $SelectedAsset = (Get-PSHTMLConfiguration).GetAsset([AssetType]$Type)
        }Else{
            $SelectedAsset = (Get-PSHTMLConfiguration).GetAsset()
        }
        

        $AssetNames = $SelectedAsset.Name
 
        $AssetAttribute = New-Object System.Management.Automation.ParameterAttribute
        $AssetAttribute.Position = 2
        $AssetAttribute.Mandatory = $False
        $AssetAttribute.HelpMessage = 'Select the asset to add'
 
        $AssetCollection = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
        $AssetCollection.add($AssetAttribute)
 
        $AssetValidateSet = New-Object System.Management.Automation.ValidateSetAttribute($AssetNames)
        $AssetCollection.add($AssetValidateSet)
 
        $AssetParam = New-Object System.Management.Automation.RuntimeDefinedParameter($ParameterName, [string], $AssetCollection)
 
        $AssetDictionary = New-Object System.Management.Automation.RuntimeDefinedParameterDictionary
        $AssetDictionary.Add($ParameterName, $AssetParam)
        return $AssetDictionary
 
    }
    
    begin {
        $Name = $PsBoundParameters[$ParameterName]
    }
    
    process {
        if($Type -and $Name){
            $Asset = (Get-PSHTMLConfiguration).GetAsset($Name,[AssetType]$Type)
        }ElseIf($Name){
            $Asset = (Get-PSHTMLConfiguration).GetAsset($Name)
        }ElseIf($Type){
            $Asset = (Get-PSHTMLConfiguration).GetAsset([AssetType]$Type)
        }
        Else{
            $Asset = (Get-PSHTMLConfiguration).GetAsset()
        }

        Foreach($A in $Asset){
            $A.ToString()
        }
        
    }
    
    end {
    }
}
Function Write-PSHTMLInclude {
    <#
    .SYNOPSIS
    Include parts of your PSHTML documents that is identical across pages.

    .DESCRIPTION
    Write the HTML content of an include file. Write-PSHTMLInclude has an well known alias called: 'include'.

    .PARAMETER Name

    Specifiy the name of an include file. 
    The name of an include file is the name of the powershell script containing the code, without the extension.
    Example: Footer.ps1 The name will be 'Footer'

    This parameter is a dynamic parameter, and you can tab through the different values up until you find the one you wish to use.


    .Example



html{
    Body{

        include -name body

    }
    Footer{
        Include -Name Footer
    }
}

#Generates the following HTML code

        <html>
            <body>

            h2 "This comes a Include file"
            </body>
            <footer>
            div {
                h4 "This is the footer from a Include"
                p{
                    CopyRight from Include
                }
            }
            </footer>
        </html>
#>
    [CmdletBinding()]
    Param(
        
    )

    DynamicParam {
        $ParameterName = 'Name'

        $Includes = (Get-PSHTMLConfiguration).GetInclude()
        If($Includes){
            $Names = $Includes.Name
 
            $Attribute = New-Object System.Management.Automation.ParameterAttribute
            $Attribute.Position = 1
            $Attribute.Mandatory = $False
            $Attribute.HelpMessage = 'Select which file to include'
     
            $Collection = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
            $Collection.add($Attribute)
     
            $ValidateSet = New-Object System.Management.Automation.ValidateSetAttribute($Names)
            $Collection.add($ValidateSet)
     
            $Param = New-Object System.Management.Automation.RuntimeDefinedParameter($ParameterName, [string], $Collection)
     
            $Dictionary = New-Object System.Management.Automation.RuntimeDefinedParameterDictionary
            $Dictionary.Add($ParameterName, $Param)
            return $Dictionary
        }
        
 
    }

    Begin{
        $Name = $PsBoundParameters[$ParameterName]
    }
    Process{

        If($Name){
            $Includes = (Get-PSHTMLConfiguration).GetInclude($Name)
        }else{
           $Includes = (Get-PSHTMLConfiguration).GetInclude()
        }
    
        Foreach($Include in $Includes){
            $Include.ToString()
        }

    }
    End{}

}
function Write-PSHTMLSymbol {

    param (
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [ValidateSet('COPYRIGHT SIGN', 
            'REGISTERED SIGN', 
            'EURO SIGN', 
            'TRADEMARK',
            'LEFTWARDS ARROW',
            'UPWARDS ARROW',
            'RIGHTWARDS ARROW',
            'DOWNWARDS ARROW',
            'BLACK SPADE SUIT',
            'BLACK CLUB SUIT',
            'BLACK HEART SUIT',
            'BLACK DIAMOND SUIT',
            'FOR ALL',
            'PARTIAL DIFFERENTIAL',
            'THERE EXISTS',
            'EMPTY SETS',
            'NABLA',
            'ELEMENT OF',
            'NOT AN ELEMENT OF',
            'CONTAINS AS MEMBER',
            'N-ARY PRODUCT',
            'N-ARY SUMMATION',
            'GREEK CAPITAL LETTER ALPHA',
            'GREEK CAPITAL LETTER BETA',
            'GREEK CAPITAL LETTER GAMMA',
            'GREEK CAPITAL LETTER DELTA',
            'GREEK CAPITAL LETTER EPSILON',
            'GREEK CAPITAL LETTER ZETA'
        )]
        [string[]]
        $Name
    )

    process {
        switch ($Name) {
            "COPYRIGHT SIGN" {
                "&copy;"
            }
            "REGISTERED SIGN" {
                "&reg;"
            }
            "EURO SIGN" {
                "&euro;"
            }
            "TRADEMARK" {
                "&trade;"
            }
            "LEFTWARDS ARROW" {
                "&larr;"
            }
            "UPWARDS ARROW" {
                "&uarr;"
            }
            "RIGHTWARDS ARROW" {
                "&rarr;"
            }
            "DOWNWARDS ARROW" {
                "&darr;"
            }
            "BLACK SPADE SUIT" {
                "&spades;"
            }
            "BLACK CLUB SUIT" {
                "&clubs;"
            }
            "BLACK HEART SUIT" {
                "&hearts;"
            }
            "BLACK DIAMOND SUIT" {
                "&diams;"
            }
            "FOR ALL" {
                "&forall;"
            }
            "PARTIAL DIFFERENTIAL" {
                "&part;"
            }
            "THERE EXISTS" {
                "&exist;"
            }
            "EMPTY SETS" {
                "&empty;"
            }
            "NABLA" {
                "&nabla;"
            }
            "ELEMENT OF" {
                "&isin;"
            }
            "NOT AN ELEMENT OF" {
                "&notin;"
            }
            "CONTAINS AS MEMBER" {
                "&ni;"
            }
            "N-ARY PRODUCT" {
                "&prod;"
            }
            "N-ARY SUMMATION" {
                "&sum;"
            }
            "GREEK CAPITAL LETTER ALPHA" {
                "&Alpha;"
            }
            "GREEK CAPITAL LETTER BETA" {
                "&Beta;"
            }
            "GREEK CAPITAL LETTER GAMMA" {
                "&Gamma;"
            }
            "GREEK CAPITAL LETTER DELTA" {
                "&Delta;"
            }
            "GREEK CAPITAL LETTER EPSILON" {
                "&Epsilon;"
            }
            "GREEK CAPITAL LETTER ZETA" {
                "&Zeta;"
            }
        }
    }
}
#Post Content

$ScriptPath = Split-Path -Path $MyInvocation.MyCommand.Path
$ScriptPath = Split-Path -Path $PSScriptRoot
New-Alias -Name Include -Value 'Write-PSHTMLInclude' -Description "Include parts of PSHTML documents using include files" -Force
function Get-ScriptDirectory {
    Split-Path -Parent $PSCommandPath
}
$ScriptPath = Get-ScriptDirectory
$CF = Join-Path -Path $ScriptPath -ChildPath "pshtml.configuration.json"
#Write-host "loading config file: $($CF)" -ForegroundColor Blue
#Setting module variables
    $Script:PSHTML_CONFIGURATION = Get-ConfigurationDocument -Path $CF -Force
    $Script:Logfile = $Script:PSHTML_CONFIGURATION.GetDefaultLogFilePath()
    $Script:Logger = [Logger]::New($Script:LogFile)
