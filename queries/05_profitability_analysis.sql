-- ============================================================
-- Query 5: Profitability vs discount impact by category
-- Concept : S&OP, margin analysis
-- ============================================================

WITH discounted AS (
    SELECT
        category,
        sub_category,
        CASE WHEN discount > 0 THEN 'Discounted' ELSE 'Full price' END AS price_type,
        sales,
        profit,
        quantity,
        discount
    FROM orders
)

SELECT
    category,
    sub_category,
    price_type,
    COUNT(*)                                AS order_count,
    ROUND(SUM(sales), 2)                    AS total_sales,
    ROUND(SUM(profit), 2)                   AS total_profit,
    ROUND(100.0 * SUM(profit) / NULLIF(SUM(sales), 0), 1) AS profit_margin_pct,
    ROUND(AVG(discount) * 100, 1)           AS avg_discount_pct,

    -- Rank sub-categories by profit within each category
    RANK() OVER (
        PARTITION BY category
        ORDER BY SUM(profit) DESC
    )                                       AS profit_rank_in_category

FROM discounted
GROUP BY category, sub_category, price_type
ORDER BY category, profit_rank_in_category, price_type;
