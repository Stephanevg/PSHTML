Function Write-PSHTMLLog {
    [Cmdletbinding()]
    Param(
        [String]$Message,

        [ValidateSet("Info","Warning","Error","Information")]
        [String]$Type = "info"
    )

    
    $Script:Logger.Log($Message)


}