import pandas as pd

df = pd.read_csv("../data/superstore.csv")

print("Dataset shape:", df.shape)

print("\nMissing values:")
print(df.isnull().sum())

print("\nDuplicate rows:")
print(df.duplicated().sum())

print("\nUnique values:")
print(df.nunique())

print("\nNumeric summary:")
print(df[["Sales", "Quantity", "Discount", "Shipping Cost", "Profit"]].describe())