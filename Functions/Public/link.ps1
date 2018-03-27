Function Get-Link {
    Param(
        [Parameter(Mandatory=$true)]
        [String]
        $href,

        [Parameter(Mandatory=$true)]
        [Validateset("alternate","author","dns-prefetch","help","icon","license","next","pingback","preconnect","prefetch","preload","prerender","prev","search","stylesheet")]
        [string]
        $rel
    )

    @"
    <link href=$href rel=$rel>
    
"@


}

