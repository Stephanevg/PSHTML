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