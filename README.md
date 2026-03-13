# 📦 Supply Chain Demand Analysis (scd-analysis)

An end-to-end supply chain analytics project built with Python and SQL, simulating real-world **Demand Management**, **S&OP**, and **ETL workflows** as used in enterprise planning platforms like o9, SAP IBP, and Kinaxis.

> **Project Duration:** March 2025 – Present  
> **Author:** [Devayan Das](https://github.com/devayan279) | [LinkedIn](https://linkedin.com/in/devmoon)

---

## 🎯 Objective

To replicate the core data workflows behind integrated supply chain planning — from raw data ingestion to demand forecasting and executive reporting — using open-source tools and the [Sample Superstore dataset](data/Sample%20-%20Superstore.csv).

---

## 🗂️ Project Structure

```
scd-analysis/
│
├── data/
│   ├── Sample - Superstore.csv       # Raw sales dataset
│   ├── superstore_cleaned.csv        # Cleaned & transformed data
│   ├── superstore.db                 # SQLite database (post-ingestion)
│   └── placeholder.txt
│
├── notebooks/
│   ├── 01_ETL_Pipeline.ipynb         # Data ingestion, cleaning & transformation
│   ├── 02_Demand_Analysis.ipynb      # Demand trend & category analysis
│   ├── 03_Forecasting_Models.ipynb   # Time-series forecasting (MA, Exp. Smoothing)
│   ├── 04_SOP_Dashboard.ipynb        # S&OP executive dashboard
│   └── 05_SQL_Analysis.ipynb         # SQL-based demand & profitability queries
│
├── outputs/
│   ├── SOP_Executive_Dashboard.png
│   ├── category_sales.png
│   ├── monthly_sales_trend.png
│   ├── yearly_growth.png
│   ├── top10_products.png
│   ├── region_sales.png
│   ├── moving_average.png
│   ├── rolling_averages.png
│   ├── exp_smoothing.png
│   ├── model_comparison.png
│   ├── seasonality_pattern.png
│   ├── sql_category_sales.png
│   ├── sql_demand_trend.png
│   ├── sql_lead_time.png
│   ├── sql_profit_margin.png
│   └── sql_turnover.png
│
├── src/                              # Reusable utility scripts
├── LICENSE
└── README.md
```

---

## 🔄 Workflow Overview

```
Raw CSV Data
    ↓
[01] ETL Pipeline        → Data ingestion, cleaning, type casting, SQLite load
    ↓
[02] Demand Analysis     → Trend visualization, category/region breakdown
    ↓
[03] Forecasting Models  → Moving Average, Exponential Smoothing, model comparison
    ↓
[04] S&OP Dashboard      → Executive KPI summary, aggregated planning view
    ↓
[05] SQL Analysis        → Demand trends, profit margins, turnover via SQL queries
```

---

## 🧰 Tech Stack

| Layer | Tools |
|---|---|
| Language | Python 3.x |
| Data Manipulation | pandas, NumPy |
| Visualization | matplotlib, seaborn |
| Database | SQLite3 |
| Notebooks | Jupyter |
| Version Control | Git + GitHub |

---

## 📊 Key Analyses

### 1. ETL Pipeline (`01_ETL_Pipeline.ipynb`)
- Ingests raw Superstore CSV data
- Performs data type normalization, null handling, and column standardization
- Loads cleaned data into a SQLite database (`superstore.db`) and exports `superstore_cleaned.csv`

### 2. Demand Analysis (`02_Demand_Analysis.ipynb`)
- Monthly and yearly sales trend analysis
- Category-wise and region-wise demand breakdown
- Top 10 products by revenue
- Seasonality pattern identification

### 3. Forecasting Models (`03_Forecasting_Models.ipynb`)
- **Moving Average** (rolling window smoothing)
- **Exponential Smoothing** (weighted trend forecasting)
- Model comparison chart to evaluate forecast accuracy

### 4. S&OP Dashboard (`04_SOP_Dashboard.ipynb`)
- Consolidated executive-level dashboard
- Aggregated KPIs for Sales & Operations Planning review cycles

### 5. SQL Analysis (`05_SQL_Analysis.ipynb`)
- Demand trend queries over time
- Category-level sales and profitability
- Profit margin and inventory turnover analysis
- Lead time estimation from order data

---

## 📈 Sample Outputs

### 🗺️ S&OP Executive Dashboard
![SOP Executive Dashboard](https://raw.githubusercontent.com/devayan279/scd-analysis/main/outputs/SOP_Executive_Dashboard.png)

### 📅 Monthly Sales Trend
![Monthly Sales Trend](https://raw.githubusercontent.com/devayan279/scd-analysis/main/outputs/monthly_sales_trend.png)

### 📦 Category Sales Breakdown
![Category Sales](https://raw.githubusercontent.com/devayan279/scd-analysis/main/outputs/category_sales.png)

### 🌍 Region Sales
![Region Sales](https://raw.githubusercontent.com/devayan279/scd-analysis/main/outputs/region_sales.png)

### 🏆 Top 10 Products
![Top 10 Products](https://raw.githubusercontent.com/devayan279/scd-analysis/main/outputs/top10_products.png)

### 📈 Yearly Growth
![Yearly Growth](https://raw.githubusercontent.com/devayan279/scd-analysis/main/outputs/yearly_growth.png)

### 🔮 Forecasting — Moving Average vs Exponential Smoothing
| Moving Average | Exponential Smoothing |
|---|---|
| ![Moving Average](https://raw.githubusercontent.com/devayan279/scd-analysis/main/outputs/moving_average.png) | ![Exp Smoothing](https://raw.githubusercontent.com/devayan279/scd-analysis/main/outputs/exp_smoothing.png) |

### 📊 Model Comparison
![Model Comparison](https://raw.githubusercontent.com/devayan279/scd-analysis/main/outputs/model_comparison.png)

### 🗄️ SQL Analysis Outputs
| Demand Trend | Profit Margin | Category Sales |
|---|---|---|
| ![SQL Demand](https://raw.githubusercontent.com/devayan279/scd-analysis/main/outputs/sql_demand_trend.png) | ![SQL Profit](https://raw.githubusercontent.com/devayan279/scd-analysis/main/outputs/sql_profit_margin.png) | ![SQL Category](https://raw.githubusercontent.com/devayan279/scd-analysis/main/outputs/sql_category_sales.png) |

---

## 🚀 Getting Started

### Prerequisites
```bash
pip install pandas numpy matplotlib seaborn jupyter
```

### Run the notebooks in order
```bash
jupyter notebook notebooks/01_ETL_Pipeline.ipynb
```
Then proceed through notebooks `02` → `03` → `04` → `05` sequentially.

---

## 🔗 Supply Chain Concepts Demonstrated

- **ETL (Extract, Transform, Load)** — data pipeline simulation
- **Demand Management** — historical demand trend analysis and forecasting
- **S&OP (Sales & Operations Planning)** — aggregated planning dashboard
- **Distribution Planning** — regional demand breakdown
- **Data Integrity** — cleaning, validation, and statistical checks

---

## 🙋 About the Author

**Devayan Das** — Final-year B.Tech (Civil Engineering) student at NIT Agartala with a strong interest in data analytics and supply chain planning.

📧 devayan279@gmail.com | 🔗 [LinkedIn](https://linkedin.com/in/devmoon) | 💻 [GitHub](https://github.com/devayan279)
