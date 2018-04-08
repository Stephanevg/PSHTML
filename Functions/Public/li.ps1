Function li {

    <#
    .SYNOPSIS
    Generates li HTML tag.
    
    .EXAMPLE
    
    ol -reversed -start 1 -type "typo" -Attributes @{Name="Kevin" ; whatever="floats your boat"} -content {
        li -content "Test entry" -Class "classy" -value 0 -Style "stylish" -Attributes @{Name="Johnny" ; bibop="bopib"}
        li "Test entry 2"
    }

    Generates the following code:

    <ol reversed="True" start="1" type="typo" reversed="true" Name="Kevin" whatever="floats your boat">
        <li Class="classy" value="0" Style="stylish" bibop="bopib" Name="Johnny">
            Test entry
        </li>
        <li>
            Test entry 2
        </li>
    </ol>
    
    .EXAMPLE
    
    It is also possible to use regular powershell logic inside a scriptblock. The example below, generates an ol element with multiple li Elements. 
    Where every li tag contains a name of a service that starts with "s".

    $Services = Get-Service | ?{$_.name.Startswith("s")}
 
    ol {
        foreach($p in $test){
            li -content "$p" -Class "classy" -value "asdf" -Style "whatever" -Attributes @{name='asdf'}
        }
    }

    Generates the following code:

    <ol>
        <li Class="classy" value="asdf" Style="whatever" name="asdf" >
            @{Name=seclogon}
        </li>
        <li Class="classy" value="asdf" Style="whatever" name="asdf" >
            @{Name=shpamsvc}
        </li>
        <li Class="classy" value="asdf" Style="whatever" name="asdf" >
            @{Name=smphost}
        </li>
        <li Class="classy" value="asdf" Style="whatever" name="asdf" >
            @{Name=spectrum}
        </li>
    </ol>

    #>

    [CmdletBinding()]
    Param(
        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $true,
            Position = 0
        )]
        $content,

        [Parameter(Position = 1)]
        [String]$Class,

        [Parameter(Position = 2)]
        [String]$value,

        [Parameter(Position = 3)]
        [String]$Style,

        [Hashtable]$Attributes
    )
    Process{

        

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
            "WarningVariable",
            "Attributes"
        )

        foreach ($cp in $CommonParameters){

            $null = $boundParams.Remove($cp)
        }

        foreach ($entry in $boundParams.Keys){
            if ($entry -eq 'content'){
                continue
            }
            $attr += "$($entry)=`"$($boundParams[$entry])`" "

        }

        if($Attributes){

            Foreach($key in $Attributes.Keys){

                $attr += '{0}="{1}" ' -f $key,$Attributes[$key]
     
            }
           
        }

        $counter = 0
        
        if($content.GetType().name -eq "Object[]"){

            foreach($item in $content){

                if($attr){
                    "<li $attr>" 
                }else{
                    "<li>"
                }
    
                if($content){
                    $content[$counter]
                }
                    
                $counter ++
    
                '</li>'
            }     

        }else{

            if($attr){
                "<li $attr>" 
            }else{
                "<li>"
            }

            if($content){
                $content
            }
                
            $counter ++

            '</li>'

        }

        
    }
    
    
}

