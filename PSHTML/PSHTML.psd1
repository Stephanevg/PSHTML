#
# Manifeste de module pour le module « PSGet_PSHTML »
#
# Généré par : StÃ©phane van Gulick
#
# Généré le : 18/07/2019
#

@{

# Module de script ou fichier de module binaire associé à ce manifeste
RootModule = 'PSHTML.psm1'

# Numéro de version de ce module.
ModuleVersion = '0.7.12'

# Éditions PS prises en charge
# CompatiblePSEditions = @()

# ID utilisé pour identifier de manière unique ce module
GUID = 'bdb3c0ee-e687-4774-9cf7-a3c67aa22118'

# Auteur de ce module
Author = 'StÃ©phane van Gulick'

# Société ou fournisseur de ce module
CompanyName = 'District'

# Déclaration de copyright pour ce module
Copyright = '(c) 2018 StÃ©phane van Gulick. All rights reserved.'

# Description de la fonctionnalité fournie par ce module
Description = 'Cross platform PowerShell module to generate HTML markup language and create awesome web pages!'

# Version minimale du moteur Windows PowerShell requise par ce module
PowerShellVersion = '5.0'

# Nom de l'hôte Windows PowerShell requis par ce module
# PowerShellHostName = ''

# Version minimale de l'hôte Windows PowerShell requise par ce module
# PowerShellHostVersion = ''

# Version minimale du Microsoft .NET Framework requise par ce module. Cette configuration requise est valide uniquement pour PowerShell Desktop Edition.
# DotNetFrameworkVersion = ''

# Version minimale de l’environnement CLR (Common Language Runtime) requise par ce module. Cette configuration requise est valide uniquement pour PowerShell Desktop Edition.
# CLRVersion = ''

# Architecture de processeur (None, X86, Amd64) requise par ce module
# ProcessorArchitecture = ''

# Modules qui doivent être importés dans l'environnement global préalablement à l'importation de ce module
# RequiredModules = @()

# Assemblys qui doivent être chargés préalablement à l'importation de ce module
# RequiredAssemblies = @()

# Fichiers de script (.ps1) exécutés dans l’environnement de l’appelant préalablement à l’importation de ce module
# ScriptsToProcess = @()

# Fichiers de types (.ps1xml) à charger lors de l'importation de ce module
# TypesToProcess = @()

# Fichiers de format (.ps1xml) à charger lors de l'importation de ce module
# FormatsToProcess = @()

# Modules à importer en tant que modules imbriqués du module spécifié dans RootModule/ModuleToProcess
# NestedModules = @()

# Fonctions à exporter à partir de ce module. Pour de meilleures performances, n’utilisez pas de caractères génériques et ne supprimez pas l’entrée. Utilisez un tableau vide si vous n’avez aucune fonction à exporter.
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
               'New-PSHTMLDropDownList', 'New-PSHTMLDropDownListItem', 'noscript', 
               'ol', 'optgroup', 'option', 'Out-PSHTMLDocument', 'output', 'p', 'pre', 
               'progress', 'script', 'section', 'selecttag', 'small', 'span', 'strong', 
               'style', 'sub', 'sup', 'table', 'tbody', 'td', 'textarea', 'tfoot', 'th', 'thead', 
               'title', 'tr', 'ul', 'Write-PSHTMLAsset', 'Write-PSHTMLInclude', 
               'Write-PSHTMLSymbol'

# Applets de commande à exporter à partir de ce module. Pour de meilleures performances, n’utilisez pas de caractères génériques et ne supprimez pas l’entrée. Utilisez un tableau vide si vous n’avez aucune applet de commande à exporter.
CmdletsToExport = @()

# Variables à exporter à partir de ce module
# VariablesToExport = @()

# Alias à exporter à partir de ce module. Pour de meilleures performances, n’utilisez pas de caractères génériques et ne supprimez pas l’entrée. Utilisez un tableau vide si vous n’avez aucun alias à exporter.
AliasesToExport = 'include'

# Ressources DSC à exporter depuis ce module
# DscResourcesToExport = @()

# Liste de tous les modules empaquetés avec ce module
# ModuleList = @()

# Liste de tous les fichiers empaquetés avec ce module
# FileList = @()

# Données privées à transmettre au module spécifié dans RootModule/ModuleToProcess. Cela peut également inclure une table de hachage PSData avec des métadonnées de modules supplémentaires utilisées par PowerShell.
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

        # Flag to indicate whether the module requires explicit user acceptance for install/update/save
        # RequireLicenseAcceptance = $false

        # External dependent modules of this module
        # ExternalModuleDependencies = @()

    } # End of PSData hashtable

 } # End of PrivateData hashtable

# URI HelpInfo de ce module
HelpInfoURI = 'https://pshtml.readthedocs.io/en/latest/'

# Le préfixe par défaut des commandes a été exporté à partir de ce module. Remplacez le préfixe par défaut à l’aide d’Import-Module -Prefix.
# DefaultCommandPrefix = ''

}

