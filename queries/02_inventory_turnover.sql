-- ============================================================
-- Query 2: Inventory turnover rate by sub-category
-- Concept : Distribution Planning, inventory health
-- Formula : Turnover = Total Sales / Avg Sales per month
-- ============================================================

WITH monthly_sales AS (
    SELECT
        sub_category,
        strftime('%Y-%m', order_date) AS month,
        SUM(sales)                    AS monthly_sales,
        SUM(quantity)                 AS monthly_units
    FROM orders
    GROUP BY sub_category, month
),

summary AS (
    SELECT
        sub_category,
        COUNT(DISTINCT month)          AS active_months,
        ROUND(SUM(monthly_sales), 2)   AS total_sales,
        ROUND(AVG(monthly_sales), 2)   AS avg_monthly_sales,
        ROUND(SUM(monthly_units), 0)   AS total_units_sold
    FROM monthly_sales
    GROUP BY sub_category
)

SELECT
    sub_category,
    total_units_sold,
    total_sales,
    avg_monthly_sales,
    active_months,

    -- Higher = faster moving inventory (better)
    ROUND(total_sales / NULLIF(avg_monthly_sales, 0), 2) AS turnover_ratio,

    -- Classify inventory health
    CASE
        WHEN total_sales / NULLIF(avg_monthly_sales, 0) >= 8 THEN 'Fast moving'
        WHEN total_sales / NULLIF(avg_monthly_sales, 0) >= 4 THEN 'Medium moving'
        ELSE                                                       'Slow moving'
    END AS inventory_health

FROM summary
ORDER BY turnover_ratio DESC;
