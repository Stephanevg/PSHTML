Function Get-ModuleRoot {
    [CmdletBinding()]
    Param(
        )
        return $MyInvocation.MyCommand.Module.ModuleBase
}