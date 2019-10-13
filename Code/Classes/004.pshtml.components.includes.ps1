Class Include {

}

Class IncludeFile : Include {
    [String]$Name
    [System.IO.DirectoryInfo]$FolderPath
    [System.IO.FileInfo]$FilePath
    Location([System.IO.FileInfo]$Module){
        $this.ModuleRoot = $Module.FullName 
        $this.Scriptroot = $Module.Name
    }
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
