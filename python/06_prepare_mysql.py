import pandas as pd

df = pd.read_csv("../output/superstore_cleaned.csv")

df["Order Date"] = pd.to_datetime(df["Order Date"], dayfirst=True)
df["Ship Date"] = pd.to_datetime(df["Ship Date"], dayfirst=True)

df["Order Date"] = df["Order Date"].dt.strftime("%Y-%m-%d")
df["Ship Date"] = df["Ship Date"].dt.strftime("%Y-%m-%d")

df.to_csv(
    "../output/superstore_mysql.csv",
    index=False
)

print("MySQL-ready CSV created successfully!")
print("Rows:", len(df))
print("Columns:", len(df.columns))