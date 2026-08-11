CREATE DATABASE sweden_food_price_inflation;


USE sweden_food_price_inflation;

SELECT DATABASE();


CREATE TABLE food_cpi (
    Product_Group VARCHAR(150),
    Month DATE,
    CPI DECIMAL(10,2)
);

CREATE TABLE food_sales (
    Product_Group VARCHAR(200),
    Measure VARCHAR(50),
    Year INT,
    Sales DECIMAL(15,2)
);

CREATE TABLE import_prices (
    Product_Group VARCHAR(150),
    Month DATE,
    Import_Price_Index DECIMAL(10,2)
);

CREATE TABLE eu_hicp (
    geo VARCHAR(30),
    Country VARCHAR(100),
    Month DATE,
    HICP DECIMAL(10,2)
);

SHOW TABLES;

SELECT 'food_cpi' AS table_name, COUNT(*) AS row_count FROM food_cpi
UNION ALL
SELECT 'food_sales', COUNT(*) FROM food_sales
UNION ALL
SELECT 'import_prices', COUNT(*) FROM import_prices
UNION ALL
SELECT 'eu_hicp', COUNT(*) FROM eu_hicp;


-- ============================================================
-- SWEDEN FOOD PRICE INFLATION ANALYSIS
-- SQL ANALYSIS
--
-- Purpose:
-- Analyze food price development, food sales, import prices,
-- and Sweden's food inflation relative to EU benchmarks.
--
-- Data sources:
-- 1. SCB - Food CPI
-- 2. SCB - Food Sales
-- 3. SCB - Import Price Index
-- 4. Eurostat - HICP Food and Non-Alcoholic Beverages
--
-- Database: sweden_food_price_inflation
-- ============================================================


-- ============================================================
-- PHASE 1: DATA QUALITY & STRUCTURE
-- ============================================================


-- 1.1 ROW COUNTS
-- Check the number of records loaded into each source.
-- ============================================================

SELECT 'food_cpi' AS table_name, COUNT(*) AS row_count
FROM food_cpi

UNION ALL

SELECT 'food_sales', COUNT(*)
FROM food_sales

UNION ALL

SELECT 'import_prices', COUNT(*)
FROM import_prices

UNION ALL

SELECT 'eu_hicp', COUNT(*)
FROM eu_hicp;

-- ============================================================
-- 1.2 DATE COVERAGE
-- Check the earliest and latest observations in each source.
-- ============================================================

SELECT
    'food_cpi' AS table_name,
    MIN(Month) AS first_month,
    MAX(Month) AS last_month
FROM food_cpi

UNION ALL

SELECT
    'import_prices',
    MIN(Month),
    MAX(Month)
FROM import_prices

UNION ALL

SELECT
    'eu_hicp',
    MIN(Month),
    MAX(Month)
FROM eu_hicp;


-- Food sales coverage
SELECT
    MIN(Year) AS first_year,
    MAX(Year) AS last_year
FROM food_sales;


-- ============================================================
-- 1.3 DATA STRUCTURE & CATEGORY COVERAGE
-- Identify the categories and measures available in each source.
-- ============================================================


-- Food CPI categories
SELECT DISTINCT Product_Group
FROM food_cpi
ORDER BY Product_Group;


-- Food sales categories and measures
SELECT DISTINCT
    Product_Group,
    Measure
FROM food_sales
ORDER BY Product_Group, Measure;


-- Import price categories
SELECT DISTINCT Product_Group
FROM import_prices
ORDER BY Product_Group;


-- HICP countries/geographies
SELECT DISTINCT
    geo,
    Country
FROM eu_hicp
ORDER BY Country;


-- ============================================================
-- 1.3a CHECK FOOD CPI STRUCTURE
-- ============================================================

SELECT *
FROM food_cpi
LIMIT 5;

-- ============================================================
-- 1.3b CHECK FOOD SALES STRUCTURE
-- ============================================================

SELECT *
FROM food_sales
LIMIT 5;


-- ============================================================
-- PHASE 2: FOOD PRICE DEVELOPMENT
-- ============================================================


-- 2.1 START VS END FOOD PRICE INDEX
-- Compare January 2018 with December 2023 for each category.
-- ============================================================

SELECT
    start_data.Product_Group,

    start_data.CPI AS CPI_2018,

    end_data.CPI AS CPI_2023,

    ROUND(
        (end_data.CPI - start_data.CPI)
        / start_data.CPI * 100,
        2
    ) AS Price_Change_Percent

FROM
    (
        SELECT
            Product_Group,
            CPI
        FROM food_cpi
        WHERE Month = '2018-01-01'
    ) AS start_data

JOIN
    (
        SELECT
            Product_Group,
            CPI
        FROM food_cpi
        WHERE Month = '2023-12-01'
    ) AS end_data

ON start_data.Product_Group = end_data.Product_Group

ORDER BY Price_Change_Percent DESC;



-- ============================================================
-- 2.2 OVERALL FOOD PRICE TREND
-- Calculate the average CPI across all food categories
-- for each month.
-- ============================================================

SELECT 
    Month,
    ROUND(AVG(CPI), 2) AS Average_Food_CPI
FROM food_cpi
GROUP BY Month
ORDER BY Month;



-- ============================================================
-- 2.3 ANNUAL FOOD PRICE TREND
-- Calculate the average CPI across all food categories
-- for each year.
-- ============================================================

SELECT
    YEAR(Month) AS Year,
    ROUND(AVG(CPI), 2) AS Average_Food_CPI
FROM food_cpi
GROUP BY YEAR(Month)
ORDER BY Year;


-- ============================================================
-- 2.4 YEAR-OVER-YEAR FOOD PRICE CHANGE
-- Calculate the annual percentage change in average food CPI.
-- ============================================================

WITH annual_cpi AS (
    SELECT
        YEAR(Month) AS Year,
        AVG(CPI) AS Average_CPI
    FROM food_cpi
    GROUP BY YEAR(Month)
)

SELECT
    Year,
    ROUND(Average_CPI, 2) AS Average_CPI,
    ROUND(
        (Average_CPI - LAG(Average_CPI) OVER (ORDER BY Year))
        / LAG(Average_CPI) OVER (ORDER BY Year) * 100,
        2
    ) AS YoY_Change_Percent
FROM annual_cpi
ORDER BY Year;


-- ============================================================
-- PHASE 3: FOOD SALES
-- ============================================================


-- 3.1 AVAILABLE SALES MEASURES
-- Identify the measures available in the sales dataset.
-- ============================================================

SELECT DISTINCT
    Measure
FROM food_sales
ORDER BY Measure;


-- ============================================================
-- 3.2 REAL FOOD SALES TREND
-- Use fixed-price sales to reduce the effect of inflation.
-- This provides a proxy for changes in real sales activity.
-- ============================================================

SELECT
    Year,
    ROUND(SUM(Sales), 2) AS Total_Fixed_Price_Sales
FROM food_sales
WHERE Measure = 'fixed prices'
GROUP BY Year
ORDER BY Year;


-- ============================================================
-- 3.3 YEAR-OVER-YEAR REAL SALES CHANGE
-- Measure annual changes in fixed-price food sales.
-- ============================================================

WITH annual_sales AS (
    SELECT
        Year,
        SUM(Sales) AS Total_Fixed_Price_Sales
    FROM food_sales
    WHERE Measure = 'fixed prices'
    GROUP BY Year
)

SELECT
    Year,
    ROUND(Total_Fixed_Price_Sales, 2) AS Total_Fixed_Price_Sales,
    ROUND(
        (
            Total_Fixed_Price_Sales
            - LAG(Total_Fixed_Price_Sales) OVER (ORDER BY Year)
        )
        / LAG(Total_Fixed_Price_Sales) OVER (ORDER BY Year) * 100,
        2
    ) AS YoY_Change_Percent
FROM annual_sales
ORDER BY Year;


-- ============================================================
-- 3.4 CATEGORY-LEVEL REAL SALES CHANGE
-- Compare fixed-price sales between 2021 and 2023.
-- ============================================================

SELECT
    start_data.Product_Group,

    ROUND(start_data.Sales, 2) AS Sales_2021,

    ROUND(end_data.Sales, 2) AS Sales_2023,

    ROUND(
        (end_data.Sales - start_data.Sales)
        / start_data.Sales * 100,
        2
    ) AS Sales_Change_Percent

FROM
    (
        SELECT
            Product_Group,
            Sales
        FROM food_sales
        WHERE Year = 2021
          AND Measure = 'fixed prices'
    ) AS start_data

JOIN
    (
        SELECT
            Product_Group,
            Sales
        FROM food_sales
        WHERE Year = 2023
          AND Measure = 'fixed prices'
    ) AS end_data

ON start_data.Product_Group = end_data.Product_Group

ORDER BY Sales_Change_Percent ASC;


-- ============================================================
-- PHASE 4: IMPORT PRICES VS CONSUMER PRICES
-- ============================================================

-- ============================================================
-- 4.1 ANNUAL IMPORT PRICE TREND
-- Calculate the average import price index for the
-- 10 food products for each year.
-- ============================================================

SELECT
    YEAR(Month) AS Year,
    ROUND(AVG(Import_Price_Index), 2) AS Average_Import_Price_Index
FROM import_prices
GROUP BY YEAR(Month)
ORDER BY Year;



-- ============================================================
-- 4.2 YEAR-OVER-YEAR IMPORT PRICE CHANGE
-- Calculate annual changes in the import price index.
-- ============================================================

WITH annual_import_prices AS (
    SELECT
        YEAR(Month) AS Year,
        AVG(Import_Price_Index) AS Average_Import_Price_Index
    FROM import_prices
    GROUP BY YEAR(Month)
)

SELECT
    Year,

    ROUND(
        Average_Import_Price_Index,
        2
    ) AS Average_Import_Price_Index,

    ROUND(
        (
            Average_Import_Price_Index
            - LAG(Average_Import_Price_Index) OVER (ORDER BY Year)
        )
        / LAG(Average_Import_Price_Index) OVER (ORDER BY Year) * 100,
        2
    ) AS YoY_Change_Percent

FROM annual_import_prices
ORDER BY Year;


-- ============================================================
-- PHASE 5: SWEDEN VS EU27
-- ============================================================


-- 5.1 ANNUAL FOOD HICP
-- Compare Sweden with the EU27 average.
-- ============================================================

SELECT
    YEAR(Month) AS Year,
    Country,
    ROUND(AVG(HICP), 2) AS Average_HICP
FROM eu_hicp
GROUP BY YEAR(Month), Country
ORDER BY Year, Country;


-- ============================================================
-- 5.2 SWEDEN VS EU27 PRICE DIFFERENCE
-- Calculate Sweden's percentage difference relative to EU27.
-- ============================================================

SELECT
    Year,

    ROUND(
        MAX(CASE
            WHEN Country = 'Sweden' THEN Average_HICP
        END),
        2
    ) AS Sweden_HICP,

    ROUND(
        MAX(CASE
            WHEN Country = 'European Union - 27 countries (from 2020)'
            THEN Average_HICP
        END),
        2
    ) AS EU27_HICP,

    ROUND(
        (
            MAX(CASE
                WHEN Country = 'Sweden' THEN Average_HICP
            END)
            -
            MAX(CASE
                WHEN Country = 'European Union - 27 countries (from 2020)'
                THEN Average_HICP
            END)
        )
        /
        MAX(CASE
            WHEN Country = 'European Union - 27 countries (from 2020)'
            THEN Average_HICP
        END) * 100,
        2
    ) AS Sweden_vs_EU_Percent

FROM (
    SELECT
        YEAR(Month) AS Year,
        Country,
        AVG(HICP) AS Average_HICP
    FROM eu_hicp
    GROUP BY YEAR(Month), Country
) AS annual_hicp

GROUP BY Year
ORDER BY Year;




