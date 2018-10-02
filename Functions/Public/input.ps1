Function input {
    <#
    .SYNOPSIS
    Generates input HTML tag.

    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [CmdletBinding()]
    Param(

        #Need to add the other ones from --> https://www.w3schools.com/tags/tag_input.asp
        [Parameter(Mandatory = $true, Position = 0)]
        [ValidateSet("button", "checkbox", "color", "date", "datetime-local", "email", "file", "hidden", "image", "month", "number", "password", "radio", "range", "reset", "search", "submit", "tel", "text", "time", "url", "week")]
        [String]$type,

        [Parameter(Mandatory = $true, Position = 1)]
        [String]$name,

        [Parameter(Mandatory = $false, Position = 2)]
        [switch]$required,

        [Parameter(Mandatory = $false, Position = 3)]
        [switch]$readonly,

        [Parameter(Position = 4)]
        [String]$Class,

        [Parameter(Position = 5)]
        [String]$Id,

        [Parameter(Position = 6)]
        [String]$Style,

        [Parameter(Position = 7)]
        [String]$value,

        [Parameter(Position = 8)]
        [Hashtable]$Attributes,

        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $false,
            Position = 9
        )]
        [scriptblock]
        $Content
    )
    Process {

        $attr = ""
        $boundParams = $PSBoundParameters
        $CommonParameters = @(
            "Debug",
            "ErrorAction",
            "ErrorVariable",
            "InformationAction",
            "InformationVariable",
            "OutVariable",
            "OutBuffer",
            "PipelineVariable",
            "Verbose",
            "WarningAction",
            "WarningVariable"
        )

        foreach ($cp in $CommonParameters) {

            $null = $boundParams.Remove($cp)
        }

        foreach ($entry in $boundParams.Keys) {

            $attr += "$($entry)=`"$($boundParams[$entry])`" "

        }



        if ($attr) {
            "<input $attr>"
        }
        else {
            throw "No attributes were defined for <input> element"
        }


    }#End process


}
