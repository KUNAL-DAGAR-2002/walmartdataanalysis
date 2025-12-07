SELECT * FROM walmartsales;
SELECT `Customer ID` AS custid, ROUND(SUM(Total),2) AS Totalsales
FROM walmartsales
GROUP BY `Customer ID`
ORDER BY Totalsales DESC
LIMIT 5;
