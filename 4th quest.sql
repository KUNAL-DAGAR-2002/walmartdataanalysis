SELECT * FROM walmartsales;

#Threshold 
#1. High Anomaly -> 3% more than average
#2. Low Anomaly -> 1% Less than average
#3. Else Normal
WITH productline_wise_sales AS (
    SELECT `Product line` AS productline, ROUND(SUM(Total), 2) AS TotalSales
    FROM walmartsales
    GROUP BY productline
),
average_sales AS (
    SELECT AVG(TotalSales) AS avg_sales
    FROM productline_wise_sales
),
avg_deviation AS (
    SELECT p.productline, p.TotalSales,
	CASE
		WHEN p.TotalSales < a.avg_sales * 0.99 THEN 'Low Anomaly'
		WHEN p.TotalSales > a.avg_sales * 1.03 THEN 'High Anomaly'
		ELSE 'Normal'
	END AS Anomaly
    FROM productline_wise_sales p, average_sales a
)
SELECT productline, TotalSales, Anomaly 
FROM avg_deviation;
