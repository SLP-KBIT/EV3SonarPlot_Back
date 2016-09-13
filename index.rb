#!/usr/local/bin/ruby

require 'cgi'

cgi = CGI.new
puts cgi.header('charset' => 'UTF-8')

data = File.read('./plots.csv').split(',')
data = data.slice!(270...360) + data  # 90度反時計回り

plots = []
data.each.with_index do |d, i|
  h = d.to_i
  next if h == -1
  t = (i / 180.0) * Math::PI
  plots << [Math.cos(t) * h, Math.sin(t) * h]
end

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
           #{ plots.empty? ? '[0,0]' : plots.map(&:inspect).join(',') }
         ]);

         var options = {
           title: 'Sonar Plot',
           hAxis: { minValue: -45, maxValue: 45 },
           vAxis: { minValue: -45, maxValue: 45 },
           legend: 'none'
         };

         var chart = new google.visualization.ScatterChart(document.getElementById('chart_div'));
         chart.draw(data, options);
       }
    </script>
  </head>
  <body>
    <h2>#{'最終送信日時 ' + File.stat('./plots.csv').mtime.strftime('%Y.%m.%d %H:%M:%S')}</h2>
    #{ '<h3 style="color: red">No Data</h3>' if plots.empty? }
    <div id="chart_div" style="width: 600px; height: 600px;" />
  </body>
</html>
EOS

