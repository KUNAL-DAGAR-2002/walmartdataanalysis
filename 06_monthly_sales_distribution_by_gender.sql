SELECT * FROM walmartsales;

WITH monthly_analysis AS (
    SELECT MONTH(Date) AS Month, ROUND(SUM(Total), 2) AS Totalsales
    FROM walmartsales
    GROUP BY MONTH(Date)
),

genderbase AS (
    SELECT MONTH(ws.Date) AS Month, ws.Gender, ROUND(SUM(ws.Total), 2) AS Totalsales,
	DENSE_RANK() OVER (PARTITION BY MONTH(ws.Date), ws.Gender ORDER BY SUM(ws.Total) DESC) AS ranks
    FROM walmartsales ws
    GROUP BY MONTH(ws.Date), ws.Gender
)

SELECT ma.Month, gb.Gender, SUM(gb.Totalsales) AS Total
FROM monthly_analysis ma
JOIN genderbase gb 
ON ma.Month = gb.Month
WHERE gb.ranks = 1
GROUP BY ma.Month, gb.Gender
ORDER BY ma.Month;

