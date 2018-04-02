Function address {
    <#
    .SYNOPSIS
    Generates address HTML tag.
    
    .EXAMPLE

    address {
        $twitterLink = a -href "http://twitter/stephanevg" -Target _blank -ChildItem {"@stephanevg"}
        $bloglink = a -href "http://www.powershelldistrict.com" -Target _blank -ChildItem {"www.powershelldistrict.com"}
        "written by: Stephane van Gulick" 
        "blog: $($bloglink)";
        "twitter: $($twitterLink)"
    }

    Generates the following code:

    <address>
        written by: Stephane van Gulick
        blog: <a href=http://www.powershelldistrict.com target="_blank" > www.powershelldistrict.com </a>
        twitter: <a href=http://twitter/stephanevg target="_blank" > @stephanevg </a>
    </address>

    #>
    [CmdletBinding()]
    Param(

        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $false,
            Position = 0
        )]
        [scriptblock]
        $Content,

        [Parameter(Position = 1)]
        [String]$Class,

        [Parameter(Position = 2)]
        [String]$Id,

        [Parameter(Position = 3)]
        [String]$Style,

        [Parameter(Position = 4)]
        [Hashtable]$Attributes 
    )
    Process{

        $attr = ""
        $boundParams = $PSBoundParameters
        $CommonParameters = @(
            "Debug",
            "ErrorAction",
            "ErrorVariable",
            "InaddressationAction",
            "InaddressationVariable",
            "OutVariable",
            "OutBuffer",
            "PipelineVariable",
            "Verbose",
            "WarningAction",
            "WarningVariable"
        )

        foreach ($cp in $CommonParameters){

            $null = $boundParams.Remove($cp)
        }

        foreach ($entry in $boundParams.Keys){
            if ($entry -eq 'content' -or $entry -eq 'attributes'){
                continue
            }
            $attr += "$($entry)=`"$($boundParams[$entry])`" "

        }

        if ($Attributes){
            foreach ($entry in $Attributes.Keys){

                $attr += "$($entry)=`"$($Attributes[$entry])`" "
    
            }
        }

        

        if($attr){
            "<address $attr>" 
        }else{
            "<address>"
        }

        if($Content){
            $Content.Invoke()
        }
            

        '</address>'
    }
    
    
}