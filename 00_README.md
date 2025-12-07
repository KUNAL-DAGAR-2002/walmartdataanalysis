# 🛒 Walmart's Retail Insight Optimization using SQL  

## 📌 Project Overview  
This project leverages **advanced SQL queries** to analyze **Walmart's historical sales data** across multiple **branches, customer types, payment methods, and product lines**. The objective is to extract actionable insights that optimize sales strategies and improve overall business performance.  

### 🚀 Key Capabilities  
✔️ **Branch Sales Growth Analysis** – Identify which branches are growing the fastest 📊  
✔️ **Profitability Insights** – Determine the most profitable product lines 💰  
✔️ **Customer Segmentation** – Understand spending patterns across different customer types 👥  
✔️ **Payment Preferences** – Analyze how customers prefer to pay (Cash, Credit Card, or E-wallet) 💳  
✔️ **Product Trend Analysis** – Spot sales anomalies and seasonal demand shifts 🛍️  

---  

## 📂 Dataset  
The dataset consists of Walmart's transaction records stored in a **MySQL database**, featuring:  
📌 "Walmartsales Dataset - walmartsales.csv"

---  

## 🎯 Objective  
Walmart aims to optimize its **sales strategies** by analyzing transaction data across **branches, customer segments, and product lines**. The project uses **SQL queries** to answer critical business questions related to:  
1️⃣ **Sales performance**  
2️⃣ **Customer spending habits**  
3️⃣ **Profitability trends**  
4️⃣ **Payment method preferences**  
5️⃣ **Anomalies in product demand**  

---  

## 🔍 Key Insights  
📌 **Branch A has the highest sales growth rate of 3.32%.**  
📌 **Branch A's most profitable product line is Home & Lifestyle with ₹20,282.22.**  
📌 **Branch B's most profitable product line is Sports & Travel with ₹18,084.56.**  
📌 **Branch C's most profitable product line is Food & Beverages with ₹21,503.34.**  
📌 **Customer ID 8 has the highest sales volume at ₹26,634.34.**  
📌 **Food & Beverages shows the highest sales anomaly at ₹56,144.84, while Health & Beauty shows a low anomaly at ₹49,193.74.**  
📌 **Yangon prefers E-wallet (126 transactions), Naypyitaw prefers Cash (124 transactions), and Mandalay prefers E-wallet (113 transactions).**  
📌 **Female customers spent more than male customers in January and February; however, male spending overtook in March.**  
📌 **Members prefer Food & Beverages, while Normal customers prefer Electronic and Fashion Accessories.**  
📌 **Saturday shows the highest sales by day.**  

---  

## 📊 SQL Queries  

### 1️⃣ Identifying the Top Branch by Sales Growth Rate  
```sql
WITH MonthlySales AS 
( 
    SELECT Branch, MONTH(Date) AS Month, ROUND(SUM(Total),2) AS TotalSales 
    FROM walmartsales      
    GROUP BY Branch, MONTH(Date) 
),
GrowthRate AS 
(
    SELECT Branch, Month, TotalSales,        
    LAG(TotalSales) OVER (PARTITION BY Branch ORDER BY Month) AS PreviousSales,  
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
```  

### 2️⃣ Finding the Most Profitable Product Line for Each Branch  
```sql
USE final_project;
SELECT * FROM walmartsales;

WITH profit_margin AS 
(
    SELECT Branch, `Product line` AS product_line, 
    ROUND(SUM(cogs - `gross income`),2) AS profit_margin
    FROM walmartsales
    GROUP BY product_line, Branch
    ORDER BY profit_margin
)
SELECT Branch, product_line, profit_margin 
FROM 
(
    SELECT Branch, product_line, profit_margin ,
    RANK() OVER(PARTITION BY Branch ORDER BY profit_margin DESC) AS RANKS
    FROM profit_margin
) rankedprofit
WHERE RANKS = 1
ORDER BY Branch;
```  

---  

## 👀 Conclusion & Recommendations  
🔹 **Enhance inventory for Home & Lifestyle in Branch A**, as it is the most profitable product line.  
🔹 **Optimize promotional campaigns for Sports & Travel in Branch B** to capitalize on its high profitability.  
🔹 **Expand payment options in Naypyitaw to encourage more card transactions**, as cash is the most preferred method.  
🔹 **Identify reasons for the high anomaly in Food & Beverages sales**, and adjust stock accordingly.  
🔹 **Introduce targeted loyalty programs** based on spending habits to encourage repeat purchases.  

---  



