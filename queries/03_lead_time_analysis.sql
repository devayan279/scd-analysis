-- ============================================================
-- Query 3: Shipping lead time analysis by ship mode & region
-- Concept : Supplier lead time, distribution planning
-- ============================================================

WITH lead_times AS (
    SELECT
        order_id,
        ship_mode,
        region,
        order_date,
        ship_date,
        -- Calculate lead time in days
        CAST(
            julianday(ship_date) - julianday(order_date)
            AS INTEGER
        ) AS lead_time_days
    FROM orders
    WHERE ship_date IS NOT NULL
      AND order_date IS NOT NULL
      AND ship_date >= order_date
)

SELECT
    ship_mode,
    region,
    COUNT(*)                            AS total_orders,
    ROUND(AVG(lead_time_days), 1)       AS avg_lead_days,
    MIN(lead_time_days)                 AS min_lead_days,
    MAX(lead_time_days)                 AS max_lead_days,

    -- % of orders shipped within 3 days (on-time target)
    ROUND(
        100.0 * SUM(CASE WHEN lead_time_days <= 3 THEN 1 ELSE 0 END)
        / COUNT(*), 1
    )                                   AS pct_on_time,

    -- Flag regions with poor lead time performance
    CASE
        WHEN AVG(lead_time_days) > 5 THEN 'At risk'
        WHEN AVG(lead_time_days) > 3 THEN 'Monitor'
        ELSE                               'On track'
    END AS lead_time_status

FROM lead_times
GROUP BY ship_mode, region
ORDER BY avg_lead_days DESC;
