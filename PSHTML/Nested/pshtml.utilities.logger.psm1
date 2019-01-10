
Class Logger{
    [System.IO.FileInfo]$Logfile
    
    Logger (){
        #$this.Logfile = $PSHTML_CONFIG.Logging.Path
        $this.Logfile = "$env:HOME/Logging.log"
    }

    Log($Message){
        $sw = [System.IO.StreamWriter]::new($this.LogFile, [System.Text.Encoding]::UTF8)
        $sw.WriteLine($Message)
        $sw.Close()
    }
}

