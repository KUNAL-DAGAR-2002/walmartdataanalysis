SELECT * FROM walmartsales;

#Approach
#1. Average is calculated.
#2. Low Total purchase less than avg - avg*0.1 i.e 10% below threshold
#2.  High Total purchase greater than avg+avg*0.1 i.e 10% above threshold
#3. Else medium

WITH cust_group_by AS 
	(SELECT `Customer ID` AS cust_id, ROUND(SUM(Total),2) AS Total
	FROM Walmartsales
	GROUP BY cust_id),
    avgTotal AS (
    SELECT
    AVG(Total) AS average,
    ROUND(AVG(Total) - AVG(Total)*0.1,2) AS lowerlimit,
    ROUND(AVG(Total) + AVG(Total)*0.1,2) AS upperlimit
    FROM cust_group_by)
SELECT cust_id, Total,
CASE
	WHEN total>upperlimit THEN 'High'
    WHEN total<lowerlimit THEN 'Low'
    ELSE 'Medium'
END AS customer_category
FROM cust_group_by, avgTotal
    
