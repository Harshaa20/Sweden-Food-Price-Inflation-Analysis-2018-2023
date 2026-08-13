# Sweden Food Price Inflation Analysis | 2018–2023

> A self-directed business analytics project exploring food-price inflation in Sweden, category-level price changes, import-price pressure, real food sales, and Sweden's position relative to the EU27.

## Live Dashboard
https://public.tableau.com/views/SwedenFoodPriceInflationAnalysis20182023_17866305614900/ExecutiveOverview?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link


---

## Project Overview

Food prices became a major economic and business issue across Europe during 2022–2023. I wanted to investigate the Swedish food market beyond simply measuring whether prices increased.

This project examines:

- How food prices changed between 2018 and 2023
- Which food categories experienced the largest price increases
- How import prices moved relative to consumer food prices
- How fixed-price food sales changed during the period
- How Sweden's food-price trajectory compared with the EU27

This was a **self-directed portfolio project** focused on applying practical data analytics skills across the full workflow:

**Python → SQL → Business Analysis → Tableau**

The project intentionally focuses on descriptive analytics rather than predictive modelling or advanced statistical methods.

---

## Business Questions

1. How did food prices in Sweden evolve between 2018 and 2023?
2. Which food categories experienced the largest price increases?
3. Did import prices increase faster than consumer food prices?
4. What happened to fixed-price food sales during the period of accelerating inflation?
5. How closely did Sweden's food-price trajectory follow the EU27?

---

# 📈 Key Results

## 1. Food-price inflation accelerated sharply in 2022–2023

Annual food CPI growth remained relatively moderate through 2021 before accelerating significantly:

| Year | Food CPI | YoY Change |
|---|---:|---:|
| 2018 | 95.16 | — |
| 2019 | 97.81 | +2.78% |
| 2020 | 100.00 | +2.24% |
| 2021 | 99.95 | -0.05% |
| **2022** | **110.27** | **+10.33%** |
| **2023** | **125.19** | **+13.52%** |

**Key result:** The major acceleration in food-price inflation occurred in **2022–2023**, rather than being evenly distributed across the entire 2018–2023 period.

---

## 2. Food inflation varied substantially across categories

The food CPI dataset contained **58 product categories**.

The largest price increases between January 2018 and December 2023 were:

| Food Category | Price Increase |
|---|---:|
| Cane sugar and beet sugar | **+64.06%** |
| Vegetable oils | **+60.39%** |
| Eggs | **+55.05%** |
| Fish, live, fresh, chilled or frozen | **+53.86%** |
| Macaroni, noodles, couscous and similar pasta products | **+52.71%** |
| Margarine and similar preparations | **+51.38%** |
| Offal, blood and other parts of slaughtered animals | **+50.71%** |
| Flour of cereals | **+48.64%** |
| Other fruits, fresh | **+46.35%** |
| Fruit-bearing vegetables, fresh or chilled | **+46.11%** |

The smallest increase among the analysed categories was **+11.27%**.

**Key result:** Food inflation was highly uneven across product categories rather than being a uniform increase across the food market.

---

## 3. Import prices increased faster than consumer food prices

Between 2021 and 2023:

| Indicator | 2021 | 2023 | Change |
|---|---:|---:|---:|
| Import Price Index | 100.79 | 143.23 | **+42.1%** |
| Food CPI | 99.95 | 125.19 | **+25.2%** |

**Key result:** Import prices increased substantially faster than consumer food prices during 2021–2023, indicating significant upstream price pressure during the same period as the acceleration in food inflation.

This is an observed relationship, **not proof of causation**.

---

## 4. Fixed-price food sales declined after the 2021 peak

Fixed-price food sales reached their highest level in 2021:

| Year | Fixed-price Food Sales |
|---|---:|
| 2018 | 220,250 |
| 2019 | 218,525 |
| 2020 | 230,818 |
| **2021** | **236,631** |
| 2022 | 230,246 |
| 2023 | 221,594 |

From 2021 to 2023, fixed-price food sales declined by approximately **6.36%**.

**Key result:** The decline in fixed-price sales coincided with the period of accelerating food-price inflation.

This does not establish that inflation alone caused the decline.

---

## 5. Sweden broadly followed the EU27 food-price trajectory

| Year | Sweden | EU27 | Sweden vs EU27 |
|---|---:|---:|---:|
| 2018 | 105.89 | 104.51 | +1.32% |
| 2019 | 108.97 | 106.71 | +2.11% |
| 2020 | 111.27 | 109.43 | +1.68% |
| 2021 | 111.85 | 111.13 | +0.65% |
| 2022 | 124.90 | 124.34 | +0.45% |
| 2023 | 140.82 | 140.06 | +0.55% |

The Sweden–EU27 gap narrowed from **2.11% in 2019 to 0.55% in 2023**.

**Key result:** Sweden's food-price trajectory was broadly aligned with the EU27 rather than representing an isolated Swedish development.

---

# Business Insights

### Procurement & sourcing

Food inflation varied considerably by category. Sugar, vegetable oils, eggs, pasta and flour were among the categories experiencing the strongest price increases.

**Business implication:** Procurement teams should monitor category-level cost exposure rather than relying only on an overall food-inflation figure.

### Pricing & margin management

A single food CPI number can hide substantial differences between individual product categories.

**Business implication:** Category-level inflation can provide better context for pricing, margin management and supplier negotiations.

### Supply-chain monitoring

Import prices increased by approximately **42.1% between 2021 and 2023**, considerably faster than food CPI.

**Business implication:** Monitoring upstream import-price indicators alongside consumer prices can provide additional context when assessing supply-chain cost pressure.

### Demand & sales

Fixed-price food sales declined by approximately **6.36% from 2021 to 2023** while food prices accelerated.

**Business implication:** Businesses need to distinguish between nominal sales growth caused by higher prices and genuine growth in real sales activity.

### European benchmarking

Sweden's food-price trajectory remained close to the EU27 throughout the period.

**Business implication:** Comparing national price movements with regional benchmarks can help distinguish country-specific developments from broader European market conditions.

---

# Project Workflow

```text
Public Statistical Data
        ↓
Python / Google Colab
        ↓
Data Cleaning & Validation
        ↓
MySQL Database
        ↓
SQL Analysis in DBeaver
        ↓
Dashboard-ready SQL Views
        ↓
CSV Exports
        ↓
Tableau Public
        ↓
Interactive Business Dashboards
