$TestsPath = Split-Path $MyInvocation.MyCommand.Path

$RootFolder = (get-item $TestsPath).Parent

Push-Location -Path $RootFolder.FullName

set-location -Path $RootFolder.FullName

Write-Verbose "Importing module"

import-module .\PSHTML -Force

InModuleScope PSHTML {

    Describe "Testing New-PSHTMLChart | General options" {

        it '[New-PSHTMLChart][Parameterless] Should throw' {
            {New-PSHTMLChart} | should throw
        }
    }

    Describe "Testing New-PSHTMLChart -Type Bar" {


        $Labels = @("january", "february")
        $Data = @(3, 5)
        $Title = "Test Title"
        $CanvasID = "TestCanvasID"

        $bds = New-PSHTMLChartBarDataSet -Data $Data

        $Is = New-PSHTMLChart -Type bar -DataSet $bds -Labels $Labels -Title $Title -CanvasID $CanvasID
        $SplittedIsString = $Is -Split 'new Chart\(ctx,' #the .split() returns different results depepending on the powershell
        
        $ChartJsonbject = ConvertFrom-Json $SplittedIsString[-1].TrimEnd(");")

        it '[New-PSHTMLChart][-Type Bar][-DataSet BarDataSet][Label][Title][CanvasId] Should create ChartJS javascript Code' {
            $JavaScriptStartString = @'
var ctx = document.getElementById("TestCanvasID").getContext('2d'); var myChart = 
'@


            $SplittedIsString[0] | Should -be $JavaScriptStartString

            #Converting Json data back to an object, to ease testing.
            #In powershell 7, some properties are not located in the correct place, but the data is there. This was breaking the orignal tests, although all the data was still there.
            #This is why the test is done in this way.



            
        }
        
        it '[New-PSHTMLChart][-Type Bar][-DataSet BarDataSet][Label][Title][CanvasId] Javascript string should have: Dataset(s)' {
            $ChartJsonbject.data.datasets.count | Should -Be 1
            
        }
        
        it '[New-PSHTMLChart][-Type Bar][-DataSet BarDataSet][Label][Title][CanvasId] Javascript string should have: Type should be radar' {
            $ChartJsonbject.type | Should -be 'bar'
        }
        
        it '[New-PSHTMLChart][-Type Bar][-DataSet BarDataSet][Label][Title][CanvasId] Javascript string should have: correct labels' {
            foreach ($Label in $Labels) {
                $Label | Should -BeIn $ChartJsonbject.data.labels  
            } 
            
        }
        
        it '[New-PSHTMLChart][-Type Bar][-DataSet BarDataSet][Label][Title][CanvasId] Javascript string should have: option object with right title.' {
            $ChartJsonbject.options.title.text | Should -Be "Test Title"
            
        }

    } -tag "Chart", "Bar"

    Describe "Testing New-PSHTMLChart -Type horizontalBar" {


        $Labels = @("january", "february")
        $Data = @(3, 5)
        $Title = "Test Title"
        $CanvasID = "TestCanvasID"

        $bds = New-PSHTMLChartBarDataSet -Data $Data

        $Is = New-PSHTMLChart -Type horizontalBar -DataSet $bds -Labels $Labels -Title $Title -CanvasID $CanvasID
        $SplittedIsString = $Is -Split 'new Chart\(ctx,' #the .split() returns different results depepending on the powershell
        
        $ChartJsonbject = ConvertFrom-Json $SplittedIsString[-1].TrimEnd(");")

        it '[New-PSHTMLChart][-Type horizontalBar][-DataSet BarDataSet][Label][Title][CanvasId] Should create ChartJS javascript Code' {
            $JavaScriptStartString = @'
var ctx = document.getElementById("TestCanvasID").getContext('2d'); var myChart = 
'@


            $SplittedIsString[0] | Should -be $JavaScriptStartString

            #Converting Json data back to an object, to ease testing.
            #In powershell 7, some properties are not located in the correct place, but the data is there. This was breaking the orignal tests, although all the data was still there.
            #This is why the test is done in this way.



            
        }
        
        it '[New-PSHTMLChart][-Type horizontalBar][-DataSet BarDataSet][Label][Title][CanvasId] Javascript string should have: Dataset(s)' {
            $ChartJsonbject.data.datasets.count | Should -Be 1
            
        }
        
        it '[New-PSHTMLChart][-Type horizontalBar][-DataSet BarDataSet][Label][Title][CanvasId] Javascript string should have: Type should be radar' {
            $ChartJsonbject.type | Should -be 'HorizontalBar'
        }
        
        it '[New-PSHTMLChart][-Type horizontalBar][-DataSet BarDataSet][Label][Title][CanvasId] Javascript string should have: correct labels' {
            foreach ($Label in $Labels) {
                $Label | Should -BeIn $ChartJsonbject.data.labels  
            } 
            
        }
        
        it '[New-PSHTMLChart][-Type horizontalBar][-DataSet BarDataSet][Label][Title][CanvasId] Javascript string should have: option object with right title.' {
            $ChartJsonbject.options.title.text | Should -Be "Test Title"
            
        }

    } -tag "Chart", "horizontalBar"

    Describe "Testing New-PSHTMLChart -Type Radar" {


        $Labels = @("january", "february")
        $Title = "Test Title"
        $CanvasID = "TestCanvasID"
        $Data1 = @(17,25,18,17,22,30,35,44,4,1,6,12)
        
        #Hack to load the [System.Drawing.Color] ahead of time needed for Get-PSHTMLColor
        #read more here -> https://github.com/PowerShell/vscode-powershell/issues/219
        #Microsoft.PowerShell.Management\Get-Clipboard | Out-Null
        Add-Type -Assembly System.Drawing
        $bds = New-PSHTMLChartRadarDataSet -Data $data1 -label "2018" -borderColor (get-pshtmlColor -color blue) -backgroundColor "transparent" -hoverBackgroundColor (get-pshtmlColor -color green) -PointRadius 2 

        $Is = New-PSHTMLChart -Type radar -DataSet $bds -Labels $Labels -Title $Title -CanvasID $CanvasID        
        $SplittedIsString = $Is -Split 'new Chart\(ctx,' #the .split() returns different results depepending on the powershell
        
        $ChartJsonbject = ConvertFrom-Json $SplittedIsString[-1].TrimEnd(");")

        it '[New-PSHTMLChart][-Type Radar][-DataSet ChartRadarDataSet][Label][Title][CanvasId] Should create ChartJS javascript Code' {
            $JavaScriptStartString = @'
var ctx = document.getElementById("TestCanvasID").getContext('2d'); var myChart = 
'@


            $SplittedIsString[0] | Should -be $JavaScriptStartString

            #Converting Json data back to an object, to ease testing.
            #In powershell 7, some properties are not located in the correct place, but the data is there. This was breaking the orignal tests, although all the data was still there.
            #This is why the test is done in this way.



            
        }
        
        it '[New-PSHTMLChart][-Type Radar][-DataSet ChartRadarDataSet][Label][Title][CanvasId] Javascript string should have: Dataset(s)' {
            $ChartJsonbject.data.datasets.count | Should -Be 1
            
        }
        
        it '[New-PSHTMLChart][-Type Radar][-DataSet ChartRadarDataSet][Label][Title][CanvasId] Javascript string should have: Type should be radar' {
            $ChartJsonbject.type | Should -be 'radar'
        }
        
        it '[New-PSHTMLChart][-Type Radar][-DataSet ChartRadarDataSet][Label][Title][CanvasId] Javascript string should have: correct labels' {
            foreach($Label in $Labels) {
                $Label | Should -BeIn $ChartJsonbject.data.labels  
            } 
            
        }
        
        it '[New-PSHTMLChart][-Type Radar][-DataSet ChartRadarDataSet][Label][Title][CanvasId] Javascript string should have: option object with right title.' {
            $ChartJsonbject.options.title.text | Should -Be "Test Title"
            
        }


    } -tag "Chart", "Radar"

    Describe "Testing New-PSHTMLChart -Type polarArea" {

        $Labels = @('red', 'green', 'yellow', 'grey', 'blue')
        $Data = @(3, 5,7,2,9)
        $Title = "Test Title"
        $CanvasID = "TestCanvasID"
        $BackgroundColor = @('red', 'green', 'yellow', 'grey', 'blue')

        $bds = New-PSHTMLChartPolarAreaDataSet -Data $data1 -label "2018" -borderColor (get-pshtmlColor -color blue) -backgroundColor "transparent" -hoverBackgroundColor (get-pshtmlColor -color green)

        $Is = New-PSHTMLChart -Type polarArea -DataSet $bds -Labels $Labels -Title $Title -CanvasID $CanvasID
        $SplittedIsString = $Is -Split 'new Chart\(ctx,' #the .split() returns different results depepending on the powershell
        
        $ChartJsonbject = ConvertFrom-Json $SplittedIsString[-1].TrimEnd(");")

        it '[New-PSHTMLChart][-Type polarArea][-DataSet PolarAreaDataSet][Label][Title][CanvasId] Should create ChartJS javascript Code' {
            $JavaScriptStartString = @'
var ctx = document.getElementById("TestCanvasID").getContext('2d'); var myChart = 
'@


            $SplittedIsString[0] | Should -be $JavaScriptStartString

            #Converting Json data back to an object, to ease testing.
            #In powershell 7, some properties are not located in the correct place, but the data is there. This was breaking the orignal tests, although all the data was still there.
            #This is why the test is done in this way.



            
        }
        
        it '[New-PSHTMLChart][-Type polarArea][-DataSet PolarAreaDataSet][Label][Title][CanvasId] Javascript string should have: Dataset(s)' {
            $ChartJsonbject.data.datasets.count | Should -Be 1
            
        }
        
        it '[New-PSHTMLChart][-Type polarArea][-DataSet PolarAreaDataSet][Label][Title][CanvasId] Javascript string should have: Type should be radar' {
            $ChartJsonbject.type | Should -be 'PolarArea'
        }
        
        it '[New-PSHTMLChart][-Type polarArea][-DataSet PolarAreaDataSet][Label][Title][CanvasId] Javascript string should have: correct labels' {
            foreach ($Label in $Labels) {
                $Label | Should -BeIn $ChartJsonbject.data.labels  
            } 
            
        }
        
        it '[New-PSHTMLChart][-Type polarArea][-DataSet PolarAreaDataSet][Label][Title][CanvasId] Javascript string should have: option object with right title.' {
            $ChartJsonbject.options.title.text | Should -Be "Test Title"
            
        }


    } -tag "Chart", "polarArea"


    Describe "Testing New-PSHTMLChart -Type Pie" {

        $Labels = @("january", "february")
        $Data = @(3, 5)
        $Title = "Test Title"
        $CanvasID = "TestCanvasID"

        $bds = New-PSHTMLChartPieDataSet -Data $Data

        $Is = New-PSHTMLChart -Type Pie -DataSet $bds -Labels $Labels -Title $Title -CanvasID $CanvasID
        $SplittedIsString = $Is -Split 'new Chart\(ctx,' #the .split() returns different results depepending on the powershell
        
        $ChartJsonbject = ConvertFrom-Json $SplittedIsString[-1].TrimEnd(");")

        it '[New-PSHTMLChart][-Type Pie][-DataSet PieDataSet][Label][Title][CanvasId] Should create ChartJS javascript Code' {
            $JavaScriptStartString = @'
var ctx = document.getElementById("TestCanvasID").getContext('2d'); var myChart = 
'@

            $SplittedIsString[0] | Should -be $JavaScriptStartString

            #Converting Json data back to an object, to ease testing.
            #In powershell 7, some properties are not located in the correct place, but the data is there. This was breaking the orignal tests, although all the data was still there.
            #This is why the test is done in this way.

        }
        
        it '[New-PSHTMLChart][-Type Pie][-DataSet PieDataSet][Label][Title][CanvasId] Javascript string should have: Dataset(s)' {
            $ChartJsonbject.data.datasets.count | Should -Be 1
            
        }
        
        it '[New-PSHTMLChart][-Type Pie][-DataSet PieDataSet][Label][Title][CanvasId] Javascript string should have: Type should be radar' {
            $ChartJsonbject.type | Should -be 'Pie'
        }
        
        it '[New-PSHTMLChart][-Type Pie][-DataSet PieDataSet][Label][Title][CanvasId] Javascript string should have: correct labels' {
            foreach ($Label in $Labels) {
                $Label | Should -BeIn $ChartJsonbject.data.labels  
            } 
            
        }
        
        it '[New-PSHTMLChart][-Type Pie][-DataSet PieDataSet][Label][Title][CanvasId] Javascript string should have: option object with right title.' {
            $ChartJsonbject.options.title.text | Should -Be "Test Title"
            
        }

    } -Tag "Chart","Pie"

    Describe "Testing New-PSHTMLChart -Type Doughnut" {


        $Title = "Test Title"
        $CanvasID = "TestCanvasID"
        $Data1 = @(34,7,11,19)

        $Labels = @("Closed","Unresolved","Pending","Open")
        $colors = @("LightGreen","Red","LightBlue","LightYellow")
        
        $bds = New-PSHTMLChartDoughnutDataSet -Data $data1 -label "March" -backgroundcolor $colors

        $Is = New-PSHTMLChart -Type doughnut -DataSet $bds -Labels $Labels -Title $Title -CanvasID $CanvasID
        $SplittedIsString = $Is -Split 'new Chart\(ctx,' #the .split() returns different results depepending on the powershell
        
        $ChartJsonbject = ConvertFrom-Json $SplittedIsString[-1].TrimEnd(");")

        it '[New-PSHTMLChart][-Type Doughnut][-DataSet DoughnutDataSet][Label][Title][CanvasId] Should create ChartJS javascript Code' {
            $JavaScriptStartString = @'
var ctx = document.getElementById("TestCanvasID").getContext('2d'); var myChart = 
'@

            $SplittedIsString[0] | Should -be $JavaScriptStartString

            #Converting Json data back to an object, to ease testing.
            #In powershell 7, some properties are not located in the correct place, but the data is there. This was breaking the orignal tests, although all the data was still there.
            #This is why the test is done in this way.

        }
        
        it '[New-PSHTMLChart][-Type Doughnut][-DataSet DoughnutDataSet][Label][Title][CanvasId] Javascript string should have: Dataset(s)' {
            $ChartJsonbject.data.datasets.count | Should -Be 1
            
        }
        
        it '[New-PSHTMLChart][-Type Doughnut][-DataSet DoughnutDataSet][Label][Title][CanvasId] Javascript string should have: Type should be radar' {
            $ChartJsonbject.type | Should -be 'Doughnut'
        }
        
        it '[New-PSHTMLChart][-Type Doughnut][-DataSet DoughnutDataSet][Label][Title][CanvasId] Javascript string should have: correct labels' {
            foreach ($Label in $Labels) {
                $Label | Should -BeIn $ChartJsonbject.data.labels  
            } 
            
        }
        
        it '[New-PSHTMLChart][-Type Doughnut][-DataSet DoughnutDataSet][Label][Title][CanvasId] Javascript string should have: option object with right title.' {
            $ChartJsonbject.options.title.text | Should -Be "Test Title"
            
        }


    } -Tag "Chart","Doughnut"
    
    Describe "Testing New-PSHTMLChart -Type Line" {


        $Labels = @("january", "february")
        $Data = @(3, 5)
        $Data2 = @(12, 15)
        $Title = "Test Title"
        $CanvasID = "TestCanvasID"
        #$bds = 
        <# mock -CommandName New-PSHTMLChartBarDataSet -MockWith {
                New-MockObject -Type "datasetbar"
            } #>
        $bds = New-PSHTMLChartLineDataSet -Data $Data
        $bds2 = New-PSHTMLChartLineDataSet -Data $Data2
            
        $Is = New-PSHTMLChart -Type Line -DataSet $bds -Labels $Labels -Title $Title -CanvasID $CanvasID
        $SplittedIsString = $Is -Split 'new Chart\(ctx,' #the .split() returns different results depepending on the powershell
        
        $ChartJsonbject = ConvertFrom-Json $SplittedIsString[-1].TrimEnd(");")

        it '[New-PSHTMLChart][-Type Line][-DataSet LineDataSet][Label][Title][CanvasId] Should create ChartJS javascript Code' {
            $JavaScriptStartString = @'
var ctx = document.getElementById("TestCanvasID").getContext('2d'); var myChart = 
'@

            $SplittedIsString[0] | Should -be $JavaScriptStartString

            #Converting Json data back to an object, to ease testing.
            #In powershell 7, some properties are not located in the correct place, but the data is there. This was breaking the orignal tests, although all the data was still there.
            #This is why the test is done in this way.

        }
        
        it '[New-PSHTMLChart][-Type Line][-DataSet LineDataSet][Label][Title][CanvasId] Javascript string should have: Dataset(s)' {
            $ChartJsonbject.data.datasets.count | Should -Be 1
            
        }
        
        it '[New-PSHTMLChart][-Type Line][-DataSet LineDataSet][Label][Title][CanvasId] Javascript string should have: Type should be radar' {
            $ChartJsonbject.type | Should -be 'Line'
        }
        
        it '[New-PSHTMLChart][-Type Line][-DataSet LineDataSet][Label][Title][CanvasId] Javascript string should have: correct labels' {
            foreach ($Label in $Labels) {
                $Label | Should -BeIn $ChartJsonbject.data.labels  
            } 
            
        }
        
        it '[New-PSHTMLChart][-Type Line][-DataSet LineDataSet][Label][Title][CanvasId] Javascript string should have: option object with right title.' {
            $ChartJsonbject.options.title.text | Should -Be "Test Title"
            
        }


        it '[New-PSHTMLChart][-Type Line][-DataSet Multiple LineDataSet][Label][Title][CanvasId] Should create ChartJS javascript Code' {
            $Is = New-PSHTMLChart -Type Line -DataSet $bds,$bds2 -Labels $Labels -Title $Title -CanvasID $CanvasID
            $SplittedIsString = $Is -Split 'new Chart\(ctx,' #the .split() returns different results depepending on the powershell
        
            $ChartJsonbject = ConvertFrom-Json $SplittedIsString[-1].TrimEnd(");")
            $ChartJsonbject.data.datasets.count | Should -Be 2
        }


    } -tag "Chart", "Line"
}
