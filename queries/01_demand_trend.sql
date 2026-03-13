-- ============================================================
-- Query 1: Monthly demand trend with 3-month rolling average
-- Concept : Demand Management, S&OP
-- o9 link : Simulates how o9 tracks demand signals over time
-- ============================================================

SELECT
    strftime('%Y-%m', order_date)              AS month,
    category,
    ROUND(SUM(quantity), 0)                    AS monthly_units,

    -- 3-month rolling average using window function
    ROUND(
        AVG(SUM(quantity)) OVER (
            PARTITION BY category
            ORDER BY strftime('%Y-%m', order_date)
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ), 1
    )                                          AS rolling_3m_avg

FROM orders
WHERE order_date IS NOT NULL
GROUP BY month, category
ORDER BY category, month;
