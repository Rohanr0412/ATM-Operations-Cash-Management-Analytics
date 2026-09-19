/*
ATM Operations & Cash Management Analytics
FILE 1 - DATABASE SETUP & DATA IMPORT

Purpose:
- Create the MySQL database and project tables.
- Define primary and foreign-key relationships.
- Prepare table structures for the CSV dataset.
- Import the project data into MySQL.
- Check table structures and imported row counts.

Note:
This file contains the actual setup/import work done during the project.
Some ALTER/TRUNCATE/import commands are retained because they document the
table adjustments made while matching the CSV structure.
*/

CREATE DATABASE atm_business_analytics;

USE atm_business_analytics;


CREATE TABLE bank_branches (
    branch_id VARCHAR(20) PRIMARY KEY,
    branch_name VARCHAR(150),
    state VARCHAR(50),
    city VARCHAR(50),
    region VARCHAR(50),
    branch_type VARCHAR(50),
    opening_year INT
);

CREATE TABLE customers (
    customer_id VARCHAR(20) PRIMARY KEY,
    state VARCHAR(50),
    city VARCHAR(50),
    region VARCHAR(50),
    age INT,
    customer_segment VARCHAR(50),
    account_type VARCHAR(50),
    account_open_date DATE,
    preferred_channel VARCHAR(50)
);

CREATE TABLE calendar (
    date DATE PRIMARY KEY,
    year INT,
    month INT,
    month_name VARCHAR(20),
    quarter VARCHAR(10),
    day_of_week VARCHAR(20),
    is_weekend BOOLEAN
);

CREATE TABLE holidays_events (
    event_id VARCHAR(20) PRIMARY KEY,
    event_date DATE,
    event_name VARCHAR(150),
    state VARCHAR(50),
    event_scope VARCHAR(50),
    expected_cash_demand_multiplier INT
);

CREATE TABLE atm_locations (
    atm_id VARCHAR(20) PRIMARY KEY,
    branch_id VARCHAR(20),
    atm_type VARCHAR(50),
    location_type VARCHAR(50),
    state VARCHAR(50),
    city VARCHAR(50),
    region VARCHAR(50),
    installation_date DATE,
    status VARCHAR(30),
    FOREIGN KEY (branch_id)
        REFERENCES bank_branches(branch_id)
);

SHOW TABLES;


CREATE TABLE transactions (
    transaction_id VARCHAR(30) PRIMARY KEY,
    atm_id VARCHAR(20),
    customer_id VARCHAR(20),
    transaction_date DATETIME,
    transaction_type VARCHAR(50),
    amount DECIMAL(12,2),
    transaction_status VARCHAR(30),
    FOREIGN KEY (atm_id)
        REFERENCES atm_locations(atm_id),
    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);

DESCRIBE transactions;

CREATE TABLE cash_inventory_daily (
    inventory_id VARCHAR(30) PRIMARY KEY,
    atm_id VARCHAR(20),
    inventory_date DATE,
    opening_cash DECIMAL(14,2),
    cash_dispensed DECIMAL(14,2),
    cash_replenished DECIMAL(14,2),
    closing_cash DECIMAL(14,2),
    FOREIGN KEY (atm_id)
        REFERENCES atm_locations(atm_id)
);

DESCRIBE cash_inventory_daily;

CREATE TABLE cash_replenishments (
    replenishment_id VARCHAR(30) PRIMARY KEY,
    atm_id VARCHAR(20),
    replenishment_date DATETIME,
    amount_added DECIMAL(14,2),
    replenishment_type VARCHAR(50),
    performed_by VARCHAR(100),
    FOREIGN KEY (atm_id)
        REFERENCES atm_locations(atm_id)
);

CREATE TABLE maintenance_records (
    maintenance_id VARCHAR(30) PRIMARY KEY,
    atm_id VARCHAR(20),
    maintenance_date DATETIME,
    maintenance_type VARCHAR(50),
    issue_description VARCHAR(255),
    downtime_hours DECIMAL(8,2),
    maintenance_cost DECIMAL(12,2),
    resolution_status VARCHAR(30),
    FOREIGN KEY (atm_id)
        REFERENCES atm_locations(atm_id)
);

SELECT COUNT(*) AS total_rows
FROM bank_branches;

SELECT COUNT(*) AS total_rows
FROM calendar;


USE atm_business_analytics;

ALTER TABLE calendar
MODIFY COLUMN is_weekend VARCHAR(5);

USE atm_business_analytics;

ALTER TABLE atm_locations
ADD COLUMN ownership VARCHAR(50) AFTER location_type,
ADD COLUMN is_24x7 BOOLEAN AFTER ownership,
ADD COLUMN age_years DECIMAL(5,2) AFTER region;

USE atm_business_analytics;

ALTER TABLE atm_locations
DROP COLUMN age_years;

ALTER TABLE atm_locations
ADD COLUMN age_years_as_of_2025 DECIMAL(5,2) AFTER region,
ADD COLUMN monthly_rent_inr DECIMAL(12,2) AFTER age_years_as_of_2025;

USE atm_business_analytics;

DESCRIBE atm_locations;

USE atm_business_analytics;

ALTER TABLE atm_locations
DROP COLUMN atm_type,
DROP COLUMN age_years,
DROP COLUMN status;


ALTER TABLE atm_locations
MODIFY COLUMN is_24x7 VARCHAR(5);

SELECT COUNT(*) AS total_rows
FROM atm_locations;

SELECT COUNT(*) AS invalid_branch_ids
FROM atm_locations a
LEFT JOIN bank_branches b
    ON a.branch_id = b.branch_id
WHERE b.branch_id IS NULL;

DESCRIBE transactions;

USE atm_business_analytics;

ALTER TABLE transactions
DROP COLUMN transaction_date,
DROP COLUMN amount,
DROP COLUMN transaction_status;



ALTER TABLE transactions
ADD COLUMN transaction_datetime DATETIME AFTER transaction_id,
ADD COLUMN amount_inr DECIMAL(12,2) AFTER transaction_type,
ADD COLUMN channel VARCHAR(50) AFTER amount_inr,
ADD COLUMN status VARCHAR(30) AFTER channel,
ADD COLUMN card_type VARCHAR(50) AFTER status,
ADD COLUMN response_time_seconds DECIMAL(8,2) AFTER card_type,
ADD COLUMN is_peak_hour VARCHAR(5) AFTER response_time_seconds;



USE atm_business_analytics;

SELECT COUNT(*) AS rows_imported
FROM transactions;

select * from transactions;


DESCRIBE cash_inventory_daily;

USE atm_business_analytics;

DROP TABLE cash_inventory_daily;

CREATE TABLE cash_inventory_daily (
    atm_id VARCHAR(20),
    date DATE,
    opening_cash_balance DECIMAL(14,2),
    cash_dispensed DECIMAL(14,2),
    cash_deposited DECIMAL(14,2),
    closing_cash_balance DECIMAL(14,2),
    utilization_pct DECIMAL(8,2),
    low_cash_flag VARCHAR(5),
    cash_out_flag VARCHAR(5),
    FOREIGN KEY (atm_id)
        REFERENCES atm_locations(atm_id)
);

SELECT COUNT(*) AS rows_imported
FROM cash_inventory_daily;

USE atm_business_analytics;

SELECT COUNT(*) AS current_rows
FROM cash_replenishments;

ALTER TABLE cash_replenishments
CHANGE COLUMN amount_added replenishment_amount_inr DECIMAL(14,2),
CHANGE COLUMN replenishment_type source VARCHAR(50),
CHANGE COLUMN performed_by reason VARCHAR(100),
ADD COLUMN status VARCHAR(30),
ADD COLUMN delivery_duration_hours DECIMAL(8,2);

USE atm_business_analytics;

DESCRIBE cash_replenishments;

USE atm_business_analytics;

SELECT COUNT(*) AS current_rows
FROM cash_replenishments;

SHOW VARIABLES LIKE 'local_infile';


USE atm_business_analytics;

LOAD DATA LOCAL INFILE 'C:/Users/Sej16/Downloads/india_atm_business_analytics_dataset/cash_replenishments.csv'
INTO TABLE cash_replenishments
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    atm_id,
    replenishment_date,
    replenishment_id,
    replenishment_amount_inr,
    source,
    reason,
    status,
    delivery_duration_hours
    
    
);

USE atm_business_analytics;

SELECT COUNT(*) AS transactions_rows
FROM transactions;

SELECT COUNT(*) AS inventory_rows
FROM cash_inventory_daily;

SELECT transaction_id, transaction_datetime
FROM transactions
ORDER BY transaction_datetime DESC
LIMIT 5;

USE atm_business_analytics;

TRUNCATE TABLE transactions;

SELECT COUNT(*) AS transactions_rows
FROM transactions;

USE atm_business_analytics;

LOAD DATA LOCAL INFILE 'C:/Users/Sej16/Downloads/india_atm_business_analytics_dataset/transactions.csv'
INTO TABLE transactions
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    transaction_id,
    transaction_datetime,
    customer_id,
    atm_id,
    transaction_type,
    amount_inr,
    channel,
    status,
    card_type,
    response_time_seconds,
    is_peak_hour
);

USE atm_business_analytics;

TRUNCATE TABLE cash_inventory_daily;


LOAD DATA LOCAL INFILE 'C:/Users/Sej16/Downloads/india_atm_business_analytics_dataset/cash_inventory_daily.csv'
INTO TABLE cash_inventory_daily
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    inventory_id,
    atm_id,
    inventory_date,
    opening_cash,
    cash_dispensed,
    cash_replenished,
    closing_cash
);

USE atm_business_analytics;

DESCRIBE cash_inventory_daily;

LOAD DATA LOCAL INFILE 'C:/Users/Sej16/Downloads/india_atm_business_analytics_dataset/cash_inventory_daily.csv'
INTO TABLE cash_inventory_daily
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    atm_id,
    date,
    opening_cash_balance,
    cash_dispensed,
    cash_deposited,
    closing_cash_balance,
    utilization_pct,
    low_cash_flag,
    cash_out_flag
);

USE atm_business_analytics;

SELECT COUNT(*) AS maintenance_rows
FROM maintenance_records;

USE atm_business_analytics;

DESCRIBE maintenance_records;

USE atm_business_analytics;

LOAD DATA LOCAL INFILE 'C:/Users/Sej16/Downloads/india_atm_business_analytics_dataset/maintenance_records.csv'
INTO TABLE maintenance_records
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    maintenance_id,
    atm_id,
    maintenance_date,
    maintenance_type,
    issue_description,
    downtime_hours,
    maintenance_cost,
    resolution_status
);

USE atm_business_analytics;

TRUNCATE TABLE maintenance_records;

LOAD DATA LOCAL INFILE 'C:/Users/Sej16/Downloads/india_atm_business_analytics_dataset/maintenance_records.csv'
INTO TABLE maintenance_records
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    maintenance_id,
    atm_id,
    maintenance_date,
    maintenance_type,
    severity,
    downtime_hours,
    resolution_status,
    service_provider_type,
    maintenance_cost_inr
);

ALTER TABLE maintenance_records
    DROP COLUMN issue_description,
    CHANGE COLUMN maintenance_cost maintenance_cost_inr DECIMAL(12,2),
    ADD COLUMN severity VARCHAR(30) AFTER maintenance_type,
    ADD COLUMN service_provider_type VARCHAR(50) AFTER resolution_status;
    
    DESCRIBE maintenance_records;
    
    LOAD DATA LOCAL INFILE 'C:/Users/Sej16/Downloads/india_atm_business_analytics_dataset/maintenance_records.csv'
INTO TABLE maintenance_records
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    maintenance_id,
    atm_id,
    maintenance_date,
    maintenance_type,
    severity,
    downtime_hours,
    resolution_status,
    service_provider_type,
    maintenance_cost_inr
);

USE atm_business_analytics;

SELECT 'bank_branches' AS table_name, COUNT(*) AS row_count FROM bank_branches
UNION ALL
SELECT 'customers', COUNT(*) FROM customers
UNION ALL
SELECT 'calendar', COUNT(*) FROM calendar
UNION ALL
SELECT 'holidays_events', COUNT(*) FROM holidays_events
UNION ALL
SELECT 'atm_locations', COUNT(*) FROM atm_locations
UNION ALL
SELECT 'transactions', COUNT(*) FROM transactions
UNION ALL
SELECT 'cash_inventory_daily', COUNT(*) FROM cash_inventory_daily
UNION ALL
SELECT 'cash_replenishments', COUNT(*) FROM cash_replenishments
UNION ALL
SELECT 'maintenance_records', COUNT(*) FROM maintenance_records;


DESCRIBE atm_locations;
DESCRIBE customers;