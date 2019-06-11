<#
    This example uses download information from a specific meetup group using MeetupPS.
    The data gathered using Meetup PS will be displayed in a Chart using PSHTML New-PSHTMLChart
#>

# Connect against Meetup.com API
import-module PSHTML
Import-Module MeetupPS

$MeetupGroupName = 'FrenchPSUG'
$Key = "" #Set your Meetup key
$Secret = "" # Your Meetup Secret
Set-MeetupConfiguration -ClientID $Key -Secret $Secret

$CanvasID = "canvasAttendance"
$HTMLPageMeetup = html { 
    head {
        title 'PSHTML Charts using Charts.js'
        
    }
    body {
        
        h1 "Generated using PSHTML"

        div {

           p {
               "The following chart has been generated using PSHTML Chart.js and MeetupPS"
           }
           canvas -Height 600 -Width 800 -Id $CanvasID {
    
           }
       }

         script -src "https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.3/Chart.min.js" -type "text/javascript"


        script -content {

            $Data = Get-MeetupEvent -GroupName $MeetupGroupName -Status past | Sort 'local_date' | select Local_date,yes_rsvp_count
            $DataSetMeetup = [dataSet]::New($Data.'yes_rsvp_count',"Num Attendees")
            $DataSetMeetup.backgroundColor = [Color]::blue
            $MeetupLabels = $data.'local_date'
            New-PSHTMLBarChart -DataSet @($DataSetMeetup) -title "FRPSUG meetup Statistics over time" -Labels $MeetupLabels -canvasID $CanvasID 
            # -Responsive
        }

         
    }
}

$OutPath = ".\MeetupGraph.html"
$HTMLPageMeetup | out-file -FilePath $OutPath -Encoding utf8
start $outpath