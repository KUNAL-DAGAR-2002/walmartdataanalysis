USE final_project;
SELECT * FROM walmartsales;
WITH profit_margin AS (
SELECT Branch, `Product line` AS product_line, ROUND(SUM(cogs - `gross income`),2) AS profit_margin
FROM walmartsales
GROUP BY product_line, Branch
ORDER BY profit_margin)
SELECT Branch, product_line, profit_margin FROM (
SELECT Branch, product_line, profit_margin ,
RANK() OVER(PARTITION BY Branch ORDER BY profit_margin DESC) AS RANKS
FROM profit_margin) rankedprofit
WHERE RANKS = 1
ORDER BY Branch;
