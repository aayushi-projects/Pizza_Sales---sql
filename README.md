# Pizza_Sales Analysis
🍕 Pizza Sales Data Analysis
This project focuses on analyzing a fictional pizza restaurant's dataset using SQL to uncover key insights such as best-selling pizza types, most preferred sizes, peak order hours, revenue trends, and category-wise contributions. These insights can help optimize menu offerings, pricing strategies, and marketing decisions.

🎯 Project Objective
To explore and analyze the Pizza Sales dataset using SQL queries and extract actionable business intelligence related to orders, customer preferences, and revenue distribution.

🧠 Queries Used
1. Data Selection & Filtering
SELECT statements used to retrieve relevant columns

WHERE clauses to filter orders by date, pizza types, or size

2. Aggregation & Grouping
COUNT() used to count total orders or order items

SUM() and ROUND() to calculate total revenue

GROUP BY to segment data by category, size, or date

AVG() to find average pizzas ordered per day

3. Sorting and Ranking
ORDER BY to sort by revenue, frequency, or date

LIMIT to get top N pizzas or highest sales days

RANK() and PARTITION BY used to identify top-selling pizzas within categories

4. Joins
JOIN, INNER JOIN used to link orders, order_detail, pizzas, and pizza_types tables

5. String and Categorical Analysis
GROUP BY with categorical fields like category and name

Category-wise breakdown of pizza sales

6. Date-Based Queries
HOUR() and DATE() functions to analyze hourly and daily sales trends

Time series analysis to observe cumulative revenue

7. Revenue & Trend Analysis
Calculated total revenue and category-wise contribution to sales

Identified top pizzas contributing to the majority of revenue

Tracked cumulative revenue growth over time
