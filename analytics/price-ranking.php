<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  <title> - Price - Ranking demo</title>
  <script type='text/javascript' src='//code.jquery.com/jquery-1.9.1.js'></script>
  <link rel="stylesheet" type="text/css" href="/css/result-light.css">
  <style type='text/css'>
  </style>
  
<?php
	include 'parse-php/parse.php';
	
	$cloud = new parseCloud("getCrawlDataForAsin");
	// Setting the params
	//asin: B00BPD5M8G
	//asin: B00E8OQ9R2
	//$cloud->__set("asin"," B00BM9SERY");
	$cloud->__set("asin","B00BM9SERY");
	$cloud->__set("skip", 150);
	//$cloud->__set("limit",1000);
	// Running the cloud function
	$results = $cloud->run();
	
	$json_result = json_encode($results);

   $first = true;
   $price_str = "";
   $sales_rank_str = "";
	foreach($results->result->crawl as $result)
	{
		if(!$first) { $price_str.= ","; $sales_rank_str.=","; }
		
		$date_parts = explode('T', substr($result->crawl_date->iso, 0, strlen($result->crawl_date->iso)-5));
		
		$crawl_date = explode('-', $date_parts[0]);
		$crawl_time = explode(':', $date_parts[1]);
		
		$year = $crawl_date[0];
		$month = $crawl_date[1]-1;
		$day = $crawl_date[2];
		
		$hour = $crawl_time[0];
		$minute = $crawl_time[1];
		$second = $crawl_time[2];
		
		$price = $result->kindle_price;
		$sales_rank = $result->sales_rank;
		
      $price_str.= sprintf("[Date.UTC(%d,%d,%d,%d,%d,%d), %s]", $year, $month, $day,
      	$hour, $minute, $second, $price);
      
      $sales_rank_str.= sprintf("[Date.UTC(%d,%d,%d,%d,%d,%d), %s]", $year, $month, $day,
      	$hour, $minute, $second, $sales_rank);
		
		$first = false;
	}
?>
<script type='text/javascript'>//<![CDATA[ 
jQuery(document).ready(function ($) {
        $('#container').highcharts({
            chart: {
                zoomType: 'xy'
            },
            title: {
                text: 'BookNameHere'
            },
            subtitle: {
                text: 'Amazon Ranking and Price'
            },
            xAxis: [{
                 type: 'datetime',
                 dateTimeLabelFormats: { // don't display the year
                    month: '%e. %b',
                    year: '%b'
                }
            }],
            yAxis: [{ // Primary yAxis
                title: {
                    text: 'Price',
                    style: {
                        color: '#89A54E'
                    }
                },
                min: 0,
                labels: {
                    format: '${value}',
                    style: {
                        color: '#89A54E'
                    }
                },
                opposite: true
            },
                { // Secondary yAxis
                labels: {
                    format: '{value}',
                    style: {
                        color: '#4572A7'
                    }
                },
                min: 0,
                title: {
                    text: 'Ranking',
                    style: {
                        color: '#4572A7'
                    }
                },
            	reversed: true,
            }],
            tooltip: {
                shared: true
            },
            legend: {
                layout: 'vertical',
                align: 'left',
                x: 320,
                verticalAlign: 'top',
                y: 60,
                floating: true,
                backgroundColor: '#FFFFFF'
            },
            series: [{
                name: 'Price',
                color: '#89A54E',
                type: 'column',
                data: [
                	<?php  echo $price_str; ?>
                ],
                tooltip: {
                    valuePrefix: '$',
                    valueDecimals: '2'
                }
            },{
                name: 'Ranking',
                color: '#4572A7',
                type: 'spline',
                yAxis: 1,
                data: [
                	<?php  echo $sales_rank_str; ?>
                ],
                tooltip: {
                    valueSuffix: ' '
                }
            }]
        });
    });
//]]>  
</script>
</head>
<body>
<script src="http://code.highcharts.com/highcharts.js"></script>
<script src="http://code.highcharts.com/modules/exporting.js"></script>
<div id="container" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
</body>
</html>