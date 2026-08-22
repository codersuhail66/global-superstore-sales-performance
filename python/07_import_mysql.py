import pandas as pd
import mysql.connector
from getpass import getpass

df = pd.read_csv("../output/superstore_mysql.csv")

df["Order Date"] = pd.to_datetime(df["Order Date"])
df["Ship Date"] = pd.to_datetime(df["Ship Date"])

password = getpass("Enter MySQL password: ")

connection = mysql.connector.connect(
    host="localhost",
    user="root",
    password=password,
    database="global_superstore"
)

cursor = connection.cursor()

cursor.execute("TRUNCATE TABLE superstore_sales")

insert_query = """
INSERT INTO superstore_sales (
    order_id,
    order_date,
    ship_date,
    ship_mode,
    customer_id,
    customer_name,
    segment,
    city,
    state,
    country,
    market,
    region,
    product_id,
    category,
    sub_category,
    product_name,
    sales,
    quantity,
    discount,
    shipping_cost,
    profit,
    order_priority,
    shipping_days,
    order_year,
    order_month,
    order_month_name,
    profit_margin
)
VALUES (
    %s, %s, %s, %s, %s, %s, %s, %s, %s,
    %s, %s, %s, %s, %s, %s, %s, %s, %s,
    %s, %s, %s, %s, %s, %s, %s, %s, %s
)
"""


data = [
    tuple(row)
    for row in df.itertuples(index=False, name=None)
]


batch_size = 1000

for i in range(0, len(data), batch_size):
    batch = data[i:i + batch_size]
    cursor.executemany(insert_query, batch)
    connection.commit()

    print(f"Inserted {min(i + batch_size, len(data))} / {len(data)} rows")

cursor.close()
connection.close()

print("\nImport completed successfully!")