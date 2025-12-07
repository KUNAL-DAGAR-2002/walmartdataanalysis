SELECT * FROM walmartsales;
SELECT DAYNAME(Date) as Day, ROUND(SUM(Total),2) AS Total
FROM walmartsales
GROUP BY DAYNAME(Date)
ORDER BY Total DESC;
