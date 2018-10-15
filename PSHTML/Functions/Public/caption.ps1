Function Caption {
    <#
        .SYNOPSIS
        Generates a caption HTML tag.

        .PARAMETER Class
        Allows to specify one (or more) class(es) to assign the html element.
        More then one class can be assigned by seperating them with a white space.

        .PARAMETER Id
        Allows to specify an id to assign the html element.

        .PARAMETER Style
        Allows to specify in line CSS style to assign the html element.

        .PARAMETER Content
        Allows to add child element(s) inside the current opening and closing HTML tag(s).


        .EXAMPLE
        The following exapmles show cases how to create an empty caption, with a class, an ID, and, custom attributes.
        caption -Class "myclass1 MyClass2" -Id myid -Attributes @{"custom1"='val1';custom2='val2'}

        Generates the following code:

        <caption Class="myclass1 MyClass2" Id="myid" custom1="val1" custom2="val2"  >
        </caption>

        .EXAMPLE
        The caption is used in the construction of the HTML table. The following example illustrates how the caption could be used.

        table{
                    caption "This is a table generated with PSHTML"
                    thead {
                        tr{
                            th "number1"
                            th "number2"
                            th "number3"
                        }
                    }
                    tbody{
                        tr{
                            td "Child 1.1"
                            td "Child 1.2"
                            td "Child 1.3"
                        }
                        tr{
                            td "Child 2.1"
                            td "Child 2.2"
                            td "Child 2.3"
                        }
                    }
                    tfoot{
                        tr{
                            td "Table footer"
                        }
                    }
                }
            }
        .LINK
            https://github.com/Stephanevg/PSHTML
        .NOTES
        Current version 1.1.0
        History:
            2018.04.10;Stephanevg; Added parameters
            2018.04.01;Stephanevg;Creation.

        Information on the Caption HTML tag can be found here --> https://www.w3schools.com/tags/tag_caption.asp
    #>

    Param(

        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $false,
            Position = 0
        )]
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
        $CommonParameters = ("Attributes", "Content") + [System.Management.Automation.PSCmdlet]::CommonParameters + [System.Management.Automation.PSCmdlet]::OptionalCommonParameters
        $CustomParameters = $PSBoundParameters.Keys | Where-Object -FilterScript { $_ -notin $CommonParameters }

        if($CustomParameters){

            foreach ($entry in $CustomParameters){


                $Attr += "{0}=`"{1}`" " -f $entry,$PSBoundParameters[$entry]

            }

        }

        if($Attributes){
            foreach($entry in $Attributes.Keys){

                $attr += "{0}=`"{1}`" " -f $entry,$Attributes[$Entry]
            }
        }

        if($attr){
            "<caption {0} >"  -f $attr
        }else{
            "<caption>"
        }



        if($Content){

            if($Content -is [System.Management.Automation.ScriptBlock]){
                $Content.Invoke()
            }else{
                $Content
            }
        }


        '</caption>'
    }


}