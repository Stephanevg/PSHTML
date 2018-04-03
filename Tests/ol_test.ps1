ol -reversed -start 1 -type "typo" -CustomAttributes @{Name="Kevin" ; whatever="floats your boat"} -ChildItem {
    li -content "Test entry" -Class "classy" -value 0 -Style "stylish" -customAttributes @{Name="Kevin" ; bibop="bopib"}
    li "Test entry 2"
}


$test = Get-Process | ?{($_.name).StartsWith("d") } |select name
ol {
    foreach($p in $test){
        li -content "$p" -Class "classy" -value "asdf" -Style "whatever" -Attributes @{name='asdf'}
    }
}

function test {
    [CmdletBinding()]
    Param(
        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $false
        )]
        [scriptblock]
        $ChildItem,

        [Parameter(Position = 1)]
        [String]$Class

    )

    $attr = ""

    $boundParams = $PSBoundParameters

    #$boundParams.Keys

    $boundParams.Remove("childitem")

    $boundParams.Keys
}