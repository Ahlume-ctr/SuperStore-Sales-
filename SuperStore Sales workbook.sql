-- Databricks notebook source

SELECT TRY_CAST(GET(SPLIT(transaction_id, "T"), 1) AS INT) AS Transaction_Id,
          transaction_date AS Transaction_Date,
             TRY_CAST(GET(SPLIT(customer_id, "C"), 1) AS INT) AS Customer_Id,
                customer_gender AS Customer_Gender,
                   customer_age_group AS Customer_Age_Group,
                      customer_segment AS Customer_Segment,
                         TRY_CAST(GET(SPLIT(product_id, "P"), 1)AS INT) AS Product_Id,
                         product_name AS Product_Name,
                      category AS Category,
                   brand AS Brand,
                quantity AS Quantity,
             unit_price AS Unit_Price,
          discount_pct AS Discount_Percnt,
        sales_amount AS Sales_Amount,
          payment_method AS Payment_Method,
             sales_channel AS Sales_Channel,
                region AS Region
FROM workspace.default.super_store_sales_dataset_1;


--1. TOTAL STORE REVENUE
SELECT 
       ROUND(SUM(Sales_Amount), 2) AS Total_Store_Revenue
FROM workspace.default.super_store_sales_dataset_1;


--2. CUSTOMER-AGE-GROUP PERFORMANCE
SELECT 
       Customer_Age_Group,
          ROUND(SUM(Sales_Amount), 2) AS Revenue_per_Age_grp
FROM workspace.default.super_store_sales_dataset_1
GROUP BY 
          Customer_Age_Group
ORDER BY 
          Revenue_per_Age_grp DESC;


--2.1 CUSTOMER RETENTION
SELECT
       ROUND(SUM(Sales_Amount), 2) AS Revenue_per_Segment,
          Customer_Segment
FROM workspace.default.super_store_sales_dataset_1
GROUP BY  
          Customer_Segment
ORDER BY 
          Revenue_per_Segment DESC;


--3. PRODUCT PERFORMANCE
SELECT 
      Product_Name,
         ROUND(SUM(Sales_Amount), 2) AS Revenue_by_Product
FROM workspace.default.super_store_sales_dataset_1
GROUP BY 
          Product_Name
ORDER BY 
          Revenue_by_Product DESC;


--4. DISCOUNT APPLIED
SELECT 
       Product_Name,
          ROUND(SUM(Quantity*Unit_Price), 2) AS Revenue_Discounted
FROM workspace.default.super_store_sales_dataset_1
WHERE 
       Discount_Pct > 0 --Applies in a query that has an Aggregate function only when the Column_Name is not aggregated and must appear before the GROUP BY
GROUP BY
       Product_Name
ORDER BY 
       Revenue_Discounted DESC;


-- 4.1 DISCOUNT NOT APPLIED
SELECT 
       Product_Name,
          ROUND(SUM(Quantity*Unit_Price), 2) AS Revenue_Undiscounted
FROM workspace.default.super_store_sales_dataset_1
WHERE 
       Discount_Pct = 0 --Applies in a query that has an Aggregate function only when the Column_Name is not aggregated and must appear before the GROUP BY
GROUP BY 
       Product_Name
ORDER BY 
       Revenue_Undiscounted DESC;

--5. CHANNEL PERFORMANCE
SELECT 
       Sales_Channel,
          ROUND(SUM(Sales_Amount)) AS Total_Revenue
FROM workspace.default.super_store_sales_dataset_1
GROUP BY 
       Sales_Channel
ORDER BY 
       Total_Revenue DESC;


--REGIONAL PERFORMANCE
SELECT Region,
       ROUND(SUM(Sales_Amount)) AS Total_Revenue
FROM workspace.default.super_store_sales_dataset_1
GROUP BY Region
ORDER BY Total_Revenue ASC;


