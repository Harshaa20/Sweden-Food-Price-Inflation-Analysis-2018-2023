-- ============================================================
-- SWEDEN FOOD PRICE INFLATION ANALYSIS
-- Dashboard Data Preparation
-- ============================================================
--
-- Purpose:
-- Create clean SQL views for Tableau visualization.
--
-- Source tables:
--   food_cpi
--   food_sales
--   import_prices
--   eu_hicp
--
-- These views do not introduce new analysis.
-- They prepare the results of the SQL analysis for visualization.
-- ============================================================



-- ============================================================
-- VIEW 1: ANNUAL FOOD CPI
-- ============================================================

CREATE OR REPLACE VIEW vw_annual_food_cpi AS
SELECT
    YEAR(Month) AS Year,
    ROUND(AVG(CPI), 2) AS Average_Food_CPI
FROM food_cpi
GROUP BY YEAR(Month)
ORDER BY Year;

SELECT *
FROM vw_annual_food_cpi;


-- ============================================================
-- VIEW 2: FOOD CATEGORY PRICE CHANGE
-- Compare January 2018 with December 2023.
-- ============================================================

CREATE OR REPLACE VIEW vw_food_category_change AS
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
ON start_data.Product_Group = end_data.Product_Group;


SELECT *
FROM vw_food_category_change
ORDER BY Price_Change_Percent DESC;


-- ============================================================
-- VIEW 3: ANNUAL FIXED-PRICE FOOD SALES
-- ============================================================

CREATE OR REPLACE VIEW vw_annual_food_sales AS
SELECT
    Year,
    ROUND(SUM(Sales), 2) AS Total_Fixed_Price_Sales
FROM food_sales
WHERE Measure = 'fixed prices'
GROUP BY Year
ORDER BY Year;

SELECT *
FROM vw_annual_food_sales;


-- ============================================================
-- VIEW 4: ANNUAL IMPORT PRICE INDEX
-- ============================================================

CREATE OR REPLACE VIEW vw_annual_import_prices AS
SELECT
    YEAR(Month) AS Year,
    ROUND(AVG(Import_Price_Index), 2) AS Average_Import_Price_Index
FROM import_prices
GROUP BY YEAR(Month)
ORDER BY Year;

SELECT *
FROM vw_annual_import_prices;


-- ============================================================
-- VIEW 5: SWEDEN VS EU27 HICP
-- ============================================================

CREATE OR REPLACE VIEW vw_sweden_vs_eu AS
SELECT
    YEAR(Month) AS Year,
    Country,
    ROUND(AVG(HICP), 2) AS Average_HICP
FROM eu_hicp
GROUP BY YEAR(Month), Country
ORDER BY Year, Country;

SELECT *
FROM vw_sweden_vs_eu;

