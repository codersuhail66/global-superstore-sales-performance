import pandas as pd

df = pd.read_csv("../data/superstore.csv")

print("Rows and columns:", df.shape)
print("\nFirst 5 rows:")
print(df.head())

print("\nColumn names:")
print(df.columns.tolist())

print("\nData types:")
print(df.dtypes)