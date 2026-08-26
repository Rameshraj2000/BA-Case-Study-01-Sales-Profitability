USE sales_project;

SELECT COUNT(*) AS total_rows
FROM sales;
SET SESSION cte_max_recursion_depth = 10000;

WITH RECURSIVE numbers AS (
    SELECT 1 AS n
    
    UNION ALL
    
    SELECT n + 1
    FROM numbers
    WHERE n < 9994
)

SELECT numbers.n AS missing_row_id
FROM numbers
LEFT JOIN sales
    ON numbers.n = sales.`Row ID`
WHERE sales.`Row ID` IS NULL;

SELECT
    MIN(`Row ID`) AS first_missing_id,
    MAX(`Row ID`) AS last_missing_id,
    COUNT(*) AS missing_count
FROM (
    WITH RECURSIVE numbers AS (
        SELECT 1 AS n

        UNION ALL

        SELECT n + 1
        FROM numbers
        WHERE n < 9994
    )
    
    SELECT numbers.n AS `Row ID`
    FROM numbers
    LEFT JOIN sales
        ON numbers.n = sales.`Row ID`
    WHERE sales.`Row ID` IS NULL
) AS missing_ids;

SELECT
    COUNT(*) AS total_rows,

    SUM(`Row ID` IS NULL) AS missing_row_id,
    SUM(`Order ID` IS NULL) AS missing_order_id,
    SUM(`Customer ID` IS NULL) AS missing_customer_id,
    SUM(`Product ID` IS NULL) AS missing_product_id,
    SUM(`Order Date` IS NULL) AS missing_order_date,
    SUM(`Ship Date` IS NULL) AS missing_ship_date,
    SUM(`Sales` IS NULL) AS missing_sales,
    SUM(`Quantity` IS NULL) AS missing_quantity,
    SUM(`Discount` IS NULL) AS missing_discount,
    SUM(`Profit` IS NULL) AS missing_profit

FROM sales;

SELECT
    `Order ID`,
    `Product ID`,
    COUNT(*) AS duplicate_count
FROM sales
GROUP BY
    `Order ID`,
    `Product ID`
HAVING COUNT(*) > 1;

SELECT
    `Order ID`,
    `Product ID`,
    COUNT(*) AS record_count,
    SUM(`Quantity`) AS total_quantity,
    SUM(`Sales`) AS total_sales,
    SUM(`Profit`) AS total_profit
FROM sales
GROUP BY
    `Order ID`,
    `Product ID`
HAVING COUNT(*) > 1
ORDER BY record_count DESC;

SELECT
    `Row ID`,
    `Order ID`,
    `Product ID`,
    `Order Date`,
    `Quantity`,
    `Sales`,
    `Discount`,
    `Profit`
FROM sales
WHERE `Order ID` = 'CA-2016-129714'
  AND `Product ID` = 'OFF-PA-10001970';
  
SELECT *
FROM sales
WHERE `Quantity` <= 0;

SELECT *
FROM sales
WHERE `Sales` < 0;

SELECT *
FROM sales
WHERE `Discount` < 0
   OR `Discount` > 1;
   
SELECT *
FROM sales
WHERE `Ship Date` < `Order Date`;

SELECT *
FROM sales
WHERE STR_TO_DATE(`Ship Date`, '%m/%d/%Y')
      <
      STR_TO_DATE(`Order Date`, '%m/%d/%Y');
      
SELECT
    MIN(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS earliest_order_date,
    MAX(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS latest_order_date,
    MIN(STR_TO_DATE(`Ship Date`, '%m/%d/%Y')) AS earliest_ship_date,
    MAX(STR_TO_DATE(`Ship Date`, '%m/%d/%Y')) AS latest_ship_date
FROM sales;

SELECT DISTINCT `Category`
FROM sales
ORDER BY `Category`;

SELECT DISTINCT `Sub-Category`
FROM sales
ORDER BY `Sub-Category`;

SELECT DISTINCT `Segment`
FROM sales
ORDER BY `Segment`;

SELECT DISTINCT `Region`
FROM sales
ORDER BY `Region`;

SELECT DISTINCT `Ship Mode`
FROM sales
ORDER BY `Ship Mode`;

SELECT *
FROM sales
WHERE `Profit` > `Sales`;