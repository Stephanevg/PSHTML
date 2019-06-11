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
        $Items = Get-ChildItem $Path.FullName -Filter "*.ps1"
        $AllIncludes = @()
        Foreach($Item in $Items){
            $AllIncludes += [Include]::New($Item)
            
        }

        Return $AllIncludes
    }
}
