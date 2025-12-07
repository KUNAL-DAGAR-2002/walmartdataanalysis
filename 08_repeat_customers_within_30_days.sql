SELECT * FROM walmartsales;
USE final_project;
WITH customer_purchases AS (
    SELECT `Customer ID`,`Date`,
	ROW_NUMBER() OVER (PARTITION BY `Customer ID` ORDER BY `Date`) AS purchase_sequence
    FROM walmartsales
),
purchase_intervals AS (
    SELECT c1.`Customer ID`,c1.`Date` AS purchase_date,c2.`Date` AS next_purchase_date,
	DATEDIFF(c2.`Date`, c1.`Date`) AS days_between_purchases
    FROM customer_purchases c1
    INNER JOIN customer_purchases c2 ON c1.`Customer ID` = c2.`Customer ID` AND c1.purchase_sequence + 1 = c2.purchase_sequence
),
all_cust_data AS 
(SELECT `Customer ID`, purchase_date, next_purchase_date, days_between_purchases
FROM purchase_intervals
WHERE days_between_purchases <= 30
ORDER BY days_between_purchases DESC)

SELECT  `Customer ID`, COUNT(*) AS TotalPurchases FROM purchase_intervals
WHERE days_between_purchases > 0
GROUP BY `Customer ID`
ORDER BY COUNT(*) DESC;
