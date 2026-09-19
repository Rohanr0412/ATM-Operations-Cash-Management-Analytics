/*
ATM Operations & Cash Management Analytics
FILE 2 - DATA QUALITY & VALIDATION

Purpose:
- Check duplicate records.
- Check missing values.
- Validate table relationships.
- Check unusual transaction values and response times.
- Review transaction status, type and channel distributions.
- Check a customer-category consistency rule.

The checks in this file were completed before the main business analysis.
*/

USE atm_business_analytics;

SELECT transaction_id, COUNT(*) AS duplicate_count
FROM transactions
GROUP BY transaction_id
HAVING COUNT(*) > 1
LIMIT 20;

SELECT customer_id, COUNT(*) AS duplicate_count
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1
LIMIT 20;

SELECT atm_id, COUNT(*) AS duplicate_count
FROM atm_locations
GROUP BY atm_id
HAVING COUNT(*) > 1
LIMIT 20;

SELECT replenishment_id, COUNT(*) AS duplicate_count
FROM cash_replenishments
GROUP BY replenishment_id
HAVING COUNT(*) > 1
LIMIT 20;

SELECT maintenance_id, COUNT(*) AS duplicate_count
FROM maintenance_records
GROUP BY maintenance_id
HAVING COUNT(*) > 1
LIMIT 20;

SELECT
    SUM(transaction_id IS NULL) AS missing_transaction_id,
    SUM(transaction_datetime IS NULL) AS missing_datetime,
    SUM(customer_id IS NULL) AS missing_customer_id,
    SUM(atm_id IS NULL) AS missing_atm_id,
    SUM(transaction_type IS NULL) AS missing_transaction_type,
    SUM(amount_inr IS NULL) AS missing_amount,
    SUM(channel IS NULL) AS missing_channel,
    SUM(status IS NULL) AS missing_status
FROM transactions;

SELECT
    SUM(atm_id IS NULL) AS missing_atm_id,
    SUM(branch_id IS NULL) AS missing_branch_id,
    SUM(location_type IS NULL) AS missing_location_type,
    SUM(ownership IS NULL) AS missing_ownership,
    SUM(is_24x7 IS NULL) AS missing_24x7,
    SUM(state IS NULL) AS missing_state,
    SUM(city IS NULL) AS missing_city,
    SUM(region IS NULL) AS missing_region,
    SUM(age_years_as_of_2025 IS NULL) AS missing_age,
    SUM(monthly_rent_inr IS NULL) AS missing_rent,
    SUM(installation_date IS NULL) AS missing_installation_date
FROM atm_locations;


SELECT
    SUM(customer_id IS NULL) AS missing_customer_id,
    SUM(state IS NULL) AS missing_state,
    SUM(city IS NULL) AS missing_city,
    SUM(region IS NULL) AS missing_region,
    SUM(age IS NULL) AS missing_age,
    SUM(customer_segment IS NULL) AS missing_customer_segment,
    SUM(account_type IS NULL) AS missing_account_type,
    SUM(account_open_date IS NULL) AS missing_account_open_date,
    SUM(preferred_channel IS NULL) AS missing_preferred_channel
FROM customers;

SELECT
    SUM(maintenance_id IS NULL) AS missing_maintenance_id,
    SUM(atm_id IS NULL) AS missing_atm_id,
    SUM(maintenance_date IS NULL) AS missing_maintenance_date,
    SUM(maintenance_type IS NULL) AS missing_maintenance_type,
    SUM(severity IS NULL) AS missing_severity,
    SUM(downtime_hours IS NULL) AS missing_downtime,
    SUM(resolution_status IS NULL) AS missing_resolution_status,
    SUM(service_provider_type IS NULL) AS missing_service_provider,
    SUM(maintenance_cost_inr IS NULL) AS missing_cost
FROM maintenance_records;


SELECT
    SUM(atm_id IS NULL) AS missing_atm_id,
    SUM(date IS NULL) AS missing_date,
    SUM(opening_cash_balance IS NULL) AS missing_opening_balance,
    SUM(cash_dispensed IS NULL) AS missing_cash_dispensed,
    SUM(cash_deposited IS NULL) AS missing_cash_deposited,
    SUM(closing_cash_balance IS NULL) AS missing_closing_balance,
    SUM(utilization_pct IS NULL) AS missing_utilization,
    SUM(low_cash_flag IS NULL) AS missing_low_cash_flag,
    SUM(cash_out_flag IS NULL) AS missing_cash_out_flag
FROM cash_inventory_daily;

SELECT COUNT(*) AS invalid_atm_references
FROM transactions t
LEFT JOIN atm_locations a
    ON t.atm_id = a.atm_id
WHERE a.atm_id IS NULL;

SELECT COUNT(*) AS invalid_customer_references
FROM transactions t
LEFT JOIN customers c
    ON t.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

SELECT COUNT(*) AS invalid_branch_references
FROM atm_locations a
LEFT JOIN bank_branches b
    ON a.branch_id = b.branch_id
WHERE b.branch_id IS NULL;

SELECT COUNT(*) AS invalid_atm_references
FROM cash_inventory_daily ci
LEFT JOIN atm_locations a
    ON ci.atm_id = a.atm_id
WHERE a.atm_id IS NULL;

SELECT COUNT(*) AS invalid_atm_references
FROM maintenance_records m
LEFT JOIN atm_locations a
    ON m.atm_id = a.atm_id
WHERE a.atm_id IS NULL;


SELECT COUNT(*) AS invalid_atm_references
FROM cash_replenishments cr
LEFT JOIN atm_locations a
    ON cr.atm_id = a.atm_id
WHERE a.atm_id IS NULL;


SELECT COUNT(*) AS invalid_transaction_amounts
FROM transactions
WHERE amount_inr <= 0;

SELECT
    status,
    transaction_type,
    COUNT(*) AS transaction_count
FROM transactions
WHERE amount_inr <= 0
GROUP BY status, transaction_type
ORDER BY transaction_count DESC;

SELECT COUNT(*) AS negative_transaction_amounts
FROM transactions
WHERE amount_inr < 0;

SELECT COUNT(*) AS invalid_response_times
FROM transactions
WHERE response_time_seconds < 0;

SELECT
    status,
    COUNT(*) AS transaction_count
FROM transactions
GROUP BY status
ORDER BY transaction_count DESC;


SELECT
    transaction_type,
    COUNT(*) AS transaction_count
FROM transactions
GROUP BY transaction_type
ORDER BY transaction_count DESC;

SELECT
    channel,
    COUNT(*) AS transaction_count
FROM transactions
GROUP BY channel
ORDER BY transaction_count DESC;


SELECT
    channel,
    transaction_type,
    COUNT(*) AS transaction_count
FROM transactions
GROUP BY channel, transaction_type
ORDER BY channel, transaction_count DESC;


SELECT
    account_type,
    COUNT(*) AS inconsistent_customers
FROM customers
WHERE account_type = 'Senior Citizen'
  AND age < 60
GROUP BY account_type;