import pandas as pd

df = pd.read_csv("../data/superstore.csv")

duplicate_row_ids = df[df["ROW ID"].duplicated(keep=False)]

print("Duplicated ROW IDs:")
print(duplicate_row_ids)

print("\nNumber of duplicated ROW IDs:",
      duplicate_row_ids["ROW ID"].nunique())