#
# Modulmanifest für das Modul "PSGet_PSHTML"
#
# Generiert von: StÃ©phane van Gulick
#
# Generiert am: 18.09.2019
#

@{

# Die diesem Manifest zugeordnete Skript- oder Binärmoduldatei.
RootModule = 'PSHTML.psm1'

# Die Versionsnummer dieses Moduls
ModuleVersion = '0.8.0'

# Unterstützte PSEditions
# CompatiblePSEditions = @()

# ID zur eindeutigen Kennzeichnung dieses Moduls
GUID = 'bdb3c0ee-e687-4774-9cf7-a3c67aa22118'

# Autor dieses Moduls
Author = 'StÃ©phane van Gulick'

# Unternehmen oder Hersteller dieses Moduls
CompanyName = 'District'

# Urheberrechtserklärung für dieses Modul
Copyright = '(c) 2018 StÃ©phane van Gulick. All rights reserved.'

# Beschreibung der von diesem Modul bereitgestellten Funktionen
Description = 'Cross platform PowerShell module to generate HTML markup language and create awesome web pages!'

# Die für dieses Modul mindestens erforderliche Version des Windows PowerShell-Moduls
PowerShellVersion = '5.0'

# Der Name des für dieses Modul erforderlichen Windows PowerShell-Hosts
# PowerShellHostName = ''

# Die für dieses Modul mindestens erforderliche Version des Windows PowerShell-Hosts
# PowerShellHostVersion = ''

# Die für dieses Modul mindestens erforderliche Microsoft .NET Framework-Version. Diese erforderliche Komponente ist nur für die PowerShell Desktop-Edition gültig.
# DotNetFrameworkVersion = ''

# Die für dieses Modul mindestens erforderliche Version der CLR (Common Language Runtime). Diese erforderliche Komponente ist nur für die PowerShell Desktop-Edition gültig.
# CLRVersion = ''

# Die für dieses Modul erforderliche Prozessorarchitektur ("Keine", "X86", "Amd64").
# ProcessorArchitecture = ''

# Die Module, die vor dem Importieren dieses Moduls in die globale Umgebung geladen werden müssen
# RequiredModules = @()

# Die Assemblys, die vor dem Importieren dieses Moduls geladen werden müssen
# RequiredAssemblies = @()

# Die Skriptdateien (PS1-Dateien), die vor dem Importieren dieses Moduls in der Umgebung des Aufrufers ausgeführt werden.
# ScriptsToProcess = @()

# Die Typdateien (.ps1xml), die beim Importieren dieses Moduls geladen werden sollen
# TypesToProcess = @()

# Die Formatdateien (.ps1xml), die beim Importieren dieses Moduls geladen werden sollen
# FormatsToProcess = @()

# Die Module, die als geschachtelte Module des in "RootModule/ModuleToProcess" angegebenen Moduls importiert werden sollen.
# NestedModules = @()

# Aus diesem Modul zu exportierende Funktionen. Um optimale Leistung zu erzielen, verwenden Sie keine Platzhalter und löschen den Eintrag nicht. Verwenden Sie ein leeres Array, wenn keine zu exportierenden Funktionen vorhanden sind.
FunctionsToExport = 'a', 'address', 'area', 'article', 'aside', 'b', 'base', 'blockquote', 'body', 'br', 
               'button', 'canvas', 'caption', 'Clear-WhiteSpace', 'col', 'colgroup', 
               'ConvertTo-HtmlTable', 'ConvertTo-PSHtmlTable', 'datalist', 'dd', 'div', 
               'dl', 'doctype', 'dt', 'em', 'fieldset', 'figcaption', 'figure', 'footer', 'Form', 
               'Get-PSHTMLAsset', 'Get-PSHTMLColor', 'Get-PSHTMLConfiguration', 
               'Get-PSHTMLInclude', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'head', 'Header', 'hr', 
               'html', 'i', 'img', 'input', 'Install-PSHTMLVSCodeSnippets', 'keygen', 
               'label', 'legend', 'li', 'link', 'map', 'math', 'meta', 'meter', 'nav', 
               'New-PSHTMLCDNAssetFile', 'New-PSHTMLChart', 
               'New-PSHTMLChartBarDataSet', 'New-PSHTMLChartDataSet', 
               'New-PSHTMLChartDoughnutDataSet', 'New-PSHTMLChartLineDataSet', 
               'New-PSHTMLChartPieDataSet', 'New-PSHTMLChartPolarAreaDataSet', 
               'New-PSHTMLDropDownList', 'New-PSHTMLDropDownListItem', 
               'New-PSHTMLMenu', 'noscript', 'ol', 'optgroup', 'option', 
               'Out-PSHTMLDocument', 'output', 'p', 'pre', 'progress', 'script', 'section', 
               'selecttag', 'small', 'span', 'strong', 'style', 'sub', 'sup', 'table', 'tbody', 
               'td', 'textarea', 'tfoot', 'th', 'thead', 'title', 'tr', 'ul', 
               'Write-PSHTMLAsset', 'Write-PSHTMLInclude', 'Write-PSHTMLSymbol'

# Aus diesem Modul zu exportierende Cmdlets. Um optimale Leistung zu erzielen, verwenden Sie keine Platzhalter und löschen den Eintrag nicht. Verwenden Sie ein leeres Array, wenn keine zu exportierenden Cmdlets vorhanden sind.
CmdletsToExport = @()

# Die aus diesem Modul zu exportierenden Variablen
# VariablesToExport = @()

# Aus diesem Modul zu exportierende Aliase. Um optimale Leistung zu erzielen, verwenden Sie keine Platzhalter und löschen den Eintrag nicht. Verwenden Sie ein leeres Array, wenn keine zu exportierenden Aliase vorhanden sind.
AliasesToExport = 'include'

# Aus diesem Modul zu exportierende DSC-Ressourcen
# DscResourcesToExport = @()

# Liste aller Module in diesem Modulpaket
# ModuleList = @()

# Liste aller Dateien in diesem Modulpaket
# FileList = @()

# Die privaten Daten, die an das in "RootModule/ModuleToProcess" angegebene Modul übergeben werden sollen. Diese können auch eine PSData-Hashtabelle mit zusätzlichen von PowerShell verwendeten Modulmetadaten enthalten.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = 'pshtml','html','web'

        # A URL to the license for this module.
        # LicenseUri = ''

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/Stephanevg/PSHTML'

        # A URL to an icon representing this module.
        # IconUri = ''

        # ReleaseNotes of this module
        ReleaseNotes = 'https://github.com/Stephanevg/PSHTML/blob/master/Change_Log.md'

        # Prerelease string of this module
        # Prerelease = ''

        # Flag to indicate whether the module requires explicit user acceptance for install/update
        # RequireLicenseAcceptance = $false

        # External dependent modules of this module
        # ExternalModuleDependencies = @()

    } # End of PSData hashtable

 } # End of PrivateData hashtable

# HelpInfo-URI dieses Moduls
HelpInfoURI = 'https://pshtml.readthedocs.io/en/latest/'

# Standardpräfix für Befehle, die aus diesem Modul exportiert werden. Das Standardpräfix kann mit "Import-Module -Prefix" überschrieben werden.
# DefaultCommandPrefix = ''

}

