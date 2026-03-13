-- ============================================================
-- Query 6: Data quality validation checks
-- Concept : Integration & ingestion data integrity
-- o9 link : o9 consultants run DQ checks on every customer
--           data load before planning runs begin
-- ============================================================

-- 1. Null check across critical columns
SELECT 'null_check'            AS check_type,
       'order_id'              AS column_name,
       COUNT(*)                AS total_rows,
       SUM(CASE WHEN order_id     IS NULL THEN 1 ELSE 0 END) AS null_count,
       SUM(CASE WHEN order_date   IS NULL THEN 1 ELSE 0 END) AS null_order_date,
       SUM(CASE WHEN sales        IS NULL THEN 1 ELSE 0 END) AS null_sales,
       SUM(CASE WHEN quantity     IS NULL THEN 1 ELSE 0 END) AS null_quantity,
       SUM(CASE WHEN product_name IS NULL THEN 1 ELSE 0 END) AS null_product
FROM orders

UNION ALL

-- 2. Negative values check (data anomalies)
SELECT 'anomaly_check'                                        AS check_type,
       'negative_values'                                      AS column_name,
       COUNT(*)                                               AS total_rows,
       SUM(CASE WHEN sales    < 0 THEN 1 ELSE 0 END)         AS neg_sales,
       SUM(CASE WHEN quantity < 0 THEN 1 ELSE 0 END)         AS neg_quantity,
       SUM(CASE WHEN discount < 0 OR discount > 1 THEN 1 ELSE 0 END) AS invalid_discount,
       0                                                      AS unused1,
       0                                                      AS unused2
FROM orders

UNION ALL

-- 3. Duplicate order line check
SELECT 'duplicate_check'       AS check_type,
       'order_id'              AS column_name,
       COUNT(*)                AS total_rows,
       COUNT(*) - COUNT(DISTINCT order_id || product_id) AS duplicate_lines,
       0, 0, 0, 0
FROM orders

UNION ALL

-- 4. Date logic check (ship before order — impossible)
SELECT 'date_logic_check'      AS check_type,
       'ship_before_order'     AS column_name,
       COUNT(*)                AS total_rows,
       SUM(CASE WHEN ship_date < order_date THEN 1 ELSE 0 END) AS bad_dates,
       0, 0, 0, 0
FROM orders;
