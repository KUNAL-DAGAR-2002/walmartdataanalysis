USE final_project;
WITH MonthlySales AS
	( SELECT Branch, MONTH(Date) AS Month, ROUND(SUM(Total),2) AS TotalSales
	  FROM walmartsales
      GROUP BY Branch, MONTH(Date)
      ),
	GrowthRate AS (SELECT Branch, Month, TotalSales,
        LAG(TotalSales) OVER (PARTITION BY Branch ORDER BY Month) AS PreviousSales,
        #Growth rate
        ROUND((TotalSales - LAG(TotalSales) OVER (PARTITION BY Branch ORDER BY Month)) / LAG(TotalSales) OVER (PARTITION BY Branch ORDER BY Month) * 100,2) AS Growth
        FROM MonthlySales
        ),
	NetGrowth AS (
		SELECT Branch, ROUND(SUM(Growth),2) AS TotalGrowth
		FROM GrowthRate
		WHERE Growth IS NOT NULL 
		GROUP BY Branch
        )
SELECT Branch, TotalGrowth
FROM NetGrowth
ORDER BY TotalGrowth DESC
LIMIT 1;

