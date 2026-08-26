USE sales_project;

SELECT
	ROUND(SUM(Sales)) as Total_sales,
    ROUND(SUM(Profit)) as Total_profit,
    ROUND(SUM(Profit) / NULLIF(SUM(Sales), 0) * 100) as Profit_Margin
FROM
	sales;
    
SELECT
	Region,
    ROUND(SUM(Sales), 2) as Total_sales,
    ROUND(SUM(Profit), 2) as Total_Profit,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2) as Profit_Margin
FROM
	sales
GROUP BY Region
ORDER BY Total_sales DESC;

SELECT
	Category,
    ROUND(SUM(Sales), 2) as Total_sales,
    ROUND(SUM(Profit), 2) as Total_Profit,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2) as Profit_Margin
FROM
	sales
GROUP BY Category
ORDER BY Total_sales;

SELECT
    Discount,
    COUNT(*) AS Transaction_Count,
    ROUND(SUM(Sales), 2) as Total_sales,
    ROUND(SUM(Profit), 2) as Total_Profit,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2) as Profit_Margin
FROM
	sales
GROUP BY Discount
ORDER BY Discount;

SELECT
	`Product Name`,
    COUNT(*) AS Transaction_Count,
    ROUND(SUM(Sales), 2) as Total_sales,
    ROUND(SUM(Profit), 2) as Total_Profit,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2) as Profit_Margin
FROM
	sales
GROUP BY `Product Name`
HAVING SUM(Profit) < 0
ORDER BY Total_profit ASC
LIMIT 10;

SELECT
    COUNT(*) AS Loss_Making_Products,
    ROUND(SUM(Total_Profit), 2) AS Total_Negative_Profit
FROM
(
    SELECT
        `Product Name`,
        SUM(Profit) AS Total_Profit
    FROM sales
    GROUP BY `Product Name`
    HAVING SUM(Profit) < 0
) AS Loss_Making;

SELECT
	Segment,
	COUNT(*) AS Transaction_Count,
    ROUND(SUM(Sales), 2) as Total_sales,
    ROUND(SUM(Profit), 2) as Total_Profit,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2) as Profit_Margin
FROM
	sales
GROUP BY Segment
ORDER BY Total_sales;

SELECT
    YEAR(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS Order_Year,
    COUNT(*) AS Transaction_Count,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS Profit_Margin
FROM sales
GROUP BY Order_Year
ORDER BY Order_Year;

SELECT
    `Ship Mode`,
    COUNT(*) AS Transaction_Count,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS Profit_Margin
FROM sales
GROUP BY `Ship Mode`
ORDER BY Total_Sales DESC;

SELECT
    `Sub-Category`, 
    COUNT(*) AS Transaction_Count,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS Profit_Margin
FROM sales
GROUP BY `Sub-Category`
ORDER BY Total_Sales DESC;

SELECT
    COUNT(*) AS Loss_Making_SubCategories,
    ROUND(SUM(Total_Profit), 2) AS Total_Negative_Profit
FROM
(
    SELECT
        `Sub-Category`,
        SUM(Profit) AS Total_Profit
    FROM sales
    GROUP BY `Sub-Category`
    HAVING SUM(Profit) < 0
) AS Loss_Making_SubCategories;

SELECT
    `Sub-Category`,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS Profit_Margin
FROM sales
GROUP BY `Sub-Category`
HAVING SUM(Profit) < 0
ORDER BY Total_Profit ASC;

SELECT
	Discount,
    COUNT(*) as Transaction_Count,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS Profit_Margin
FROM
	sales
WHERE
	`Sub-Category` = 'Tables'
GROUP BY Discount
ORDER BY Discount;
    
SELECT
    Region,
    COUNT(*) as Transaction_Count,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS Profit_Margin
FROM
	sales
WHERE
	`Sub-Category` = 'Tables'
GROUP BY Discount
ORDER BY Discount;

SELECT
    Region,
    Discount,
    COUNT(*) as Transaction_Count,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS Profit_Margin
FROM
	sales
WHERE
	`Sub-Category` = 'Tables'
GROUP BY Discount, Region
ORDER BY Discount, Region;

SELECT
	`Product Name`,
    Region,
    Discount,
    COUNT(*) as Transaction_Count,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS Profit_Margin
FROM
	sales 
WHERE
	`Sub-Category` = 'Tables'
    AND Discount >= 0.30
GROUP BY `Product Name`, Region, Discount
ORDER BY Total_sales ASC;

SELECT
    `Product Name`,
    COUNT(*) AS Transaction_Count,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS Profit_Margin
FROM sales
WHERE `Sub-Category` = 'Tables'
  AND Discount >= 0.30
GROUP BY `Product Name`
ORDER BY Total_Profit ASC
LIMIT 5;

SELECT
    Region,
    `Product Name`,
    COUNT(*) AS Transaction_Count,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS Profit_Margin
FROM sales
WHERE `Sub-Category` = 'Tables'
  AND Discount >= 0.30
  AND `Product Name` IN (
      'Chromcraft Bull-Nose Wood Oval Conference Tables & Bases',
      'Bush Advantage Collection Racetrack Conference Table',
      'Balt Solid Wood Round Tables',
      'Bevis Oval Conference Table, Walnut',
      'Riverside Furniture Oval Coffee Table, Oval End Table, End Table with Drawer'
  )
GROUP BY Region, `Product Name`
ORDER BY Total_Profit ASC;

SELECT
    Region,

    COUNT(*) AS Total_Transactions,

    SUM(CASE
        WHEN Discount >= 0.30 THEN 1
        ELSE 0
    END) AS High_Discount_Transactions,

    ROUND(
        SUM(CASE
            WHEN Discount >= 0.30 THEN 1
            ELSE 0
        END) / COUNT(*) * 100,
        2
    ) AS High_Discount_Exposure_Percent,

    ROUND(
        SUM(CASE
            WHEN Discount >= 0.30 THEN Sales
            ELSE 0
        END),
        2
    ) AS High_Discount_Sales,

    ROUND(
        SUM(CASE
            WHEN Discount >= 0.30 THEN Profit
            ELSE 0
        END),
        2
    ) AS High_Discount_Profit,

    ROUND(
        (
            SUM(CASE
                WHEN Discount >= 0.30 THEN Profit
                ELSE 0
            END)
            /
            NULLIF(
                SUM(CASE
                    WHEN Discount >= 0.30 THEN Sales
                    ELSE 0
                END),
                0
            )
        ) * 100,
        2
    ) AS High_Discount_Profit_Margin

FROM sales

WHERE `Sub-Category` = 'Tables'

GROUP BY Region

ORDER BY High_Discount_Exposure_Percent DESC;

    