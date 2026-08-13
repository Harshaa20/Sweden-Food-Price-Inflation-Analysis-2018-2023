# Sweden Food Price Inflation Analysis | 2018–2023

A self-directed business analytics project investigating why food prices in Sweden rose so sharply, where the pressure was concentrated, and what it meant for real food sales.

## Dashboard Link 
https://public.tableau.com/views/SwedenFoodPriceInflationAnalysis20182023_17866305614900/ExecutiveOverview?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link

---

## Why I Did This Project

As a student living in Sweden, one of the most noticeable changes in everyday life during 2022–2023 was the cost of food. Grocery prices were rising quickly, and it raised a simple question for me:

**What was actually happening behind the increase in Swedish food prices?**

This was not an academic exercise I was assigned. It started from a real observation as a consumer and became a business analytics question.

The timing was significant. Sweden experienced a sharp acceleration in food inflation after 2021. The Riksbank attributed the broader inflation shock to post-pandemic supply and demand imbalances, rising energy and commodity prices, and additional disruptions caused by Russia's invasion of Ukraine. Energy costs also affect the food supply chain through production, processing, storage and transportation. :contentReference[oaicite:1]{index=1}

SCB reported that Swedish food prices were 18.6% higher in December 2022 than a year earlier, making the increase impossible to dismiss as normal year-to-year price variation. :contentReference[oaicite:2]{index=2}

I wanted to use actual Swedish and European data to understand the story rather than relying on headlines.

---

## Business Problem

The overall food-price index tells us that prices increased, but it does not answer the questions that matter to a business.

I wanted to understand:

- When did food-price inflation actually accelerate?
- Which food categories were most exposed?
- Were upstream import prices moving differently from consumer food prices?
- Did real food sales change as prices increased?
- Was Sweden experiencing something unique, or was this part of a wider European trend?

The goal was therefore to move from **"food became more expensive"** to a more useful view of **where the pressure occurred, how the market responded, and what businesses could learn from it.**

---

# Key Results

### Food-price inflation accelerated sharply

| Year | Food CPI | YoY Change |
|---|---:|---:|
| 2018 | 95.16 | — |
| 2019 | 97.81 | +2.78% |
| 2020 | 100.00 | +2.24% |
| 2021 | 99.95 | -0.05% |
| 2022 | 110.27 | +10.33% |
| 2023 | 125.19 | +13.52% |

The major acceleration occurred in **2022–2023**, rather than being evenly distributed across the six-year period.

---

### The impact differed substantially by food category

The analysis covered **58 food CPI categories**.

The largest price increases from January 2018 to December 2023 were:

| Category | Increase |
|---|---:|
| Cane sugar and beet sugar | **+64.06%** |
| Vegetable oils | **+60.39%** |
| Eggs | **+55.05%** |
| Fish | **+53.86%** |
| Pasta | **+52.71%** |
| Margarine and similar preparations | **+51.38%** |
| Offal | **+50.71%** |
| Flour of cereals | **+48.64%** |
| Other fruits, fresh | **+46.35%** |
| Fruit-bearing vegetables | **+46.11%** |

The smallest increase among the analysed categories was **+11.27%**.

This shows that food inflation was not a uniform increase across the market.

---

### Import prices increased faster than consumer food prices

Between 2021 and 2023:

- Import Price Index: **100.79 → 143.23 (+42.1%)**
- Food CPI: **99.95 → 125.19 (+25.2%)**

The stronger increase in import prices indicates significant upstream price pressure during the same period in which consumer food prices accelerated.

This is an observed relationship, not proof that import prices alone caused consumer inflation.

---

### Real food sales declined after the 2021 peak

Fixed-price food sales:

- 2021: **236,631**
- 2022: **230,246**
- 2023: **221,594**

This represents a **6.36% decline between 2021 and 2023**.

This matters because nominal sales can rise simply because prices rise. Looking at fixed-price sales provides a better view of changes in real sales activity.

SCB similarly reported that Swedish consumers bought less food by volume in 2022 despite spending more money, with food and beverage sales increasing 6.6% in value while volume declined 2.7%. :contentReference[oaicite:3]{index=3}

---

### Sweden broadly followed the EU27

The Sweden–EU27 difference narrowed from:

**+2.11% in 2019 → +0.55% in 2023**

Sweden therefore followed a broadly similar food-price trajectory to the EU27 rather than experiencing a completely isolated Swedish shock.

---

# Business Insights

### 1. Food inflation is a category-level problem, not just an overall CPI problem

The difference between **+64.06% for sugar** and **+11.27% for the lowest-increase category** shows why businesses should not treat food inflation as one uniform cost increase.

For procurement and supply-chain teams, category-level monitoring can identify where cost exposure is actually concentrated.

### 2. Upstream price pressure matters

Import prices increased much faster than consumer food prices between 2021 and 2023.

For businesses dependent on imported food or food inputs, monitoring upstream price indicators can provide additional context for procurement, supplier negotiations and cost planning.

### 3. Higher prices did not translate into stronger real sales

Fixed-price food sales fell after 2021 while food prices accelerated.

For a business, this distinction matters:

**Higher nominal sales ≠ higher real demand.**

Pricing, demand planning and revenue analysis therefore need to separate price effects from volume effects.

### 4. The Swedish experience was part of a wider European shock

The close Sweden–EU27 movement suggests that businesses should distinguish between country-specific developments and broader European cost pressures.

This is particularly relevant for companies operating across multiple European markets.

---

# Analysis Approach

The project deliberately uses **descriptive business analytics** rather than predictive modelling.

The analysis followed five stages:

### 1. Data Cleaning — Python

Cleaned and prepared the raw statistical datasets in Google Colab using Python and Pandas.

Key work included:

- Data-type conversion
- Date standardization
- Missing-value checks
- Column standardization
- Filtering relevant observations
- Data validation

### 2. Database Preparation — MySQL

Loaded the cleaned datasets into MySQL using DBeaver.

This created a structured environment for analysing multiple datasets consistently.

### 3. SQL Analysis

Used SQL to answer the business questions through:

- Aggregation
- Grouping
- Filtering
- Joins
- Date functions
- Year-over-year calculations
- Percentage-change calculations
- Current vs fixed-price comparisons
- Sweden vs EU27 benchmarking

### 4. Dashboard Preparation

Created SQL views specifically for visualization rather than putting all analytical logic directly into Tableau.

### 5. Tableau Visualization

Built three dashboards:

1. **Executive Overview**
2. **Food Prices, Import Pressure & Sales**
3. **Sweden vs EU27 | Food Price Context**

---

# Concepts I Learned

This project strengthened my understanding of several practical analytics concepts.

### Data Analytics

- Data cleaning and validation
- Working with multiple real-world datasets
- Choosing the right metric for a business question
- Trend analysis
- Year-over-year analysis
- Category benchmarking
- Cross-market comparison

### SQL

- Aggregation with `SUM()`, `AVG()` and `COUNT()`
- `GROUP BY` and `HAVING`
- Filtering with `WHERE`
- Joining datasets
- Date functions
- Percentage-change calculations
- Creating reusable SQL views
- Separating analysis logic from visualization logic

### Business Analytics

- Translating a real-world observation into measurable business questions
- Distinguishing nominal values from real/fixed-price values
- Identifying category-level exposure
- Using upstream indicators to understand cost pressure
- Benchmarking Sweden against a regional reference
- Converting analytical findings into procurement, pricing and demand implications
- Understanding the difference between correlation and causation

### Data Visualization

- Choosing charts based on the question rather than the dataset
- KPI design
- Trend visualization
- Ranked category comparisons
- Comparative line charts
- Dashboard hierarchy
- Presenting analytical results for a business audience

---

# What I Learned

The biggest lesson from this project was that **good business analysis is not about making the analysis unnecessarily complicated.**

The project started with a simple personal observation — food felt much more expensive in Sweden — but answering that question properly required moving through the entire analytics process:

**Observation → Business Question → Data → Cleaning → SQL → Findings → Business Interpretation → Dashboard**

I learned that an analyst has to make decisions at every stage:

- What should actually be measured?
- Which comparison is meaningful?
- Does the result make business sense?
- Is the result robust enough to communicate?
- What can the data prove?
- What can it not prove?

One of the most important lessons was learning to avoid overclaiming. For example, import prices and food CPI both increased strongly, but this analysis does not prove that import prices caused consumer food inflation. Likewise, declining fixed-price sales occurred alongside rising food prices, but inflation cannot be isolated as the sole cause.

That distinction between **finding a relationship and claiming causation** is something I consider an important part of becoming a better business analyst.

---

# Limitations

This project intentionally remains descriptive.

- It does not establish causal relationships.
- Import-price increases are not proven to be the direct cause of food-price inflation.
- The decline in fixed-price sales cannot be attributed to inflation alone.
- Category-level CPI movements are not expenditure-weighted measures of household impact.
- The analysis covers 2018–2023 and is not intended as a current market forecast.
- No predictive modelling or advanced statistical inference was applied.

---

# Tools

**Python · Pandas · Google Colab · MySQL · DBeaver · Tableau Public · Git/GitHub**

---

# Project Structure

```text
Sweden-Food-Price-Inflation/
│
├── data/
│   ├── raw/
│   ├── cleaned/
│   └── dashboard/
│
├── notebooks/
│   └── 01_data_cleaning.ipynb
│
├── sql/
│   ├── 02_sql_analysis.sql
│   ├── 03_sql_key_findings.sql
│   └── 04_dashboard_views.sql
│
└── README.md
