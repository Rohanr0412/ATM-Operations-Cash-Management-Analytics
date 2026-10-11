# ATM Operations & Cash Management Analytics

## 1. Project Overview

The **ATM Operations & Cash Management Analytics** project is an end-to-end data analytics solution developed using MySQL, SQL, Microsoft Power BI, and DAX.

The project focuses on analyzing ATM transaction performance, cash availability, cash replenishment activities, and maintenance operations. It transforms operational data into meaningful insights through SQL-based analysis and interactive Power BI dashboards.

The objective is to help banking operations teams monitor ATM performance, understand transaction failures, improve cash management visibility, and identify opportunities to enhance operational efficiency.

## 2. Business Problem

Banks and ATM operators need to maintain reliable ATM services while ensuring sufficient cash availability and minimizing operational disruptions.

Transaction failures, cash shortages, frequent replenishments, and maintenance issues can affect customer experience and increase operating costs.

This project addresses the following business questions:

- How many ATM transactions are successful, failed, or reversed?
- Which transaction types are most frequently used?
- How can ATM cash inventory and replenishment activities be monitored?
- How can maintenance records support operational analysis?
- What insights can help banking teams improve ATM availability and cash management?

## 3. Project Objectives

- Analyze ATM transaction trends and transaction outcomes.
- Monitor daily cash inventory and replenishment activity.
- Examine ATM maintenance records and operational patterns.
- Perform data-quality checks and SQL-based business analysis.
- Develop a structured Power BI data model.
- Create DAX measures to calculate key performance indicators.
- Present findings through interactive dashboards for business users.

## 4. Tools and Technologies

| Technology | Purpose |
|---|---|
| MySQL | Database storage and SQL analysis |
| SQL | Data validation, joins, aggregations, CTEs, subqueries, and analytical queries |
| Microsoft Power BI | Interactive dashboard development |
| DAX | KPI calculations and business measures |
| Power Query | Data preparation and transformation where applicable |
| CSV | Dataset storage and data import |

## 5. Dataset Overview

The project uses a multi-table ATM operations dataset containing transaction, ATM, cash inventory, replenishment, and maintenance information.

| Data area | Records |
|---|---:|
| Transactions | 500,000 |
| Daily cash inventory | 500,500 |
| ATM locations | 500 |
| Cash replenishments | 49,962 |
| Maintenance records | 15,000 |

The broader dataset also contains supporting tables for banking branches, customers, calendar information, and holidays or events.

*Note: Record counts describe the dataset used during project development. They do not represent live banking data.*

## 6. SQL Analysis and Data Validation

SQL was used to validate the data and perform business-oriented analysis.

Key activities included:

- Checking record counts and data quality.
- Analyzing transaction status and transaction types.
- Combining related tables using joins.
- Summarizing data using aggregate functions and GROUP BY.
- Applying subqueries and Common Table Expressions (CTEs).
- Creating analytical views to organize reusable query logic.
- Investigating cash inventory, replenishment activity, and maintenance records.

A total of **26 SQL analytical queries** were developed to explore operational performance and answer business questions.

## 7. Key Findings

The transaction analysis identified the following distribution:

| Transaction status | Records |
|---|---:|
| Successful | 482,753 |
| Failed | 13,739 |
| Reversed | 3,508 |
| **Total** | **500,000** |

The transaction types were distributed as follows:

| Transaction type | Records |
|---|---:|
| Cash Withdrawal | 340,351 |
| Balance Inquiry | 59,923 |
| Cash Deposit | 59,854 |
| Mini Statement | 39,872 |
| **Total** | **500,000** |

These results show that cash withdrawals account for the largest share of recorded transactions. Failed and reversed transactions are also important areas for operational monitoring.

The analysis provides a foundation for investigating transaction reliability and cash-management patterns. Further investigation would be required before attributing failures to specific causes.

## 8. Power BI Data Model

A Power BI data model was developed using nine related tables.

The model connects relevant operational data to support analysis across transactions, ATM locations, cash inventory, replenishments, and maintenance.

The data model supports consistent filtering and cross-table analysis through relationships between relevant entities.

## 9. DAX Measures and KPIs

**12 DAX KPI measures** were created for operational reporting.

The measures support monitoring of transaction performance and cash-management activity. The dashboard is designed to help users review metrics such as:

- Total transaction volume.
- Successful transactions.
- Failed transactions.
- Reversed transactions.
- Transaction success and failure rates.
- Transaction-type distribution.
- Cash inventory indicators.
- Cash replenishment activity.
- Maintenance-related operational indicators.

The exact metrics available depend on the implemented DAX measures and the fields present in the dataset.

## 10. Power BI Dashboard

The Power BI report presents operational data through interactive visualizations, KPI cards, filters, and slicers.

The dashboard is intended to help users:

- Review overall ATM transaction performance.
- Compare transaction outcomes and transaction types.
- Examine cash inventory and replenishment activity.
- Explore maintenance-related information.
- Filter results to investigate specific operational segments.

### Dashboard Preview

Add your actual dashboard screenshots here after uploading them to the repository.

For example:

`![ATM Analytics Dashboard](Screenshots/atm_dashboard.png)`

Replace the image path with the exact filename and folder used in your repository.

## 11. Business Value

This project demonstrates how SQL and business intelligence tools can be combined to turn operational data into useful information.

Potential business benefits include:

- Improved visibility into ATM transaction performance.
- Better monitoring of cash inventory and replenishment activity.
- Easier identification of transaction patterns requiring investigation.
- More structured reporting of maintenance operations.
- Faster access to operational KPIs through interactive dashboards.
- Support for data-driven operational decisions.

These are intended benefits of the analytical solution, not measured financial savings or proven improvements in live ATM operations.

## 12. Project Workflow

1. Imported the dataset into MySQL.
2. Validated tables and checked data quality.
3. Performed SQL-based exploratory and business analysis.
4. Prepared the relevant data for reporting.
5. Built a nine-table Power BI data model.
6. Created 12 DAX KPI measures.
7. Developed interactive dashboard pages.
8. Organized SQL scripts, dashboard files, and documentation in GitHub.

## 13. Repository Structure

The repository contains the SQL analysis scripts, DAX measures, Power BI report, and project documentation.

- SQL scripts: database setup, data validation, and business analysis.
- DAX: Power BI KPI measures.
- Power BI: interactive dashboard report.
- Screenshots: visual previews of dashboard pages.
- README: project documentation and analytical findings.

Refer to the actual folders and filenames in this repository for the available project files.

## 14. Skills Demonstrated

- SQL querying and relational data analysis.
- Data validation and quality checks.
- Exploratory and business data analysis.
- Common Table Expressions and subqueries.
- KPI development and DAX.
- Power BI data modeling and dashboard design.
- Translating business questions into analytical outputs.
- Communicating findings through data visualization.

## 15. Conclusion

The ATM Operations & Cash Management Analytics project demonstrates an end-to-end analytics workflow combining SQL-based investigation with Power BI reporting.

By analyzing 500,000 transaction records alongside cash inventory, replenishment, and maintenance data, the project provides a structured view of ATM operational performance.

The project showcases practical skills relevant to Data Analyst and Business Intelligence roles, including data preparation, SQL analysis, KPI development, data modeling, dashboard creation, and business-focused reporting.

## Author

**Rohan Rajesh Ram**

GitHub: [Rohanr0412](https://github.com/Rohanr0412)

Project Repository: [ATM Operations & Cash Management Analytics](https://github.com/Rohanr0412/ATM-Operations-Cash-Management-Analytics)
