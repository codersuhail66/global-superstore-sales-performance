USE global_superstore;

-- ============================================================
-- GLOBAL SUPERSTORE — SALES PERFORMANCE ANALYSIS
-- ============================================================


-- 1. OVERALL KPIs
SELECT
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    SUM(quantity) AS total_quantity,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin
FROM superstore_sales;


-- 2. YEARLY SALES & PROFIT
SELECT
    YEAR(order_date) AS order_year,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin
FROM superstore_sales
GROUP BY YEAR(order_date)
ORDER BY order_year;


-- 3. MONTHLY SALES TREND
SELECT
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    MONTHNAME(order_date) AS month_name,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM superstore_sales
GROUP BY
    YEAR(order_date),
    MONTH(order_date),
    MONTHNAME(order_date)
ORDER BY
    order_year,
    order_month;


-- 4. REGION PERFORMANCE
SELECT
    region,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin
FROM superstore_sales
GROUP BY region
ORDER BY total_sales DESC;


-- 5. COUNTRY PERFORMANCE
SELECT
    country,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin
FROM superstore_sales
GROUP BY country
ORDER BY total_sales DESC;


-- 6. CATEGORY PERFORMANCE
SELECT
    category,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    SUM(quantity) AS total_quantity,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin
FROM superstore_sales
GROUP BY category
ORDER BY total_sales DESC;


-- 7. SUB-CATEGORY PERFORMANCE
SELECT
    sub_category,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    SUM(quantity) AS total_quantity,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin
FROM superstore_sales
GROUP BY sub_category
ORDER BY total_sales DESC;


-- 8. LOSS-MAKING SUB-CATEGORIES
SELECT
    sub_category,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin
FROM superstore_sales
GROUP BY sub_category
HAVING SUM(profit) < 0
ORDER BY total_profit ASC;


-- 9. TOP 10 PRODUCTS BY SALES
SELECT
    product_name,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    SUM(quantity) AS total_quantity
FROM superstore_sales
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 10;


-- 10. TOP 10 PRODUCTS BY PROFIT
SELECT
    product_name,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin
FROM superstore_sales
GROUP BY product_name
ORDER BY total_profit DESC
LIMIT 10;


-- 11. BOTTOM 10 PRODUCTS BY PROFIT
SELECT
    product_name,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin
FROM superstore_sales
GROUP BY product_name
ORDER BY total_profit ASC
LIMIT 10;


-- 12. CUSTOMER SEGMENT PERFORMANCE
SELECT
    segment,
    COUNT(DISTINCT customer_id) AS total_customers,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin
FROM superstore_sales
GROUP BY segment
ORDER BY total_sales DESC;


-- 13. TOP 10 CUSTOMERS
SELECT
    customer_id,
    customer_name,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM superstore_sales
GROUP BY customer_id, customer_name
ORDER BY total_sales DESC
LIMIT 10;


-- 14. DISCOUNT VS PROFIT
SELECT
    discount,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin
FROM superstore_sales
GROUP BY discount
ORDER BY discount;


-- 15. HIGH DISCOUNT + NEGATIVE PROFIT
SELECT
    product_name,
    ROUND(AVG(discount) * 100, 2) AS avg_discount_percentage,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM superstore_sales
GROUP BY product_name
HAVING AVG(discount) >= 0.30
   AND SUM(profit) < 0
ORDER BY total_profit ASC;


-- 16. SHIPPING MODE PERFORMANCE
SELECT
    ship_mode,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(shipping_cost), 2) AS total_shipping_cost,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin
FROM superstore_sales
GROUP BY ship_mode
ORDER BY total_sales DESC;


-- 17. REGION + CATEGORY PERFORMANCE
SELECT
    region,
    category,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin
FROM superstore_sales
GROUP BY region, category
ORDER BY region, total_sales DESC;


-- 18. NEGATIVE-PROFIT COUNTRIES
SELECT
    country,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS profit_margin
FROM superstore_sales
GROUP BY country
HAVING SUM(profit) < 0
ORDER BY total_profit ASC;