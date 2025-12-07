SELECT * FROM walmartsales;
WITH cust_and_productline_counts AS (
    SELECT `Customer type` AS cust_type, `Product line` AS productline, COUNT(*) AS Total
    FROM walmartsales
    GROUP BY `Customer type`, `Product line`
),
ranked_product_lines AS (
    SELECT cust_type, productline, Total,
	RANK() OVER (PARTITION BY cust_type ORDER BY Total DESC) AS Ranks
    FROM cust_and_productline_counts
)
SELECT cust_type, productline, Total
FROM ranked_product_lines
WHERE Ranks = 1
ORDER BY cust_type;
