SELECT * FROM walmartsales;
WITH PaymentCounts AS (
    SELECT City, Payment, COUNT(*) AS Total
    FROM walmartsales
    GROUP BY City, Payment
),
RankedPayments AS (
    SELECT City, Payment, Total,
	RANK() OVER (PARTITION BY City ORDER BY Total DESC) AS Ranks
    FROM PaymentCounts
)
SELECT City, Payment, Total
FROM RankedPayments
WHERE Ranks = 1
ORDER BY City;
