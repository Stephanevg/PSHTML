$AllMissingelements = @("object","param","video","audio","source","track","canvas","svg","math")

$Source = "C:\Users\taavast3\OneDrive\Repo\Projects\OpenSource\PSHTML\blockquote.ps1"
$Folder = "C:\Users\taavast3\OneDrive\Repo\Projects\OpenSource\PSHTML\temp\"
foreach($tag in $AllMissingelements){
    $destination = Join-Path -Path $Folder -ChildPath ($tag + ".ps1")
    Copy-Item $Source -Destination $destination
    $content = gc $destination -Raw
    $NeWContent = $content.Replace("blockquote",$tag)
    Set-Content -Path $destination -Value $NewContent -Force
}