/*
ATM Operations & Cash Management Analytics
FILE 3 - KPI & BUSINESS ANALYSIS

Purpose:
- Calculate the main project KPIs.
- Analyse ATM, customer, transaction, cash and maintenance performance.
- Study time-based transaction demand.
- Analyse replenishment activity.
- Identify ATM failure and operational-risk patterns.
- Use advanced SQL techniques such as JOINs, CTEs, CASE/conditional
  aggregation, grouping, sorting and the LAG() window function.

This file contains the complete business-analysis work from the project.
*/

USE atm_business_analytics;

-- KPI 1: Total Transactions
SELECT COUNT(*) AS total_transactions
FROM transactions;


-- KPI 2: Total Transaction Value
SELECT
    SUM(amount_inr) AS total_transaction_value
FROM transactions;


-- KPI 3: Successful Transaction Rate
SELECT
    ROUND(
        SUM(status = 'Successful') * 100.0 / COUNT(*),
        2
    ) AS successful_transaction_rate_pct
FROM transactions;


-- KPI 4: Failed Transaction Rate
SELECT
    ROUND(
        SUM(status = 'Failed') * 100.0 / COUNT(*),
        2
    ) AS failed_transaction_rate_pct
FROM transactions;


-- KPI 5: Average Transaction Amount
SELECT
    ROUND(AVG(amount_inr), 2) AS average_transaction_amount
FROM transactions;


-- KPI 6: Cash Withdrawal Value
SELECT
    ROUND(SUM(amount_inr), 2) AS cash_withdrawal_value
FROM transactions
WHERE transaction_type = 'Cash Withdrawal';


-- KPI 7: Cash Deposit Value
SELECT
    ROUND(SUM(amount_inr), 2) AS cash_deposit_value
FROM transactions
WHERE transaction_type = 'Cash Deposit';

-- KPI 8: Average Cash Utilization
SELECT
    ROUND(AVG(utilization_pct), 2) AS average_cash_utilization_pct
FROM cash_inventory_daily;

-- KPI 9: Cash-Out Rate
SELECT
    ROUND(
        SUM(cash_out_flag = 'Yes') * 100.0 / COUNT(*),
        2
    ) AS cash_out_rate_pct
FROM cash_inventory_daily;

-- KPI 10: Total Replenishment Amount
SELECT
    ROUND(SUM(replenishment_amount_inr), 2) AS total_replenishment_amount
FROM cash_replenishments;


-- KPI 11: Total ATM Downtime Hours
SELECT
    ROUND(SUM(downtime_hours), 2) AS total_atm_downtime_hours
FROM maintenance_records;

-- KPI 12: Total Maintenance Cost
SELECT
    ROUND(SUM(maintenance_cost_inr), 2) AS total_maintenance_cost
FROM maintenance_records;





#Advanced SQL 1: ATM-wise Transaction Performance
-- What: Summarise transactions, value, average amount and success rate for each ATM.
-- Why: To compare ATM-level transaction performance.

SELECT
    a.atm_id,
    a.city,
    a.state,
    a.region,
    COUNT(t.transaction_id) AS total_transactions,
    ROUND(SUM(t.amount_inr), 2) AS total_transaction_value,
    ROUND(AVG(t.amount_inr), 2) AS average_transaction_amount,
    ROUND(
        SUM(t.status = 'Successful') * 100.0
        / COUNT(t.transaction_id),
        2
    ) AS success_rate_pct
FROM atm_locations a
LEFT JOIN transactions t
    ON a.atm_id = t.atm_id
GROUP BY
    a.atm_id,
    a.city,
    a.state,
    a.region
ORDER BY total_transactions DESC;



SELECT
    a.atm_id,
    a.city,
    a.state,
    a.region,
    COUNT(t.transaction_id) AS total_transactions,
    ROUND(SUM(t.amount_inr), 2) AS total_transaction_value,
    ROUND(
        SUM(t.status = 'Successful') * 100.0
        / COUNT(t.transaction_id),
        2
    ) AS success_rate_pct
FROM atm_locations a
LEFT JOIN transactions t
    ON a.atm_id = t.atm_id
GROUP BY
    a.atm_id,
    a.city,
    a.state,
    a.region
ORDER BY total_transactions DESC
LIMIT 10;


SELECT
    a.atm_id,
    a.city,
    a.state,
    a.region,
    COUNT(t.transaction_id) AS total_transactions,
    ROUND(SUM(t.amount_inr), 2) AS total_transaction_value,
    ROUND(
        SUM(t.status = 'Successful') * 100.0
        / COUNT(t.transaction_id),
        2
    ) AS success_rate_pct
FROM atm_locations a
LEFT JOIN transactions t
    ON a.atm_id = t.atm_id
GROUP BY
    a.atm_id,
    a.city,
    a.state,
    a.region
HAVING COUNT(t.transaction_id) < 800
ORDER BY total_transactions ASC
limit 10;





SELECT
    a.state,
    a.region,
    COUNT(DISTINCT a.atm_id) AS total_atms,
    COUNT(t.transaction_id) AS total_transactions,
    ROUND(SUM(t.amount_inr), 2) AS total_transaction_value,
    ROUND(AVG(t.amount_inr), 2) AS average_transaction_amount,
    ROUND(
        SUM(t.status = 'Successful') * 100.0
        / COUNT(t.transaction_id),
        2
    ) AS success_rate_pct
FROM atm_locations a
LEFT JOIN transactions t
    ON a.atm_id = t.atm_id
GROUP BY
    a.state,
    a.region
ORDER BY total_transactions DESC;



SELECT
    DATE_FORMAT(transaction_datetime, '%Y-%m') AS transaction_month,
    COUNT(*) AS total_transactions,
    ROUND(SUM(amount_inr), 2) AS total_transaction_value,
    ROUND(AVG(amount_inr), 2) AS average_transaction_amount,
    ROUND(
        SUM(status = 'Successful') * 100.0 / COUNT(*),
        2
    ) AS success_rate_pct
FROM transactions
GROUP BY
    DATE_FORMAT(transaction_datetime, '%Y-%m')
ORDER BY
    transaction_month;
    
    
    
    
    
    -- Advanced SQL 6: Year-wise Transaction Performance
-- What: Summarise transaction volume and value by year.
-- Why: To compare yearly transaction activity.

SELECT
    YEAR(transaction_datetime) AS transaction_year,
    COUNT(*) AS total_transactions,
    ROUND(SUM(amount_inr), 2) AS total_transaction_value,
    ROUND(AVG(amount_inr), 2) AS average_transaction_amount,
    ROUND(
        SUM(status = 'Successful') * 100.0 / COUNT(*),
        2
    ) AS success_rate_pct
FROM transactions
GROUP BY
    YEAR(transaction_datetime)
ORDER BY
    transaction_year;
    
    
    -- Advanced SQL 7: Customer Age Group Analysis
-- What: Group customers into age bands and count customers.
-- Why: To understand the customer age mix.

SELECT
    CASE
        WHEN age < 25 THEN '18-24'
        WHEN age BETWEEN 25 AND 34 THEN '25-34'
        WHEN age BETWEEN 35 AND 44 THEN '35-44'
        WHEN age BETWEEN 45 AND 59 THEN '45-59'
        ELSE '60+'
    END AS age_group,
    COUNT(*) AS customer_count
FROM customers
GROUP BY
    CASE
        WHEN age < 25 THEN '18-24'
        WHEN age BETWEEN 25 AND 34 THEN '25-34'
        WHEN age BETWEEN 35 AND 44 THEN '35-44'
        WHEN age BETWEEN 45 AND 59 THEN '45-59'
        ELSE '60+'
    END
ORDER BY
    MIN(age);
    
    
    
    
    
    -- Advanced SQL 8: Customer Age Group Transaction Analysis
-- What: Analyse transaction volume and value by customer age group.
-- Why: To understand which age groups generate more ATM activity.

SELECT
    CASE
        WHEN c.age < 25 THEN '18-24'
        WHEN c.age BETWEEN 25 AND 34 THEN '25-34'
        WHEN c.age BETWEEN 35 AND 44 THEN '35-44'
        WHEN c.age BETWEEN 45 AND 59 THEN '45-59'
        ELSE '60+'
    END AS age_group,
    COUNT(t.transaction_id) AS total_transactions,
    ROUND(SUM(t.amount_inr), 2) AS total_transaction_value,
    ROUND(AVG(t.amount_inr), 2) AS average_transaction_amount,
    ROUND(
        SUM(t.status = 'Successful') * 100.0
        / COUNT(t.transaction_id),
        2
    ) AS success_rate_pct
FROM customers c
JOIN transactions t
    ON c.customer_id = t.customer_id
GROUP BY
    CASE
        WHEN c.age < 25 THEN '18-24'
        WHEN c.age BETWEEN 25 AND 34 THEN '25-34'
        WHEN c.age BETWEEN 35 AND 44 THEN '35-44'
        WHEN c.age BETWEEN 45 AND 59 THEN '45-59'
        ELSE '60+'
    END
ORDER BY
    total_transactions DESC;
    
    
    
    
    -- Advanced SQL 9: Transaction Type Performance
-- What: Compare transaction types using volume, value and average amount.
-- Why: To see which services are used most.

SELECT
    transaction_type,
    COUNT(*) AS total_transactions,
    ROUND(SUM(amount_inr), 2) AS total_transaction_value,
    ROUND(AVG(amount_inr), 2) AS average_transaction_amount,
    ROUND(
        SUM(status = 'Successful') * 100.0 / COUNT(*),
        2
    ) AS success_rate_pct
FROM transactions
GROUP BY
    transaction_type
ORDER BY
    total_transactions DESC;
    
    
    SELECT
    channel,
    COUNT(*) AS total_transactions,
    ROUND(SUM(amount_inr), 2) AS total_transaction_value,
    ROUND(AVG(amount_inr), 2) AS average_transaction_amount,
    ROUND(
        SUM(status = 'Successful') * 100.0 / COUNT(*),
        2
    ) AS success_rate_pct
FROM transactions
GROUP BY
    channel
ORDER BY
    total_transactions DESC;
    
    
    SELECT
    CASE
        WHEN is_peak_hour = 1 THEN 'Peak Hour'
        ELSE 'Non-Peak Hour'
    END AS time_period,
    COUNT(*) AS total_transactions,
    ROUND(SUM(amount_inr), 2) AS total_transaction_value,
    ROUND(AVG(amount_inr), 2) AS average_transaction_amount,
    ROUND(
        SUM(status = 'Successful') * 100.0 / COUNT(*),
        2
    ) AS success_rate_pct
FROM transactions
GROUP BY
    CASE
        WHEN is_peak_hour = 1 THEN 'Peak Hour'
        ELSE 'Non-Peak Hour'
    END
ORDER BY
    total_transactions DESC;
    
    
    
    -- Advanced SQL 12: Hourly Transaction Demand
-- What: Count transactions by hour of the day.
-- Why: To identify periods of higher transaction demand.

SELECT
    HOUR(transaction_datetime) AS transaction_hour,
    COUNT(*) AS total_transactions,
    ROUND(SUM(amount_inr), 2) AS total_transaction_value,
    ROUND(AVG(amount_inr), 2) AS average_transaction_amount
FROM transactions
GROUP BY
    HOUR(transaction_datetime)
ORDER BY
    total_transactions DESC;
    
    
    -- Advanced SQL 13: Daily Transaction Trend
-- What: Summarise transaction activity by date.
-- Why: To see day-to-day demand patterns.

SELECT
    DATE(transaction_datetime) AS transaction_date,
    COUNT(*) AS total_transactions,
    ROUND(SUM(amount_inr), 2) AS total_transaction_value,
    ROUND(AVG(amount_inr), 2) AS average_transaction_amount,
    ROUND(
        SUM(status = 'Successful') * 100.0 / COUNT(*),
        2
    ) AS success_rate_pct
FROM transactions
GROUP BY
    DATE(transaction_datetime)
ORDER BY
    transaction_date;
    
    
    
    -- Advanced SQL 14: Weekend vs Weekday Transaction Analysis
-- What: Compare transaction activity on weekdays and weekends.
-- Why: To understand differences in demand by day type.

SELECT
    CASE
        WHEN DAYOFWEEK(transaction_datetime) IN (1, 7)
            THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,
    COUNT(*) AS total_transactions,
    ROUND(SUM(amount_inr), 2) AS total_transaction_value,
    ROUND(AVG(amount_inr), 2) AS average_transaction_amount,
    ROUND(
        SUM(status = 'Successful') * 100.0 / COUNT(*),
        2
    ) AS success_rate_pct
FROM transactions
GROUP BY
    CASE
        WHEN DAYOFWEEK(transaction_datetime) IN (1, 7)
            THEN 'Weekend'
        ELSE 'Weekday'
    END
ORDER BY
    total_transactions DESC;
    
    
    -- Advanced SQL 15: Monthly Performance by Year
-- What: Compare monthly transaction performance across years.
-- Why: To identify recurring monthly patterns and changes.

SELECT 
    YEAR(transaction_datetime) AS transaction_year,
    MONTH(transaction_datetime) AS transaction_month,
    COUNT(*) AS total_transactions,
    ROUND(SUM(amount_inr), 2) AS total_transaction_value,
    ROUND(AVG(amount_inr), 2) AS average_transaction_amount,
    ROUND(SUM(status = 'Successful') * 100.0 / COUNT(*),
            2) AS success_rate_pct
FROM
    transactions
GROUP BY YEAR(transaction_datetime) , MONTH(transaction_datetime)
ORDER BY transaction_year , transaction_month;




    
    -- Advanced SQL 16: Year-over-Year Monthly Transaction Growth
-- What: Compare a month's transaction count with the previous year's same month using LAG().
-- Why: To measure year-over-year change in transaction demand.

WITH monthly_data AS (
    SELECT
        YEAR(transaction_datetime) AS transaction_year,
        MONTH(transaction_datetime) AS transaction_month,
        COUNT(*) AS total_transactions,
        ROUND(SUM(amount_inr), 2) AS total_transaction_value
    FROM transactions
    GROUP BY
        YEAR(transaction_datetime),
        MONTH(transaction_datetime)
)

SELECT
    transaction_year,
    transaction_month,
    total_transactions,
    total_transaction_value,
    LAG(total_transactions) OVER (
        PARTITION BY transaction_month
        ORDER BY transaction_year
    ) AS previous_year_transactions,
    ROUND(
        (
            total_transactions -
            LAG(total_transactions) OVER (
                PARTITION BY transaction_month
                ORDER BY transaction_year
            )
        ) * 100.0
        /
        NULLIF(
            LAG(total_transactions) OVER (
                PARTITION BY transaction_month
                ORDER BY transaction_year
            ),
            0
        ),
        2
    ) AS yoy_transaction_growth_pct
FROM monthly_data
ORDER BY
    transaction_year,
    transaction_month;
    
    
    
    -- Advanced SQL 17: Transaction Status Analysis
-- What: Summarise transactions by status.
-- Why: To understand successful, failed and reversed transactions.

SELECT
    status,
    COUNT(*) AS total_transactions,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS transaction_share_pct,
    ROUND(SUM(amount_inr), 2) AS total_transaction_value,
    ROUND(AVG(amount_inr), 2) AS average_transaction_amount
FROM transactions
GROUP BY
    status
ORDER BY
    total_transactions DESC;
    
    
    
    
    
    
    -- Advanced SQL 18: ATM Operational Risk Ranking
-- What: Compare ATMs using operational risk indicators and rank the results.
-- Why: To identify ATMs that may need closer operational attention.

SELECT
    a.atm_id,
    a.city,
    a.state,
    COUNT(t.transaction_id) AS total_transactions,
    SUM(t.status = 'Failed') AS failed_transactions,
    ROUND(
        SUM(t.status = 'Failed') * 100.0
        / COUNT(t.transaction_id),
        2
    ) AS failure_rate_pct
FROM atm_locations a
LEFT JOIN transactions t
    ON a.atm_id = t.atm_id
GROUP BY
    a.atm_id,
    a.city,
    a.state
ORDER BY
    failure_rate_pct DESC,
    failed_transactions DESC
LIMIT 10;






-- Advanced SQL 19: ATM Maintenance Performance
-- What: Summarise maintenance incidents, downtime and cost by ATM.
-- Why: To identify maintenance-intensive ATMs.

SELECT
    a.atm_id,
    a.city,
    a.state,
    COUNT(m.maintenance_id) AS maintenance_incidents,
    ROUND(SUM(m.downtime_hours), 2) AS total_downtime_hours,
    ROUND(SUM(m.maintenance_cost_inr), 2) AS total_maintenance_cost,
    ROUND(AVG(m.maintenance_cost_inr), 2) AS average_maintenance_cost
FROM atm_locations a
LEFT JOIN maintenance_records m
    ON a.atm_id = m.atm_id
GROUP BY
    a.atm_id,
    a.city,
    a.state
ORDER BY
    total_downtime_hours DESC
LIMIT 10;




-- Advanced SQL 20: Maintenance Type Performance
-- What: Compare maintenance types by incident count, downtime and cost.
-- Why: To understand which maintenance areas use more operational resources.

SELECT
    maintenance_type,
    COUNT(*) AS maintenance_incidents,
    ROUND(SUM(downtime_hours), 2) AS total_downtime_hours,
    ROUND(AVG(downtime_hours), 2) AS average_downtime_hours,
    ROUND(SUM(maintenance_cost_inr), 2) AS total_maintenance_cost,
    ROUND(AVG(maintenance_cost_inr), 2) AS average_maintenance_cost
FROM maintenance_records
GROUP BY
    maintenance_type
ORDER BY
    total_downtime_hours DESC;
    
    
-- -- Advanced SQL 21: Cash Inventory Performance
-- What: Compare ATM cash-inventory activity and utilization.
-- Why: To understand cash usage patterns across ATMs.

SELECT
    a.atm_id,
    a.city,
    a.state,
    COUNT(i.date) AS inventory_days,
    ROUND(AVG(i.opening_cash_balance), 2) AS avg_opening_cash,
    ROUND(SUM(i.cash_dispensed), 2) AS total_cash_dispensed,
    ROUND(SUM(i.cash_deposited), 2) AS total_cash_deposited,
    ROUND(AVG(i.closing_cash_balance), 2) AS avg_closing_cash,
    ROUND(AVG(i.utilization_pct), 2) AS avg_cash_utilization_pct
FROM atm_locations a
LEFT JOIN cash_inventory_daily i
    ON a.atm_id = i.atm_id
GROUP BY
    a.atm_id,
    a.city,
    a.state
ORDER BY
    avg_cash_utilization_pct DESC
LIMIT 10;



-- Advanced SQL 22: Low-Cash and Cash-Out ATM Analysis
-- What: Check low-cash and cash-out flags by ATM.
-- Why: To identify ATMs with potential cash-availability issues.

SELECT
    a.atm_id,
    a.city,
    a.state,
    COUNT(i.date) AS inventory_days,
    SUM(i.low_cash_flag = 'Yes') AS low_cash_days,
    SUM(i.cash_out_flag = 'Yes') AS cash_out_days,
    ROUND(
        SUM(i.low_cash_flag = 'Yes') * 100.0 / COUNT(i.date),
        2
    ) AS low_cash_rate_pct,
    ROUND(
        SUM(i.cash_out_flag = 'Yes') * 100.0 / COUNT(i.date),
        2
    ) AS cash_out_rate_pct
FROM atm_locations a
LEFT JOIN cash_inventory_daily i
    ON a.atm_id = i.atm_id
GROUP BY
    a.atm_id,
    a.city,
    a.state
ORDER BY
    low_cash_rate_pct DESC,
    cash_out_rate_pct DESC
LIMIT 10;



-- Advanced SQL 23: Replenishment Performance
-- What: Summarise replenishment activity by ATM.
-- Why: To compare replenishment frequency and amounts.

SELECT
    a.atm_id,
    a.city,
    a.state,
    COUNT(r.replenishment_id) AS replenishment_count,
    ROUND(SUM(r.replenishment_amount_inr), 2) AS total_replenishment_amount,
    ROUND(AVG(r.replenishment_amount_inr), 2) AS average_replenishment_amount,
    ROUND(AVG(r.delivery_duration_hours), 2) AS average_delivery_duration_hours
FROM atm_locations a
LEFT JOIN cash_replenishments r
    ON a.atm_id = r.atm_id
GROUP BY
    a.atm_id,
    a.city,
    a.state
ORDER BY
    total_replenishment_amount DESC
LIMIT 10;


-- Advanced SQL 24: Replenishment Delivery Performance
-- What: Compare replenishment counts, amounts and delivery duration by status.
-- Why: To understand completed versus delayed replenishment performance.

SELECT
    status,
    COUNT(*) AS replenishment_count,
    ROUND(SUM(replenishment_amount_inr), 2) AS total_replenishment_amount,
    ROUND(AVG(replenishment_amount_inr), 2) AS average_replenishment_amount,
    ROUND(AVG(delivery_duration_hours), 2) AS average_delivery_duration_hours
FROM cash_replenishments
GROUP BY
    status
ORDER BY
    replenishment_count DESC;
    
    
    
    -- Advanced SQL 25: Replenishment Reason Analysis
-- What: Compare replenishment activity by reason.
-- Why: To understand scheduled, low-cash-triggered and emergency replenishments.

SELECT
    reason,
    COUNT(*) AS replenishment_count,
    ROUND(SUM(replenishment_amount_inr), 2) AS total_replenishment_amount,
    ROUND(AVG(replenishment_amount_inr), 2) AS average_replenishment_amount,
    ROUND(AVG(delivery_duration_hours), 2) AS average_delivery_duration_hours
FROM cash_replenishments
GROUP BY
    reason
ORDER BY
    replenishment_count DESC;
    
    
    
-- Advanced SQL 26: ATM Operational Risk Score
-- What: Combine transaction failure, maintenance and cash-risk indicators into a simple score.
-- Why: To compare ATMs using several operational indicators.

WITH transaction_metrics AS (
    SELECT
        atm_id,
        COUNT(*) AS total_transactions,
        ROUND(
            SUM(status = 'Failed') * 100.0 / COUNT(*),
            2
        ) AS failure_rate_pct
    FROM transactions
    GROUP BY atm_id
),

maintenance_metrics AS (
    SELECT
        atm_id,
        COUNT(*) AS maintenance_incidents,
        ROUND(SUM(downtime_hours), 2) AS total_downtime_hours
    FROM maintenance_records
    GROUP BY atm_id
),

inventory_metrics AS (
    SELECT
        atm_id,
        SUM(low_cash_flag = 'Yes') AS low_cash_days,
        SUM(cash_out_flag = 'Yes') AS cash_out_days
    FROM cash_inventory_daily
    GROUP BY atm_id
)

SELECT
    a.atm_id,
    a.city,
    a.state,

    COALESCE(t.total_transactions, 0) AS total_transactions,
    COALESCE(t.failure_rate_pct, 0) AS failure_rate_pct,

    COALESCE(m.maintenance_incidents, 0) AS maintenance_incidents,
    COALESCE(m.total_downtime_hours, 0) AS total_downtime_hours,

    COALESCE(i.low_cash_days, 0) AS low_cash_days,
    COALESCE(i.cash_out_days, 0) AS cash_out_days,

    ROUND(
        (COALESCE(t.failure_rate_pct, 0) * 0.30) +
        (COALESCE(m.maintenance_incidents, 0) * 0.20) +
        (COALESCE(m.total_downtime_hours, 0) * 0.30) +
        (COALESCE(i.low_cash_days, 0) * 0.10) +
        (COALESCE(i.cash_out_days, 0) * 0.10),
        2
    ) AS operational_risk_score

FROM atm_locations a

LEFT JOIN transaction_metrics t
    ON a.atm_id = t.atm_id

LEFT JOIN maintenance_metrics m
    ON a.atm_id = m.atm_id

LEFT JOIN inventory_metrics i
    ON a.atm_id = i.atm_id

ORDER BY
    operational_risk_score DESC

LIMIT 10;