"""
db_loader.py
------------
Loads superstore_cleaned.csv into a SQLite database.
Creates two tables:
  - orders       : all transactional records
  - products     : unique product catalogue

Usage:
    python src/db_loader.py

Output:
    data/superstore.db
"""

import sqlite3
import pandas as pd
import os

# ── Paths ──────────────────────────────────────────────────────────────────────
BASE_DIR   = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
CSV_PATH   = os.path.join(BASE_DIR, "data", "superstore_cleaned.csv")
DB_PATH    = os.path.join(BASE_DIR, "data", "superstore.db")


def load_csv(path: str) -> pd.DataFrame:
    """Read CSV and standardise column names."""
    df = pd.read_csv(path, encoding="latin-1")
    df.columns = (
        df.columns
        .str.strip()
        .str.lower()
        .str.replace(" ", "_")
        .str.replace("-", "_")
    )
    print(f"[✓] Loaded CSV  → {len(df):,} rows, {len(df.columns)} columns")
    return df


def validate(df: pd.DataFrame) -> pd.DataFrame:
    """Basic data quality checks before ingestion."""
    before = len(df)

    # 1. Drop fully duplicate rows
    df = df.drop_duplicates()

    # 2. Drop rows missing critical fields
    critical = ["order_id", "order_date", "sales", "quantity", "product_name"]
    existing_critical = [c for c in critical if c in df.columns]
    df = df.dropna(subset=existing_critical)

    # 3. Ensure numeric columns are correct types
    for col in ["sales", "quantity", "discount", "profit"]:
        if col in df.columns:
            df[col] = pd.to_numeric(df[col], errors="coerce").fillna(0)

    # 4. Parse dates
    for col in ["order_date", "ship_date"]:
        if col in df.columns:
            df[col] = pd.to_datetime(df[col], errors="coerce").dt.strftime("%Y-%m-%d")

    after = len(df)
    print(f"[✓] Validated   → dropped {before - after} bad rows, {after:,} clean rows remain")
    return df


def create_tables(conn: sqlite3.Connection, df: pd.DataFrame):
    """Create orders and products tables in SQLite."""
    cursor = conn.cursor()

    # Drop if exists (clean reload)
    cursor.executescript("""
        DROP TABLE IF EXISTS orders;
        DROP TABLE IF EXISTS products;
    """)

    # ── orders table ──────────────────────────────────────────────────────────
    cursor.execute("""
        CREATE TABLE orders (
            row_id        INTEGER PRIMARY KEY,
            order_id      TEXT    NOT NULL,
            order_date    TEXT,
            ship_date     TEXT,
            ship_mode     TEXT,
            customer_id   TEXT,
            customer_name TEXT,
            segment       TEXT,
            country       TEXT,
            city          TEXT,
            state         TEXT,
            region        TEXT,
            product_id    TEXT,
            category      TEXT,
            sub_category  TEXT,
            product_name  TEXT,
            sales         REAL,
            quantity      INTEGER,
            discount      REAL,
            profit        REAL
        )
    """)

    # ── products table ────────────────────────────────────────────────────────
    cursor.execute("""
        CREATE TABLE products (
            product_id   TEXT PRIMARY KEY,
            product_name TEXT,
            category     TEXT,
            sub_category TEXT
        )
    """)

    conn.commit()
    print("[✓] Tables created → orders, products")


def insert_data(conn: sqlite3.Connection, df: pd.DataFrame):
    """Insert cleaned data into both tables."""

    # Map dataframe columns to orders table columns
    order_cols = [
        "row_id", "order_id", "order_date", "ship_date", "ship_mode",
        "customer_id", "customer_name", "segment", "country", "city",
        "state", "region", "product_id", "category", "sub_category",
        "product_name", "sales", "quantity", "discount", "profit"
    ]
    existing_order_cols = [c for c in order_cols if c in df.columns]
    df[existing_order_cols].to_sql("orders", conn, if_exists="append", index=False)

    # Products: unique product catalogue
    product_cols = ["product_id", "product_name", "category", "sub_category"]
    existing_product_cols = [c for c in product_cols if c in df.columns]
    if existing_product_cols:
        products_df = df[existing_product_cols].drop_duplicates(subset=["product_id"] if "product_id" in existing_product_cols else existing_product_cols[:1])
        products_df.to_sql("products", conn, if_exists="append", index=False)
        print(f"[✓] Inserted    → {len(df):,} orders | {len(products_df):,} unique products")
    else:
        print(f"[✓] Inserted    → {len(df):,} orders")


def verify(conn: sqlite3.Connection):
    """Print row counts and a sample query to confirm load."""
    cursor = conn.cursor()

    counts = cursor.execute("""
        SELECT 'orders'   AS tbl, COUNT(*) AS rows FROM orders
        UNION ALL
        SELECT 'products' AS tbl, COUNT(*) AS rows FROM products
    """).fetchall()

    print("\n── Table row counts ─────────────────────")
    for tbl, rows in counts:
        print(f"   {tbl:<12} {rows:>6,} rows")

    sample = cursor.execute("""
        SELECT category, SUM(sales) AS total_sales
        FROM orders
        GROUP BY category
        ORDER BY total_sales DESC
    """).fetchall()

    print("\n── Quick sanity check: sales by category ─")
    for cat, sales in sample:
        print(f"   {cat:<20} ${sales:>10,.2f}")

    print("\n[✓] Database ready →", DB_PATH)


def main():
    print("=" * 50)
    print("  Superstore → SQLite Ingestion Pipeline")
    print("=" * 50)

    df   = load_csv(CSV_PATH)
    df   = validate(df)
    conn = sqlite3.connect(DB_PATH)

    create_tables(conn, df)
    insert_data(conn, df)
    verify(conn)

    conn.close()


if __name__ == "__main__":
    main()
