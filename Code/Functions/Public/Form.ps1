Function Form {
    <#
    .SYNOPSIS
    Generates Form HTML tag.

    .DESCRIPTION 
    Generates the HTML FORM tag for form manipulations.

    .PARAMETER Action
    Specifiy which URL should be called when the form is called.

    .PARAMETER Method
    The HTTP method to use when sending form-data.
    Acceptable values are:
    GET
    POST

    .PARAMETER Target
    Specifies where to display the response that is received after submitting the form.
    Acceptable values are:
    _blank
    _self (default)
    _parent
    _top

    If this parameter is not called, it will default to target=_self

    .Parameter Enctyp
    This is a dynamic parameter, which is only available when 'Method' is set to 'post'.
    The available values are:
    -"application/x-www-form-urlencoded"
    -"multipart/form-data"
    -"text/plain"

    See here for more information --> https://www.w3schools.com/tags/att_form_enctype.asp

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

    form "/action_Page.php" post _self

    Generates the following html element: (Not very usefull, we both agree on that)

    <from action="/action_Page.php" method="post" target="_self" >
    </form>

    .EXAMPLE
    The following Example show how to pass custom HTML tag and their values
    form "/action_Page.php" post _self -attributes @{"Woop"="Wap";"sap"="sop"}

    .NOTES
    Current version 3.1
    History:
    2018.10.30;@ChristopheKumor;Updated to version 3.0
        2018.04.08;Stephanevg; Fixed custom Attributes display bug. Updated help
        2018.04.01;Stephanevg;Fix disyplay bug.
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [CmdletBinding()]
    Param(

        [Parameter(Mandatory = $true, Position = 0)]
        [String]$action,

        [Parameter(Mandatory = $true, Position = 1)]
        [ValidateSet("get", "post")]
        [String]$method = "get",

        [Parameter(Mandatory = $false, Position = 2)]
        [ValidateSet("_blank", "_self", "_parent", "top")]
        [String]$target,

        [Parameter(Position = 3)]
        [String]$Class,

        [Parameter(Position = 4)]
        [String]$Id,

        [Parameter(Position = 5)]
        [String]$Style,

        [Parameter(Position = 6)]
        [Hashtable]$Attributes,

        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $false,
            Position = 7
        )]
        $Content
    )
    DynamicParam{
        If($method -eq 'Post'){
            $ParameterName = 'enctype'
            $Attribute = New-Object System.Management.Automation.ParameterAttribute
            $Attribute.HelpMessage = "Please enter encoding type"
            $Attribute.Mandatory = $True

            $ValidateSetValues = @("application/x-www-form-urlencoded","multipart/form-data","text/plain")
            $ValidateSet = New-Object System.Management.Automation.ValidateSetAttribute($ValidateSetValues)
            $attributeCollection = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
            $attributeCollection.add($ValidateSet)
            $attributeCollection.Add($Attribute)
            $Para = New-Object System.Management.Automation.RuntimeDefinedParameter($ParameterName, [string], $attributeCollection)
            $paramDictionary = new-object System.Management.Automation.RuntimeDefinedParameterDictionary
            $paramDictionary.Add($ParameterName, $para)
            return $paramDictionary
        }
    }
    Process {
        $tagname = "form"

        if(!($Target)){
          
            $PSBoundParameters.Target = "_self"
        }
        Set-HtmlTag -TagName $tagname -Parameters $PSBoundParameters -TagType nonVoid
    }
}

