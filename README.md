# Supply Chain Demand Analysis

An end-to-end supply chain analytics pipeline built with **Python** and **SQL** — simulating real-world ETL, demand planning, forecasting, and data ingestion workflows used in enterprise planning platforms like o9 Solutions.

---

## Key Results

| Metric | Value |
|---|---|
| 📦 Dataset | Sample Superstore (9,994 records, 2014–2017) |
| 📉 Best Forecast Model | Moving Average |
| 🎯 Forecast MAPE | 13.1% |
| ⏱️ Avg Delivery Days | 4.0 days |
| 🗃️ SQL Queries | 6 supply chain KPI queries |
| 📊 Charts Generated | 10+ visualisations |

---

## Tech Stack

| Layer | Tools |
|---|---|
| Language | Python 3, SQL (SQLite) |
| Data Processing | pandas, NumPy |
| Forecasting | statsmodels (MA, ES models) |
| Visualisation | matplotlib, seaborn |
| Database | SQLite (via `sqlite3`) |
| Environment | Jupyter Notebook, VS Code |
| Version Control | Git, GitHub |

---

## Project Structure

```
scd-analysis/
├── data/
│   ├── Sample - Superstore.csv      ← raw data (9,994 records)
│   ├── superstore_cleaned.csv       ← ETL output
│   └── superstore.db                ← SQLite database (generated)
│
├── notebooks/
│   ├── 01_ETL_Pipeline.ipynb        ← Extract, Transform, Load
│   ├── 02_Demand_Analysis.ipynb     ← 7 demand charts
│   ├── 03_Forecasting_Models.ipynb  ← MA & ES forecasting models
│   ├── 04_SOP_Dashboard.ipynb       ← Executive S&OP dashboard
│   └── 05_SQL_Analysis.ipynb        ← SQL analytics layer ✨ new
│
├── queries/                         ← ✨ new
│   ├── 01_demand_trend.sql          ← rolling avg, window function
│   ├── 02_inventory_turnover.sql    ← CTE-based turnover ratio
│   ├── 03_lead_time_analysis.sql    ← shipping lead time by region
│   ├── 04_stockout_risk.sql         ← rule-based risk flagging
│   ├── 05_profitability_analysis.sql← RANK() margin analysis
│   └── 06_data_quality_checks.sql   ← null, dupe, anomaly checks
│
├── src/
│   ├── etl_pipeline.py              ← reusable ETL script
│   └── db_loader.py                 ← CSV → SQLite ingestion ✨ new
│
├── outputs/                         ← saved charts
└── README.md
```

---

## Pipeline Overview

```
Raw CSV (9,994 rows)
      │
      ▼
ETL Pipeline (src/etl_pipeline.py)
  • Clean column names
  • Parse dates
  • Remove duplicates & nulls
  • Validate data types
      │
      ├──▶ superstore_cleaned.csv   (Python analysis)
      │
      └──▶ SQLite Database (src/db_loader.py)
                │
                ▼
          6 SQL Queries (queries/)
                │
                ▼
          05_SQL_Analysis.ipynb
          (results + charts)
```

---

## Notebooks

### 01 — ETL Pipeline
Ingests raw Superstore CSV, standardises column names, parses dates, removes duplicates, validates data types, and outputs a clean CSV for downstream analysis.

### 02 — Demand Analysis
Seven demand charts exploring sales trends, category breakdowns, regional distribution, and seasonal patterns. Identifies peak demand periods and slow-moving segments.

### 03 — Forecasting Models
Implements Moving Average and Exponential Smoothing models using `statsmodels`. Evaluates forecast accuracy via MAPE — Moving Average achieved **13.1% MAPE**, selected as the best model.

### 04 — S&OP Dashboard
Executive-level Sales & Operations Planning dashboard summarising key KPIs: total revenue, profit margin, demand by segment, and regional performance. Simulates what a planner would review in a weekly S&OP meeting.

### 05 — SQL Analytics Layer ✨
Adds a SQL layer on top of the ETL pipeline. Loads cleaned data into SQLite, then runs 6 supply chain KPI queries using CTEs, window functions, and JOINs. Results are pulled back into Python via `pandas.read_sql()` and visualised.

---

## SQL Queries

All queries are in the `queries/` folder and run against `data/superstore.db`.

| # | File | Concept | SQL Features |
|---|---|---|---|
| 1 | `01_demand_trend.sql` | Demand Management | `AVG() OVER`, window fn, rolling avg |
| 2 | `02_inventory_turnover.sql` | Distribution Planning | CTE, `NULLIF`, `CASE WHEN` |
| 3 | `03_lead_time_analysis.sql` | Supplier lead time | `julianday()`, aggregation |
| 4 | `04_stockout_risk.sql` | Risk flagging | CTE, `JOIN`, rule-based classification |
| 5 | `05_profitability_analysis.sql` | S&OP margin analysis | `RANK() OVER PARTITION BY` |
| 6 | `06_data_quality_checks.sql` | Integration & ingestion | `UNION ALL`, null/dupe/anomaly checks |

---

## Supply Chain Concepts Covered

| Concept | Implementation |
|---|---|
| ETL Pipeline | `src/etl_pipeline.py` — extract, clean, load |
| Demand Management | Trend analysis, rolling average, demand variance |
| S&OP | Executive dashboard, category & regional breakdown |
| Time Series Forecasting | Moving Average, Exponential Smoothing (MAPE: 13.1%) |
| Inventory Planning | Turnover ratio, fast/medium/slow classification |
| Lead Time Analysis | Ship mode vs region, on-time % calculation |
| Stockout Risk | Rule-based flagging vs historical average demand |
| Data Quality | Null checks, duplicate detection, date logic validation |
| Data Ingestion | CSV → SQLite via Python (`sqlite3` + `pandas`) |

---

## How to Run

**1. Clone the repo**
```bash
git clone https://github.com/devayan279/scd-analysis.git
cd scd-analysis
```

**2. Install dependencies**
```bash
pip install pandas numpy matplotlib seaborn statsmodels jupyter
```

**3. Run ETL pipeline**
```bash
python src/etl_pipeline.py
```

**4. Load data into SQLite**
```bash
python src/db_loader.py
```

**5. Open notebooks**
```bash
jupyter notebook
```
Run notebooks in order: `01` → `02` → `03` → `04` → `05`

---

## About

Built as a personal project to demonstrate supply chain analytics skills — covering the full data lifecycle from raw ingestion to SQL-based KPI analysis — aligned with enterprise planning workflows used in platforms like o9 Solutions.

**Author:** Devayan Das  
**LinkedIn:** [linkedin.com/in/devmoon](https://linkedin.com/in/devmoon)  
**GitHub:** [github.com/devayan279](https://github.com/devayan279)
