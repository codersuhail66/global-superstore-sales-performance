import pandas as pd

df = pd.read_csv("../data/superstore.csv")

print("Original shape:", df.shape)

df = df.drop(columns=["ROW ID", "Postal Code"])

df["Order Date"] = pd.to_datetime(
    df["Order Date"],
    dayfirst=True
)

df["Ship Date"] = pd.to_datetime(
    df["Ship Date"],
    dayfirst=True
)

text_columns = df.select_dtypes(include="object").columns

for column in text_columns:
    df[column] = df[column].str.strip()

df["Shipping Days"] = (
    df["Ship Date"] - df["Order Date"]
).dt.days

df["Order Year"] = df["Order Date"].dt.year

df["Order Month"] = df["Order Date"].dt.month

df["Order Month Name"] = df["Order Date"].dt.strftime("%B")

df["Profit Margin"] = (
    df["Profit"] / df["Sales"]
) * 100


df.to_csv(
    "../output/superstore_cleaned.csv",
    index=False
)

print("Cleaned shape:", df.shape)
print("\nColumns:")
print(df.columns.tolist())

print("\nMissing values:")
print(df.isnull().sum())

print("\nCleaning completed successfully!")