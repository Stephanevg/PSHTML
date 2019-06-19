Function b {
    <#
        .SYNOPSIS

        Generates a <b> HTML tag.
        The <b> tag defines a hyperlink, which is used to link from one page to another.
        
        .DESCRIPTION

        .PARAMETER Class
        Allows to specify one (or more) class(es) to assign the html element.
        More then one class can be assigned by seperating them with a white space.

        .PARAMETER Id
        Allows to specify an id to assign the html element.

        .PARAMETER Content
        Allows to add child element(s) inside the current opening and closing HTML tag(s).


        .EXAMPLE
        The following exapmles show cases how to create an empty a, with a class, an ID, and, custom attributes.
        
        b -Class "myclass1 MyClass2" -Id myid -Attributes @{"custom1"='val1';custom2='val2'}

        Generates the following code:

        <b Class="myclass1 MyClass2" Id="myid" custom1="val1" custom2="val2"  >
        </b>


        .NOTES
        Current version 3.1
        History:
            2019.06.18;@Josh_Burkard;initial version
        .LINK
            https://github.com/Stephanevg/PSHTML
    #>

    Param(

        [Parameter(Mandatory = $false)]
        [AllowEmptyString()]
        [AllowNull()]
        $Content,

        [AllowEmptyString()]
        [AllowNull()]
        [String]$Class,

        [String]$Id,
        
        [Hashtable]$Attributes

    )
    $tagname = "b"

    Set-htmltag -TagName $tagName -Parameters $PSBoundParameters -TagType NonVoid
    
    

}
 