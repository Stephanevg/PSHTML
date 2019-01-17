

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

            $cp = (Get-PSCallStack)[-1].ScriptName #$PSCommandPath #Split-Path -parent $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath(�.\�) #$PSCommandPath
        }

        
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
        $cp = $PSCommandPath #Split-Path -parent $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath(�.\�) #$PSCommandPath
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

