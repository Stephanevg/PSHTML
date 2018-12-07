# Connect against Meetup.com API
# import-module C:\Users\taavast3\OneDrive\Repo\Projects\OpenSource\PSHTML\PSHTML\PSHTML.psd1 -force
#Import-Module MeetupPS
$Key = '1tuvvavlcf38a2f5r4skeorjed'
$Secret = 'f03pp1t8rnk0ub52fdsa9fmpk0'
$MeetupGroupName = 'FrenchPSUG'
#Set-MeetupConfiguration -ClientID $Key -Secret $Secret
#Get-MeetupGroup -GroupName $MeetupGroupName

#Get-MeetupEvent -GroupName $MeetupGroupName -Status past | select time,yes_rsvp_count

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
            <# $Data1 = @("4","7","11","21")
            $Data2 = @("7","2","13","17")
            $dataSet1 = [dataSet]::New($Data1,"Dataset1")
            $dataSet1.backgroundColor = [Color]::blue
            $dataSet2 = [dataSet]::New($Data2,"Dataset2")
            $dataSet2.backgroundColor = [Color]::red
            $Labels = @("Wins","Looses","Draws","Give ups") #>
            
            $Data = Get-MeetupEvent -GroupName $MeetupGroupName -Status past | Sort 'local_date' | select Local_date,yes_rsvp_count
            $DataSetMeetup = [dataSet]::New($Data.'yes_rsvp_count',"Num Attendees")
            $DataSetMeetup.backgroundColor = [Color]::blue
            $MeetupLabels = $data.'local_date'
            New-PSHTMLBarChart -DataSet @($DataSetMeetup) -title "FRPSUG meetup Statistics over time" -Labels $MeetupLabels -canvasID $CanvasID 
            # -Responsive
        }

         
    }
}

$OutPath = "C:\Users\taavast3\OneDrive\Repo\Projects\OpenSource\PSHTML\PSHTML\Assets\Charts\MeetupGraph.html"
$HTMLPageMeetup | out-file -FilePath $OutPath -Encoding utf8
start $outpath