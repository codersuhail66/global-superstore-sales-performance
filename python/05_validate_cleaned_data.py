import pandas as pd

df = pd.read_csv("../output/superstore_cleaned.csv")

print("Dataset shape:", df.shape)

print("\nData types:")
print(df.dtypes)

print("\nNegative Shipping Days:")
print((df["Shipping Days"] < 0).sum())

print("\nProfit Margin:")
print(df["Profit Margin"].describe())

print("\nInfinite Profit Margins:")
print(df["Profit Margin"].isin([float("inf"), float("-inf")]).sum())

print("\nSales <= 0:")
print((df["Sales"] <= 0).sum())

print("\nQuantity <= 0:")
print((df["Quantity"] <= 0).sum())

print("\nProfit summary:")
print(df["Profit"].describe())