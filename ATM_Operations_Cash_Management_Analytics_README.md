# ATM Operations & Cash Management Analytics

## Project Overview

This project focuses on analyzing ATM operations and cash management using **MySQL and Power BI**.

The project combines ATM transaction data, customer information, ATM locations, cash inventory, cash replenishment, maintenance and branch information to understand ATM usage and operational performance.

The main goal was to convert raw ATM data into useful business insights that can help in monitoring ATM performance, transaction demand, cash operations and maintenance activities.

## Business Problem

ATM-related information is available across different tables such as transactions, ATM locations, cash inventory, cash replenishment and maintenance records.

Looking at these tables separately makes it difficult to understand the overall performance of an ATM.

The project focuses on questions such as:

- Which ATMs have the highest transaction volume?
- Which ATMs have higher transaction failure rates?
- When is ATM transaction demand highest?
- How much cash is being replenished and for what reasons?
- Which ATMs have higher maintenance activity and downtime?
- What are the differences in ATM activity across locations?
- Which ATMs require closer operational attention?

## Project Objectives

- Analyze ATM transaction patterns
- Identify high-volume ATMs
- Analyze successful, failed and reversed transactions
- Understand transaction demand by hour and month
- Analyze cash replenishment activity
- Analyze ATM maintenance and downtime
- Compare ATM performance across locations
- Create operational KPIs
- Build an interactive Power BI dashboard

## Dataset

The project uses an India ATM Business Analytics dataset containing multiple related tables.

### Main Tables

| Table | Description |
|---|---|
| `atm_locations` | ATM location, city, state, branch and ATM details |
| `bank_branches` | Bank branch information |
| `customers` | Customer demographic and account information |
| `transactions` | ATM transaction details |
| `cash_inventory_daily` | Daily ATM cash inventory information |
| `cash_replenishments` | Cash replenishment records |
| `maintenance_records` | ATM maintenance and downtime records |
| `calendar` | Date-related information |
| `holidays_events` | Holiday and event information |

### Dataset Size

The imported dataset contains approximately **1.07 million records** across the main tables.

- Transactions: **500,000**
- Cash Inventory Daily: **500,500**
- Maintenance Records: **15,000**
- Cash Replenishments: **49,962**
- Customers: **10,000**
- ATM Locations: **500**
- Bank Branches: **200**
- Calendar: **1,001**
- Holidays & Events: **1,000**

## Data Preparation & Quality Checks

The data was first imported into MySQL and checked before the main analysis.

Checks included:

- Duplicate ID checks
- Missing-value checks
- Relationship checks
- Invalid transaction amount checks
- Transaction status validation
- Transaction type and channel analysis
- Customer data consistency checks

# SQL Analysis

A total of **26 business analyses** were performed.

The analysis included transaction volume and value, transaction success and failure, transaction type and channel, hourly demand, weekend vs weekday activity, state-level ATM performance, ATM failure rate, cash utilization, cash replenishment, replenishment reasons and status, maintenance incidents, downtime, maintenance cost and operational risk.

## SQL Techniques Used

- `SELECT`
- `WHERE`
- `GROUP BY`
- `HAVING`
- `ORDER BY`
- `LIMIT`
- `JOIN`
- `LEFT JOIN`
- `CASE`
- Aggregate functions
- Conditional aggregation
- CTEs
- Date and time functions
- Window functions
- `LAG()`
- `COALESCE()`

The complete SQL work is included in the repository.

# Key SQL Results

### Transaction Performance

- Total Transactions: **500,000**
- Successful Transaction Rate: **96.55%**
- Failed Transaction Rate: **2.75%**
- Reversed Transaction Rate: **0.70%**
- Average Transaction Amount: **₹2,694.30**

### Transaction Demand

Transaction activity was highest around **11 AM to 3 PM**, with **1 PM** having the highest transaction volume at approximately **45,857 transactions**.

### Transaction Types

Cash Withdrawal was the largest transaction type with **340,351 transactions**.

### Cash Replenishment

- Total Replenishment Amount: **₹13.72 billion**
- Scheduled replenishment was the largest replenishment reason.

### Maintenance

- Total ATM Downtime: **49,633.65 hours**
- Total Maintenance Cost: **₹141.49 million**

Security Camera maintenance had the highest number of maintenance incidents in the dataset.

# Power BI Dashboard

After completing the SQL analysis, the data was imported into Power BI.

I created **12 DAX KPI measures** and a **4-page interactive dashboard**.

## Dashboard Pages

### 1. Executive Overview

- Total Transactions
- Total Transaction Value
- Successful Transaction Rate
- Failed Transaction Rate
- Average Transaction Amount
- Total Maintenance Cost
- Monthly Transaction Trend

### 2. Transaction & Customer Analytics

- Transaction Volume by Type
- Transactions by Channel
- Hourly Transaction Demand

### 3. Cash Management

- Total Replenishment Amount
- Total ATM Downtime Hours
- Average Cash Utilization
- Replenishment Amount by Reason
- Replenishment Status

### 4. ATM Performance & Risk

- Top 10 ATMs by Transaction Volume
- Top 10 ATMs by Failure Rate
- Maintenance Incidents by Type
- ATM Geographic Performance

# Key Findings

1. The dataset contains **500,000 ATM transactions**.
2. The overall successful transaction rate was **96.55%**.
3. Transaction activity was highest around **11 AM–3 PM**.
4. **Cash Withdrawal** was the largest transaction type.
5. Total cash replenishment was approximately **₹13.72 billion**.
6. Total recorded ATM downtime was approximately **49,633.65 hours**.
7. Total maintenance cost was approximately **₹141.49 million**.
8. Some individual ATMs had failure rates noticeably higher than the overall failure rate.
9. Maintenance activity varied between ATM types and locations.
10. ATM transaction activity varied across different cities and states.

# Business Recommendations

- Monitor ATMs with higher transaction failure rates.
- Review ATMs with frequent maintenance incidents or higher downtime.
- Use transaction-demand patterns when planning operational activities.
- Review replenishment schedules using transaction activity.
- Compare maintenance costs across ATMs and maintenance types.
- Use geographic analysis to identify differences in ATM activity.

# Project Limitations

- The dataset is a provided/synthetic business dataset.
- The `low_cash_flag` and `cash_out_flag` fields did not contain actual positive cash-out events in the analyzed data.
- The project therefore does not claim to identify real cash-out incidents.
- The dashboard is based on the available dataset and is not a real-time ATM monitoring system.
- The 2025 transaction data may represent only part of the year in the dataset.

# Tools Used

- **MySQL** – Database setup, data validation and SQL analysis
- **Power BI** – Dashboard and visualization
- **DAX** – KPI calculations
- **Power Query** – Data preparation in Power BI
- **Excel/CSV** – Source data

# Project Structure

```text
ATM-Operations-Cash-Management-Analytics
│
├── README.md
├── SQL
│   ├── 01_Database_Setup_and_Import.sql
│   ├── 02_Data_Quality_Checks.sql
│   └── 03_Business_Analysis.sql
│
├── PowerBI
│   └── ATM_Operations_Cash_Management_Analytics.pbix
│
├── Dashboard_Screenshots
│   ├── Executive_Overview.png
│   ├── Transaction_Customer_Analytics.png
│   ├── Cash_Management.png
│   └── ATM_Performance_Risk.png
│
└── Documentation
    └── Project_Report.docx
```

# How to Use

### SQL

Open the SQL files in **MySQL Workbench**.

The files are organized into:

1. Database setup and data import
2. Data-quality checks
3. Business analysis

### Power BI

Open the `.pbix` file using **Microsoft Power BI Desktop** to explore the dashboard and DAX measures.

# Project Outcome

The final project combines SQL analysis and Power BI visualization to provide a single view of ATM transactions, cash management, maintenance and ATM performance.

SQL was used for data preparation, validation and detailed business analysis, while Power BI and DAX were used to convert the analysis into an interactive dashboard.

## Author

**Rohan Ram**
