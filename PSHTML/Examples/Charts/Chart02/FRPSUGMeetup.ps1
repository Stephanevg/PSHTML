<#
    This example uses download information from a specific meetup group using MeetupPS.
    The data gathered using Meetup PS will be displayed in a Chart using PSHTML New-PSHTMLChart
#>

# Connect against Meetup.com API
using module PSHTML
Import-Module MeetupPS

$MeetupGroupName = 'Research-Triangle-PowerShell-Users-Group'#'PowerShell-Birmingham-UK'#'FrenchPSUG'
$Key = "" #Set your Meetup key
$Secret = "" # Your Meetup Secret
#Set-MeetupConfiguration -ClientID $Key -Secret $Secret

$CanvasID = "canvasAttendance"
$HTMLPageMeetup = html { 
    head {
        title 'Meetup information'
        Write-PSHTMLAsset -Name Chartjs
        Link -rel stylesheet -href 'https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css'
    }
    body {
        
        

        div -class "Container" -Content {

            h1 {
                "Meetup information"
            } -class 'text-center'
           p {
               "The following chart has been generated using PSHTML Chart.js and MeetupPS"
           } -Class "text-center"
           div -Content {

               canvas -Height 600 -Width 800 -Id $CanvasID {
    
               } -Style 'display:inline'

               $PSHTMLlink = a {"PSHTML"} -href "https://github.com/Stephanevg/PSHTML"
        
               $PSHTMLLove = h6 "Generated with &#x2764 using $($PSHTMLlink)" -Class "text-center"

               $Data = Get-MeetupEvent -GroupName $MeetupGroupName -Status past | Sort 'local_date' | select Local_date,yes_rsvp_count,Name,Description
            
                $DataSetMeetup = New-PSHTMLChartBarDataSet -Data $Data.'yes_rsvp_count' -label 'Num Attendees' -backgroundColor ([Color]::blue)
            
                $MeetupLabels = $data.'local_date'
                $newSort = $Data | sort Local_date -Descending
                $AccordionID = 'custom_accordion'
                div -Class "accordion" -Id $AccordionID -Content {
                    Foreach($event in $NewSort){
                    $Cont = 1
                        div -Class 'card' -Content {
                            div -Class "card-header" -id "card_head_$($count)" -Content {
                              h2 -class "mb-0" -Content {
                                button -class 'btn btn-link' -Content {
                                    $($Event.Name)
                                } -Attributes @{'type'='button';'data-toggle'="collapse"; 'data-target'="#card_body_$($count)";'aria-expanded'="false";'aria-controls'="card_body_$($count)"}
                              }  
                            }
                        }
                        Div -Id "card_body_$($count)" -Class 'collapse show'  -Content {
                            div -Class "card-body" -Content {
                                $($Event.Description)
                            }
                        } -Attributes @{'aria-labelledby'= "card_head_$($count)";'data-parent'=$AccordionID}
                        #h2 {$($Event.Name)}
                        #p {
                        #    $Event.Description
                        #}
                        $count++
                    }#end foreach

                }


           } -class 'text-center'
       }

        #script -src "https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.3/Chart.min.js" -type "text/javascript"


        script -content {

            $Data = Get-MeetupEvent -GroupName $MeetupGroupName -Status past | Sort 'local_date' | select Local_date,yes_rsvp_count,Name,Description
            
                $DataSetMeetup = New-PSHTMLChartBarDataSet -Data $Data.'yes_rsvp_count' -label 'Num Attendees' -backgroundColor ([Color]::blue)
            
                $MeetupLabels = $data.'local_date'
            New-PSHTMLChart -Type bar -DataSet $DataSetMeetup -Title "$($MeetupGroupName) meetup Statistics over time" -Labels $MeetupLabels -canvasID $CanvasID

        }

     script -src "https://code.jquery.com/jquery-3.3.1.slim.min.js" -integrity "sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" -crossorigin "anonymous"
     script -src "https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" -integrity "sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" -crossorigin 'anonymous'
     script -src "https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" -integrity "sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" -crossorigin 'anonymous'
    }
    Footer {
        $PSHTMLLove
    }
}

$OutPath = ".\013_meetup.html"
$HTMLPageMeetup | out-file -FilePath $OutPath -Encoding utf8
start $outpath