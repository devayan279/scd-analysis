-- ============================================================
-- Query 4: Stockout risk detection by sub-category
-- Concept : Demand Management, risk flagging
-- ============================================================

WITH monthly_demand AS (
    SELECT
        sub_category,
        strftime('%Y-%m', order_date) AS month,
        SUM(quantity)                 AS units_sold,
        SUM(sales)                    AS revenue
    FROM orders
    GROUP BY sub_category, month
),

demand_stats AS (
    SELECT
        sub_category,
        ROUND(AVG(units_sold), 1)    AS avg_monthly_demand,
        ROUND(MAX(units_sold), 0)    AS peak_demand,

        -- Demand variability: standard deviation proxy
        ROUND(
            AVG((units_sold - (SELECT AVG(units_sold) FROM monthly_demand m2
                               WHERE m2.sub_category = m1.sub_category)) *
                (units_sold - (SELECT AVG(units_sold) FROM monthly_demand m2
                               WHERE m2.sub_category = m1.sub_category))
            ), 1
        )                            AS demand_variance,

        COUNT(DISTINCT month)        AS months_with_sales
    FROM monthly_demand m1
    GROUP BY sub_category
),

-- Latest month demand for trend comparison
latest AS (
    SELECT
        sub_category,
        units_sold AS latest_month_units
    FROM monthly_demand
    WHERE month = (SELECT MAX(month) FROM monthly_demand)
)

SELECT
    d.sub_category,
    d.avg_monthly_demand,
    d.peak_demand,
    l.latest_month_units,

    -- Demand drop % vs average
    ROUND(
        100.0 * (l.latest_month_units - d.avg_monthly_demand)
        / NULLIF(d.avg_monthly_demand, 0), 1
    )                                AS demand_vs_avg_pct,

    -- Stockout risk score (simple rule-based)
    CASE
        WHEN l.latest_month_units < d.avg_monthly_demand * 0.5
            THEN 'HIGH - replenish now'
        WHEN l.latest_month_units < d.avg_monthly_demand * 0.8
            THEN 'MEDIUM - monitor closely'
        ELSE
            'LOW - healthy stock signal'
    END AS stockout_risk

FROM demand_stats d
JOIN latest l ON d.sub_category = l.sub_category
ORDER BY demand_vs_avg_pct ASC;
