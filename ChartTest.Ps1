

$TemplateScript = @"
var ctx = document.getElementById("##GraphID##").getContext('2d');
var myChart = new Chart(ctx, {
    type: 'bar',
    data: {
        labels: ["Red", "Blue", "Yellow", "Green", "Purple", "Orange"],
        datasets: [{
            label: '# of Votes',
            data: [12, 19, 3, 5, 2, 3],
            backgroundColor: [
                'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)',
                'rgba(75, 192, 192, 0.2)',
                'rgba(153, 102, 255, 0.2)',
                'rgba(255, 159, 64, 0.2)'
            ],
            borderColor: [
                'rgba(255,99,132,1)',
                'rgba(54, 162, 235, 1)',
                'rgba(255, 206, 86, 1)',
                'rgba(75, 192, 192, 1)',
                'rgba(153, 102, 255, 1)',
                'rgba(255, 159, 64, 1)'
            ],
            borderWidth: 1
        }]
    },
    options: {
        scales: {
            yAxes: [{
                ticks: {
                    beginAtZero:true
                }
            }]
        }
    }
});
"@
$GraphID = "pshtmlgraph"
$Script = $TemplateScript.Replace("##GraphID##",$GraphID)
$HTMLPage = html {
    head {
        title 'Chart JS Demonstration'
        
    }
    body {
        
         canvas -Height 500px -Width 500px -Id $GraphID {

         }
         script -src "https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.3/Chart.min.js" -type "text/javascript"
         script -content {
             $Script
         }
         
    }
}


$OutPath = "C:\Users\taavast3\OneDrive\Repo\Projects\OpenSource\PSHTML\PSHTML\Assets\Charts\Graph.html"
$HTMLPage | out-file -FilePath $OutPath -Encoding utf8