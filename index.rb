#!/usr/local/bin/ruby

require 'cgi'

cgi = CGI.new
puts cgi.header('charset' => 'UTF-8')

puts <<EOS
<html>
  <head>
    <title>EV3SonarPlot</title>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
     <script type="text/javascript">
       google.charts.load('current', {'packages':['corechart']});
       google.charts.setOnLoadCallback(drawChart);

       function drawChart() {
         var data = new google.visualization.arrayToDataTable([
           ['X', 'Y'],
           [8, 12],
           [4, 5],
           [11, 14],
           [4, 5],
           [3, 4],
           [7, 7]
         ]);

         var options = {
           title: 'Sonar Plot',
           hAxis: { minValue: -50, maxValue: 50 },
           vAxis: { minValue: -50, maxValue: 50 },
           legend: 'none'
         };

         var chart = new google.visualization.ScatterChart(document.getElementById('chart_div'));
         chart.draw(data, options);
       }
    </script>
  </head>
  <body>
    <div id="chart_div" style="width: 600px; height: 600px;" />
  </body>
</html>
EOS

