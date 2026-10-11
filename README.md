# 🏧 ATM Operations & Cash Management Analytics

## 📌 1. Executive Summary

Banks operate extensive ATM networks that generate large volumes of operational data related to customer transactions, cash availability, replenishment activities, and maintenance operations.

Analyzing these data sources together can help banking operations teams understand customer demand, ATM utilization, cash availability, transaction reliability, and operational performance.

**ATM Operations & Cash Management Analytics** is an end-to-end Business Intelligence project developed using MySQL, SQL, Microsoft Power BI, and DAX. It integrates multiple aspects of ATM operations into a structured analytical solution, transforming raw operational records into meaningful business insights.

Unlike a conventional transaction-count dashboard, this project focuses on connecting transaction activity with cash inventory, replenishment, and maintenance information to support operational monitoring and decision-making.

🎯 **Central business question:**

*Which ATMs and locations require the greatest operational attention, and why?*

## 🚨 2. Business Problem

ATM operators must maintain sufficient cash availability, reliable transaction services, and operational efficiency while managing replenishment and maintenance costs.

However, transaction records, cash inventory, replenishment information, and maintenance records represent different parts of the operational process. Analyzing these areas independently can make it difficult to understand the overall performance of an ATM.

For example:

- 💵 A high-transaction ATM may require frequent cash replenishment.
- ⚠️ An ATM may experience transaction failures despite having sufficient cash.
- 📉 An underutilized ATM may still incur recurring maintenance expenses.
- 🚚 Frequent replenishment activity may indicate a need to review cash-demand patterns.
- 🔧 Repeated downtime may affect the reliability of an otherwise important ATM location.

Looking at only one metric may lead to incomplete operational decisions.

This project brings these analytical perspectives together to help identify patterns, investigate potential operational issues, and support better-informed management decisions.

## 🔄 3. End-to-End Analytical Framework

The project follows a connected operational analysis framework:

**Customer Demand → Transaction Activity → Cash Dispensed → Cash Inventory → Replenishment Requirement → ATM Availability → Maintenance & Downtime → Operational Priority**

Each stage contributes to understanding ATM operations:

| Stage | Analytical focus |
|---|---|
| 👥 Customer demand | Customer segments, transaction patterns, and demand variations |
| 💳 Transaction activity | Transaction volume, type, status, and response time |
| 💰 Cash inventory | Opening balance, cash dispensed, closing balance, and cash availability |
| 🚚 Replenishment | Replenishment frequency, amounts, and delivery information |
| 🔧 Maintenance | Incidents, downtime, severity, resolution, and maintenance costs |
| 📊 Operational performance | Utilization, reliability, demand, and location comparisons |
| 🎯 Management attention | Identification of locations requiring further investigation |

## 🎯 4. Project Objectives

- 🗄️ Build a connected analytical model covering ATM operations and supporting business entities.
- 💳 Analyze transaction performance, transaction types, and transaction outcomes.
- 💵 Examine cash availability, cash utilization, low-cash conditions, and cash-out incidents.
- 🚚 Investigate cash replenishment activity and demand patterns.
- 🔧 Analyze maintenance frequency, downtime, and operational costs.
- 🌍 Compare ATM performance across geographic areas and location types.
- 🧮 Develop KPI measures for consistent operational reporting.
- 📈 Build interactive Power BI dashboards for management analysis.
- 🔍 Apply advanced SQL techniques to answer business questions.
- 💡 Translate analytical findings into potential operational recommendations.

## 🛠️ 5. Technology Stack

| Technology | Purpose |
|---|---|
| 🐬 MySQL | Relational database and SQL-based analysis |
| 💻 SQL | Data validation, joins, aggregations, CTEs, subqueries, and analytical queries |
| 📊 Microsoft Power BI | Interactive dashboard development and visualization |
| 🧮 DAX | KPI calculations and business measures |
| 📁 CSV | Data storage, import, and preparation |
| 🧹 Data validation | Checking data quality and consistency |

## 📂 6. Dataset Overview

The project uses a multi-table ATM operations dataset containing transaction, cash inventory, replenishment, maintenance, and supporting business information.

### Key datasets

| Dataset | Description | Records |
|---|---|---:|
| Transactions | ATM transaction activity and outcomes | 500,000 |
| Daily Cash Inventory | Daily ATM cash inventory records | 500,500 |
| ATM Locations | ATM identification and location information | 500 |
| Cash Replenishments | Cash replenishment activities | 49,962 |
| Maintenance Records | ATM maintenance information | 15,000 |

Additional supporting datasets cover bank branches, customers, calendar information, and holidays or events.

The relational structure connects the major operational entities to support analysis across transactions, locations, cash movements, replenishments, and maintenance.

> ℹ️ The dataset counts describe the data used during project development. The project is an analytical demonstration, not a live banking monitoring system.

## 🧹 7. Data Preparation & Validation

Data quality is essential because inconsistencies between operational tables can lead to misleading analytical results.

The project incorporates SQL-based data validation and preparation activities to support reliable reporting.

Key activities include:

- ✅ Checking table structures and record counts.
- 🔎 Reviewing missing values and duplicate records where applicable.
- 🔗 Validating identifiers and relationships between tables.
- 📅 Checking date and timestamp consistency.
- 🏷️ Reviewing transaction statuses and categorical values.
- 📊 Preparing data for business-oriented aggregation and analysis.
- 🧮 Comparing analytical calculations with Power BI reporting outputs where applicable.

## 💻 8. SQL Analytics

A total of **26 SQL analytical queries** were developed to investigate ATM operational performance and business questions.

### SQL techniques applied

- 🔗 JOIN operations to combine related datasets.
- 📊 Aggregate functions and `GROUP BY` for business summaries.
- 🧠 Common Table Expressions (CTEs) for structured analytical queries.
- 🔍 Subqueries for conditional analysis.
- 🏷️ `CASE` expressions for classification where applicable.
- 🗂️ SQL views for reusable analytical logic where implemented.
- 📈 Trend, transaction-status, cash-management, and maintenance analysis.

### Major analytical areas

**💳 Transaction Analytics**
- Transaction volume and transaction-type distribution.
- Successful, failed, and reversed transactions.
- Transaction performance patterns.

**💵 Cash Management Analytics**
- Daily cash inventory.
- Cash availability and cash movement.
- Replenishment activity and cash-demand patterns.

**🔧 Maintenance Analytics**
- Maintenance record analysis.
- Operational incidents and downtime-related information.
- Maintenance-cost reporting where the required fields are available.

**🌍 Geographic & Operational Analysis**
- Comparison of ATM locations and branches.
- Identification of demand patterns and areas requiring further investigation.

## 📈 9. Key Analytical Findings

### Transaction status distribution

| Transaction status | Records | Share |
|---|---:|---:|
| 🟢 Successful | 482,753 | 96.55% |
| 🔴 Failed | 13,739 | 2.75% |
| 🟠 Reversed | 3,508 | 0.70% |
| **Total** | **500,000** | **100%** |

### Transaction type distribution

| Transaction type | Records | Share |
|---|---:|---:|
| 💵 Cash Withdrawal | 340,351 | 68.07% |
| 🔍 Balance Inquiry | 59,923 | 11.98% |
| 💰 Cash Deposit | 59,854 | 11.97% |
| 📄 Mini Statement | 39,872 | 7.97% |
| **Total** | **500,000** | **100%** |

*Percentages are rounded to two decimal places.*

### 💡 Business interpretation

- Cash withdrawals represent the largest transaction category in the dataset.
- Failed and reversed transactions provide useful indicators for service-performance monitoring.
- Cash inventory and replenishment records offer additional context for investigating cash-management patterns.
- Maintenance information can help support operational reliability analysis.

These observations describe the dataset. Additional investigation is required to establish the causes of failures, cash shortages, or maintenance issues.

## 🧩 10. Power BI Data Modeling

A **9-table Power BI data model** was developed to support integrated reporting across the available operational datasets.

The model uses relationships between relevant tables to support cross-filtering and analysis of ATM transactions, locations, inventory, replenishment, and maintenance.

### Key components

- 🔗 Relationships between related data entities.
- 🧮 Reusable DAX measures.
- 📊 Visual representations of operational metrics.
- 🎛️ Interactive filters and slicers.
- 🔎 Cross-table exploration of operational patterns.

The purpose of the data model is to provide a consistent foundation for reporting and business analysis.

## 🧮 11. KPI Framework & DAX Measures

**12 DAX KPI measures** were created for the Power BI reporting solution.

The project proposal organizes operational KPIs into several business areas:

| KPI category | Examples | Business purpose |
|---|---|---|
| 🏧 ATM Performance | Transaction volume, cash withdrawn, utilization | Understand ATM usage and demand |
| 💰 Cash Management | Cash dispensed, closing cash, replenishment amount, low-cash indicators | Monitor cash availability |
| 💳 Transaction Quality | Success rate, failure rate, response time, peak-hour share | Examine transaction performance |
| 🔧 Maintenance | Downtime, incidents, maintenance cost, resolution status | Investigate operational reliability |
| 🌍 Geographic Analysis | ATM count, transactions, cash withdrawals by location | Compare demand across locations |
| 🎯 Decision Support | Performance and operational priority indicators | Support further investigation and prioritization |

The exact KPI names and formulas should correspond to the measures implemented in the Power BI report.

## 📊 12. Power BI Dashboard Design

The project proposal defines a management-oriented dashboard structure with approximately seven analytical pages. The final repository should reflect the pages actually implemented.

### Proposed dashboard areas

**1. 📌 Executive Overview**

A consolidated view of transaction performance, cash availability, demand trends, and key operational indicators.

**2. 🏧 ATM Performance**

Analysis of transaction volume, cash withdrawals, utilization, and high- or low-performing ATMs.

**3. 💵 Cash Management**

Analysis of opening and closing cash, cash dispensed, replenishment activity, and low-cash conditions.

**4. 💳 Transaction Analytics**

Investigation of transaction outcomes, transaction types, response times, and peak-demand periods.

**5. 🌍 Geographic Analysis**

Comparison of ATM activity across regions, cities, branches, and location types.

**6. 🔧 Maintenance & Reliability**

Analysis of maintenance records, downtime, severity, resolution status, and costs where available.

**7. 🎯 Risk & Decision Intelligence**

A proposed operational prioritization view designed to identify ATMs that may require attention and show the indicators supporting that priority.

### 🖼️ Dashboard Preview

Add screenshots of your completed Power BI pages here so visitors can see the actual report.

Example Markdown:

`![ATM Analytics Dashboard](Screenshots/atm_dashboard.png)`

Replace the filename with the actual screenshot path in the repository.

## 🎯 13. Operational Priority & Decision Support

A central concept in the proposal is to move beyond basic transaction reporting and help management understand which ATMs may require attention.

Two scoring concepts are proposed:

**🏆 ATM Performance Score**

A proposed composite indicator combining relevant transaction activity, utilization, cash availability, and service-reliability measures.

**⚠️ Operational Risk/Priority Score**

A proposed indicator combining relevant signals such as low-cash frequency, cash-out incidents, transaction failures, downtime, maintenance activity, and demand criticality.

These concepts require documented calculation rules, weights, and thresholds. They should be presented as implemented features only if the corresponding scoring logic exists in the final project.

## 🔄 14. Project Workflow

The end-to-end workflow follows these stages:

1. 📝 Define the business problem and operational questions.
2. 🗄️ Import the dataset into MySQL.
3. 🧹 Perform data-quality checks and validation.
4. 💻 Develop SQL queries for business analysis.
5. 🔗 Prepare relevant datasets for reporting.
6. 🧩 Create the Power BI data model and relationships.
7. 🧮 Develop DAX measures and KPI calculations.
8. 📊 Build interactive dashboard pages.
9. ✅ Validate calculations and reporting logic.
10. 📘 Document the analytical findings and project deliverables.

## 💼 15. Business Value

The project demonstrates how relational data analysis and Business Intelligence can support banking operations.

Potential business benefits include:

- 💵 Better visibility into cash inventory and replenishment patterns.
- 📊 More structured monitoring of ATM transaction performance.
- 🔍 Easier identification of locations requiring further investigation.
- 🔧 Improved visibility into maintenance and downtime indicators.
- 🌍 Better comparison of demand across locations.
- 🎯 More informed prioritization of operational reviews.
- 📈 A consolidated reporting environment for management analysis.

These are potential benefits of the analytical solution, not measured financial savings or proven improvements in a live banking network.

## ⚠️ 16. Assumptions & Limitations

- The project uses an analytical dataset rather than live ATM feeds.
- Data quality and the relationships between tables affect the reliability of the results.
- Synthetic data patterns may not fully represent real banking operations.
- Observed associations do not automatically establish the causes of transaction failures or cash shortages.
- Performance and operational priority scores require transparent definitions and validation.
- The dashboard is designed for analytical decision support, not real-time ATM control or automated cash replenishment.

## 📁 17. Repository Contents

The repository contains the available SQL scripts, Power BI report, DAX measures, and project documentation.

- 💻 SQL scripts for data preparation, validation, and business analysis.
- 🧮 DAX measures used in Power BI.
- 📊 Power BI `.pbix` report.
- 🖼️ Dashboard screenshots, if uploaded.
- 📘 Project documentation.

Refer to the actual repository folders and filenames for the available deliverables.

## 🏁 18. Conclusion

The ATM Operations & Cash Management Analytics project demonstrates an end-to-end Business Intelligence workflow connecting transaction activity with cash inventory, replenishment, maintenance, and operational performance.

By combining SQL-based analytical investigation with Power BI data modeling, DAX measures, and interactive reporting, the project provides a structured way to explore ATM operations and communicate findings to business stakeholders.

The project showcases practical skills relevant to **Data Analyst, Business Intelligence Analyst, and Reporting Analyst** roles, including SQL querying, data validation, relational modeling, KPI development, dashboard design, and business-focused analysis.

---

## 👨‍💻 Author

**Rohan Rajesh Ram**

🔗 GitHub Profile: [Rohanr0412](https://github.com/Rohanr0412)

📂 Project Repository: [ATM Operations & Cash Management Analytics](https://github.com/Rohanr0412/ATM-Operations-Cash-Management-Analytics)

⭐ If you find this project interesting, consider starring the repository!
