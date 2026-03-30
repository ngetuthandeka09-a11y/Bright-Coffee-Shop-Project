SELECT transaction_id,
      transaction_date,
      transaction_time,
      transaction_qty,
      store_id,
      store_location,
      product_id,
      unit_price,
      product_category,
      product_type,
      product_detail,

-- Adding Regions
CASE 
      WHEN store_location IN ('Lower Manhattan') THEN 'Gauteng'
      WHEN store_location IN ('Hell''s Kitchen') THEN 'Western Cape'
      WHEN store_location IN ('Astoria') THEN 'Kwa-Zulu Natal'
END AS store_location_Region,

--Unpacking the time

CASE 
      WHEN date_format(transaction_time,'HH:mm:ss') BETWEEN '05:00:00' AND '08:59:59' THEN '01. Morning'
      WHEN date_format(transaction_time,'HH:mm:ss') BETWEEN '09:00:00' AND '11:59:59' THEN '02. Late Morning'
      WHEN date_format(transaction_time,'HH:mm:ss') BETWEEN '12:00:00' AND '15:59:59' THEN '03. Afternoon'
      WHEN date_format(transaction_time,'HH:mm:ss') BETWEEN '16:00:00' AND '18:59:59' THEN '04. Evening'
      ELSE '05. Late Evening'
END AS Time_Classification,

--geting revenue and type of purchase
(unit_price*transaction_qty) AS Total_Revenue,

CASE 
    WHEN (unit_price*transaction_qty) <=50 THEN '01. Mostly Purchased'
    WHEN (unit_price*transaction_qty) BETWEEN 51 AND 200 THEN '02. Mid Purchased'
    WHEN (unit_price*transaction_qty) BETWEEN 201 AND 300 THEN '03. Least Purchased'
    ELSE '04. Lowwest Purchased'
END AS Spend_Categorization,

-- getting the days of the week and month
Dayname(transaction_date) AS Day_Name,
Monthname(transaction_date) AS Month_Name,
Dayofmonth(transaction_date) AS Month_Day,

CASE 
      WHEN Dayname(transaction_date) IN ('Sun', 'Sat') THEN 'Weekend'
      ELSE 'Weekday'
END AS Day_Calssification
FROM workspace.default.bright_coffee_shop;

----------------------------

