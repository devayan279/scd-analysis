"""
ETL Pipeline Script
Supply Chain Demand Analysis Project
Author: Devayan Das | NIT Agartala
"""

import pandas as pd
import numpy as np

def load_raw_data(filepath):
    """Extract: Load raw CSV data"""
    df = pd.read_csv(filepath, encoding='latin-1')
    print(f"Loaded {len(df)} records")
    return df

def transform_data(df):
    """Transform: Clean and enrich data"""
    df['Order Date'] = pd.to_datetime(df['Order Date'])
    df['Ship Date'] = pd.to_datetime(df['Ship Date'])
    df['Year'] = df['Order Date'].dt.year
    df['Month'] = df['Order Date'].dt.month
    df['Month_Name'] = df['Order Date'].dt.strftime('%b')
    df['Delivery_Days'] = (df['Ship Date'] - df['Order Date']).dt.days
    print(f"Transformed data shape: {df.shape}")
    return df

def load_clean_data(df, output_path):
    """Load: Save cleaned data"""
    df.to_csv(output_path, index=False)
    print(f"Saved to {output_path}")

if __name__ == "__main__":
    df = load_raw_data('../data/Sample - Superstore.csv')
    df = transform_data(df)
    load_clean_data(df, '../data/superstore_cleaned.csv')
    print("ETL Pipeline complete!")
