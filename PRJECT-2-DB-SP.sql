CREATE DATABASE DB1;
CREATE DATABASE DB2;
CREATE DATABASE DB3;
CREATE DATABASE DB4;
CREATE DATABASE FINAL_DB;


-- DB1 -- 
USE DB1;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(100),
    created_at DATETIME,
    updated_at DATETIME
);

CREATE TABLE orders_data (
    order_id INT PRIMARY KEY,
    customer_id INT,
    amount DECIMAL(10,2),
    created_at DATETIME,
    updated_at DATETIME
);

INSERT INTO customers VALUES
(1,'Aman','Delhi','2026-04-01','2026-04-10'),
(2,'Riya','Mumbai','2026-04-02','2026-04-12');

INSERT INTO orders_data VALUES
(101,1,1200.50,'2026-04-03','2026-04-11'),
(102,2,950.00,'2026-04-04','2026-04-13');


-- DB 2 -- 
USE DB2;

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100),
    department VARCHAR(50),
    created_at DATETIME,
    updated_at DATETIME
);

CREATE TABLE payroll (
    payroll_id INT PRIMARY KEY,
    emp_id INT,
    salary DECIMAL(10,2),
    created_at DATETIME,
    updated_at DATETIME
);

INSERT INTO employees VALUES
(1,'Rahul','IT','2026-04-01','2026-04-10'),
(2,'Sneha','HR','2026-04-02','2026-04-12');

INSERT INTO payroll VALUES
(201,1,70000,'2026-04-03','2026-04-11'),
(202,2,65000,'2026-04-04','2026-04-13');


-- DB3 -- 
USE DB3;

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    created_at DATETIME,
    updated_at DATETIME
);

CREATE TABLE inventory (
    inventory_id INT PRIMARY KEY,
    product_id INT,
    quantity INT,
    created_at DATETIME,
    updated_at DATETIME
);

INSERT INTO products VALUES
(1,'Laptop','Electronics','2026-04-01','2026-04-10'),
(2,'Phone','Electronics','2026-04-02','2026-04-12');

INSERT INTO inventory VALUES
(301,1,50,'2026-04-03','2026-04-11'),
(302,2,120,'2026-04-04','2026-04-13');



-- DB4 -- 

USE DB4;

CREATE TABLE accounts (
    account_id INT PRIMARY KEY,
    account_name VARCHAR(100),
    balance DECIMAL(12,2),
    created_at DATETIME,
    updated_at DATETIME
);

CREATE TABLE transactions_data (
    txn_id INT PRIMARY KEY,
    account_id INT,
    amount DECIMAL(10,2),
    created_at DATETIME,
    updated_at DATETIME
);

INSERT INTO accounts VALUES
(1,'Operations',500000,'2026-04-01','2026-04-10'),
(2,'Marketing',300000,'2026-04-02','2026-04-12');

INSERT INTO transactions_data VALUES
(401,1,15000,'2026-04-03','2026-04-11'),
(402,2,20000,'2026-04-04','2026-04-13');






-- FINAL_DB -- 

drop database FINAL_DB;

create database FINAL_DB;

create schema final_schema;
create schema stg_schema;

USE FINAL_DB;


CREATE TABLE final_schema.customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(100),
    created_at DATETIME,
    updated_at DATETIME
);

CREATE TABLE final_schema.orders_data (
    order_id INT PRIMARY KEY,
    customer_id INT,
    amount DECIMAL(10,2),
    created_at DATETIME,
    updated_at DATETIME
);

CREATE TABLE final_schema.employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100),
    department VARCHAR(50),
    created_at DATETIME,
    updated_at DATETIME
);

CREATE TABLE final_schema.payroll (
    payroll_id INT PRIMARY KEY,
    emp_id INT,
    salary DECIMAL(10,2),
    created_at DATETIME,
    updated_at DATETIME
);


CREATE TABLE final_schema.accounts (
    account_id INT PRIMARY KEY,
    account_name VARCHAR(100),
    balance DECIMAL(12,2),
    created_at DATETIME,
    updated_at DATETIME
);

CREATE TABLE final_schema.transactions_data (
    txn_id INT PRIMARY KEY,
    account_id INT,
    amount DECIMAL(10,2),
    created_at DATETIME,
    updated_at DATETIME
);

CREATE TABLE final_schema.products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    created_at DATETIME,
    updated_at DATETIME
);

CREATE TABLE final_schema.inventory (
    inventory_id INT PRIMARY KEY,
    product_id INT,
    quantity INT,
    created_at DATETIME,
    updated_at DATETIME
);

-------------------------------------------------------stages


CREATE TABLE stg_schema.customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(100),
    created_at DATETIME,
    updated_at DATETIME
);

CREATE TABLE stg_schema.orders_data (
    order_id INT PRIMARY KEY,
    customer_id INT,
    amount DECIMAL(10,2),
    created_at DATETIME,
    updated_at DATETIME
);

CREATE TABLE stg_schema.employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100),
    department VARCHAR(50),
    created_at DATETIME,
    updated_at DATETIME
);

CREATE TABLE stg_schema.payroll (
    payroll_id INT PRIMARY KEY,
    emp_id INT,
    salary DECIMAL(10,2),
    created_at DATETIME,
    updated_at DATETIME
);

CREATE TABLE stg_schema.accounts (
    account_id INT PRIMARY KEY,
    account_name VARCHAR(100),
    balance DECIMAL(12,2),
    created_at DATETIME,
    updated_at DATETIME
);

CREATE TABLE stg_schema.transactions_data (
    txn_id INT PRIMARY KEY,
    account_id INT,
    amount DECIMAL(10,2),
    created_at DATETIME,
    updated_at DATETIME
);

CREATE TABLE stg_schema.products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    created_at DATETIME,
    updated_at DATETIME
);

CREATE TABLE stg_schema.inventory (
    inventory_id INT PRIMARY KEY,
    product_id INT,
    quantity INT,
    created_at DATETIME,
    updated_at DATETIME
);


SELECT 
    schema_name(schema_id) AS schema_name,
    name AS table_name,
    create_date,
    modify_date
FROM sys.tables
ORDER BY schema_name, table_name;   



USE FINAL_DB;
GO

DROP TABLE IF EXISTS final_schema.metadata_config;
GO

CREATE TABLE final_schema.metadata_config
(
    TableName           NVARCHAR(100),
    SourceDB            NVARCHAR(50),
    SourceSchema        NVARCHAR(50),
    SourceTable         NVARCHAR(100),
    TargetSchema        NVARCHAR(50),
    StagingTable        NVARCHAR(100),
    LoadType            NVARCHAR(20),        -- FULL / INCREMENTAL
    WatermarkColumn     NVARCHAR(100),
    DependencyTable     NVARCHAR(100),       -- for reference only
    DependencyOrder     INT,                 -- ACTUAL EXECUTION CONTROL
    StoredProcedureName NVARCHAR(100),       -- dynamic SP call
    IsActive            BIT,
    Scheduled           NVARCHAR(3)          -- YES / NO
);

INSERT INTO final_schema.metadata_config VALUES
-- DependencyOrder 5 → no dependencies, load first
('Customers',         'DB1','dbo','customers',          'stg_schema','customers',          'FULL',        NULL,             NULL,           5,  'SP_MERGE_P1', 1, 'YES'),
('Orders_Data',       'DB1','dbo','orders_data',        'stg_schema','orders_data',       'INCREMENTAL', 'updated_at',     'customers',   10,  'SP_MERGE_P1', 1, 'YES'),
('Employees',         'DB2','dbo','employees',          'stg_schema','employees',     'FULL',        NULL,             NULL,           5,  'SP_MERGE_P2', 1, 'YES'),
('Payroll',           'DB2','dbo','payroll',            'stg_schema','payroll',          'INCREMENTAL', 'updated_at',     'employees',   10,  'SP_MERGE_P2', 1, 'YES'),
('Products',          'DB3','dbo','products',           'stg_schema','products',     'FULL',        NULL,             NULL,           5,  'SP_MERGE_P3', 1, 'YES'),
('Inventory',         'DB3','dbo','inventory',          'stg_schema','inventory',    'INCREMENTAL', 'updated_at',     'products',    10,  'SP_MERGE_P3', 1, 'YES'),
('Accounts',          'DB4','dbo','accounts',           'stg_schema','accounts',     'FULL',        NULL,             NULL,           5,  'SP_MERGE_P4', 1, 'YES'),
('Transactions_Data', 'DB4','dbo','transactions_data',  'stg_schema','transactions_data',   'INCREMENTAL', 'updated_at',     'accounts',    10,  'SP_MERGE_P4', 1, 'NO');

SELECT * FROM final_schema.metadata_config;

select * from final_schema.metadata_config


CREATE TABLE final_schema.watermark_control (
    target_table NVARCHAR(100) PRIMARY KEY,
    last_watermark_value DATETIME NULL,
    last_run_status NVARCHAR(50),
    last_run_time DATETIME,
    is_active BIT
);


INSERT INTO final_schema.watermark_control VALUES
('customers', NULL, NULL, NULL, 1),
('orders_data', '2026-04-01', NULL, NULL, 1),
('employees', NULL, NULL, NULL, 1),
('payroll', '2026-04-01', NULL, NULL, 1),
('products', NULL, NULL, NULL, 1),
('inventory', '2026-04-01', NULL, NULL, 1),
('accounts', NULL, NULL, NULL, 1),
('transactions_data', '2026-04-01', NULL, NULL, 1);

select * from final_schema.watermark_control;





drop procedure if exists final_schema.usp_UpdateWatermark;


CREATE OR ALTER PROCEDURE final_schema.usp_UpdateWatermark
    @TargetTable NVARCHAR(100),
    @LoadType NVARCHAR(20),
    @NewWatermark DATETIME = NULL
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE final_schema.watermark_control
    SET
        last_watermark_value = 
            CASE 
                WHEN @LoadType = 'INCREMENTAL' THEN @NewWatermark
                ELSE last_watermark_value
            END,
        last_run_status = 'SUCCESS',
        last_run_time = GETDATE()
    WHERE target_table = @TargetTable;
END;
GO

------------------------------------------------------------------------ WATERMARK UPDATE  + GENERIC_SP 

select * from final_schema.metadata_config;

UPDATE final_schema.metadata_config
SET TargetSchema = 'final_schema';

-- Add staging schema column to metadata_config
ALTER TABLE final_schema.metadata_config
ADD StagingSchema NVARCHAR(50);
GO

-- Populate staging schema for all rows
UPDATE final_schema.metadata_config
SET StagingSchema = 'stg_schema';
GO


ALTER TABLE final_schema.metadata_config
ADD ProcessName NVARCHAR(100),
    PipelineName NVARCHAR(100),
    ProcessOrder INT,
    RunMode NVARCHAR(50);
GO

UPDATE final_schema.metadata_config
SET ProcessName = 'DB1_Process',
    PipelineName = 'DB_1_PIPE',
    ProcessOrder = 1,
    RunMode = 'BOTH'
WHERE SourceTable IN ('customers', 'orders_data');
GO

-- DB2 group
UPDATE final_schema.metadata_config
SET ProcessName = 'DB2_Process',
    PipelineName = 'DB_2_PIPE',
    ProcessOrder = 2,
    RunMode = 'BOTH'
WHERE SourceTable IN ('employees', 'inventory');
GO

-- DB3 group
UPDATE final_schema.metadata_config
SET ProcessName = 'DB3_Process',
    PipelineName = 'DB_3_PIPE',
    ProcessOrder = 3,
    RunMode = 'BOTH'
WHERE SourceTable IN ('products', 'payroll');
GO

-- DB4 group
UPDATE final_schema.metadata_config
SET ProcessName = 'DB4_Process',
    PipelineName = 'DB_4_PIPE',
    ProcessOrder = 4,
    RunMode = 'BOTH'
WHERE SourceTable IN ('accounts', 'transactions_data');
GO


alter table final_schema.metadata_config 
add PrimaryKeyColumn NVARCHAR(100);

UPDATE final_schema.metadata_config
SET PrimaryKeyColumn = 
    CASE 
        WHEN SourceTable = 'customers' THEN 'customer_id'
        WHEN SourceTable = 'orders_data' THEN 'order_id'
        WHEN SourceTable = 'employees' THEN 'emp_id'
        WHEN SourceTable = 'payroll' THEN 'payroll_id'
        WHEN SourceTable = 'products' THEN 'product_id'
        WHEN SourceTable = 'inventory' THEN 'inventory_id'
        WHEN SourceTable = 'accounts' THEN 'account_id'
        WHEN SourceTable = 'transactions_data' THEN 'txn_id'
    END;









-- DB2
UPDATE final_schema.metadata_config
SET PipelineName = 'DB_2_PIPE'
WHERE SourceTable IN ('employees', 'payroll');

-- DB3
UPDATE final_schema.metadata_config
SET PipelineName = 'DB_3_PIPE'
WHERE SourceTable IN ('products', 'inventory');

select * from final_schema.metadata_config;





















CREATE OR ALTER PROCEDURE final_schema.SP_GENERIC_MERGE
    @TargetSchema NVARCHAR(100),
    @TargetTable NVARCHAR(100),
    @StagingSchema NVARCHAR(100),
    @StagingTable NVARCHAR(100),
    @PrimaryKeyColumn NVARCHAR(100),
    @LoadType NVARCHAR(20),
    @WatermarkColumn NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @UpdateCols NVARCHAR(MAX);
    DECLARE @InsertCols NVARCHAR(MAX);
    DECLARE @InsertVals NVARCHAR(MAX);
    DECLARE @SQL NVARCHAR(MAX);
    DECLARE @MaxWatermark DATETIME;

    -- Build dynamic column lists excluding PK from updates
    SELECT
        @UpdateCols = STRING_AGG(
            CASE
                WHEN COLUMN_NAME <> @PrimaryKeyColumn
                THEN 'tgt.' + COLUMN_NAME + ' = src.' + COLUMN_NAME
            END, ', '
        ),
        @InsertCols = STRING_AGG(COLUMN_NAME, ', '),
        @InsertVals = STRING_AGG('src.' + COLUMN_NAME, ', ')
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_SCHEMA = @TargetSchema
      AND TABLE_NAME = @TargetTable;

    -- Dynamic MERGE
    SET @SQL = '
    MERGE ' + @TargetSchema + '.' + @TargetTable + ' AS tgt
    USING ' + @StagingSchema + '.' + @StagingTable + ' AS src
    ON tgt.' + @PrimaryKeyColumn + ' = src.' + @PrimaryKeyColumn + '

    WHEN MATCHED THEN
        UPDATE SET ' + @UpdateCols + '

    WHEN NOT MATCHED BY TARGET THEN
        INSERT (' + @InsertCols + ')
        VALUES (' + @InsertVals + ');';

    EXEC sp_executesql @SQL;

    -- Watermark update
    IF @LoadType = 'INCREMENTAL' AND @WatermarkColumn IS NOT NULL
    BEGIN
        SET @SQL = '
        SELECT @MaxWM = MAX(' + @WatermarkColumn + ')
        FROM ' + @TargetSchema + '.' + @TargetTable;

        EXEC sp_executesql
            @SQL,
            N'@MaxWM DATETIME OUTPUT',
            @MaxWM = @MaxWatermark OUTPUT;

        EXEC final_schema.usp_UpdateWatermark
            @TargetTable = @TargetTable,
            @LoadType = @LoadType,
            @NewWatermark = @MaxWatermark;
    END
    ELSE
    BEGIN
        EXEC final_schema.usp_UpdateWatermark
            @TargetTable = @TargetTable,
            @LoadType = @LoadType,
            @NewWatermark = NULL;
    END
END;
GO



INSERT INTO final_schema.watermark_control VALUES
('MASTER_RUN', NULL, NULL, NULL, 1);
---------------------------------------------------------------------error logs
CREATE TABLE final_schema.master_run_log (
    master_run_id NVARCHAR(100),
    run_status NVARCHAR(50),
    run_mode NVARCHAR(50),
    start_time DATETIME,
    end_time DATETIME,
    total_pipelines INT,
    success_count INT,
    failed_count INT,
    failed_pipelines NVARCHAR(500),
    created_at DATETIME DEFAULT GETDATE()
);


--------------------------------------------------------------------------------------- logging procedure


CREATE OR ALTER PROCEDURE final_schema.SP_LogMasterStatus
    @RunStatus        NVARCHAR(50),
    @MasterRunId      NVARCHAR(100),
    @FailedPipelines  NVARCHAR(500) = NULL,
    @RunMode          NVARCHAR(50) = NULL,
    @StartTime        DATETIME = NULL,
    @EndTime          DATETIME = NULL,
    @TotalPipelines   INT = NULL,
    @SuccessCount     INT = NULL,
    @FailedCount      INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @RunDurationSeconds INT = NULL;

    IF @StartTime IS NOT NULL AND @EndTime IS NOT NULL
    BEGIN
        SET @RunDurationSeconds = DATEDIFF(SECOND, @StartTime, @EndTime);
    END

    UPDATE final_schema.watermark_control
    SET
        last_watermark_value = GETDATE(),

        last_run_status = CONCAT(
            @RunStatus,
            ' | MasterRunId: ', ISNULL(@MasterRunId, ''),
            ' | Mode: ', ISNULL(@RunMode, ''),
            ' | Total: ', ISNULL(CAST(@TotalPipelines AS NVARCHAR), '0'),
            ' | Success: ', ISNULL(CAST(@SuccessCount AS NVARCHAR), '0'),
            ' | Failed: ', ISNULL(CAST(@FailedCount AS NVARCHAR), '0'),
            ' | FailedPipes: ', ISNULL(@FailedPipelines, '')
        ),

        last_run_time = GETDATE()
    WHERE target_table = 'MASTER_RUN';

    IF @@ROWCOUNT = 0
    BEGIN
        INSERT INTO final_schema.watermark_control
        (
            target_table,
            last_watermark_value,
            last_run_status,
            last_run_time,
            is_active
        )
        VALUES
        (
            'MASTER_RUN',
            GETDATE(),
            CONCAT(
                @RunStatus,
                ' | MasterRunId: ', ISNULL(@MasterRunId, ''),
                ' | Mode: ', ISNULL(@RunMode, ''),
                ' | Total: ', ISNULL(CAST(@TotalPipelines AS NVARCHAR), '0'),
                ' | Success: ', ISNULL(CAST(@SuccessCount AS NVARCHAR), '0'),
                ' | Failed: ', ISNULL(CAST(@FailedCount AS NVARCHAR), '0'),
                ' | FailedPipes: ', ISNULL(@FailedPipelines, '')
            ),
            GETDATE(),
            1
        );
    END
    INSERT INTO final_schema.master_run_log
    (
        master_run_id,
        run_status,
        run_mode,
        start_time,
        end_time,
        total_pipelines,
        success_count,
        failed_count,
        failed_pipelines
    )
    VALUES
    (
        @MasterRunId,
        @RunStatus,
        @RunMode,
        @StartTime,
        @EndTime,
        @TotalPipelines,
        @SuccessCount,
        @FailedCount,
        @FailedPipelines
    );
END;
GO

DROP TABLE IF EXISTS final_schema.Schedule_codes;

create table final_schema.Schedule_codes(
    ScheduleCode NVARCHAR(50) ,
    is_active BIT,
    belong_DB NVARCHAR(50)
);

insert into final_schema.Schedule_codes values
('SC01', 1,'DB1'),
('SC01', 1, 'DB1'),
('SC02', 1,'DB2'),
('SC02', 1, 'DB2'),
('SC03', 1,'DB3'),
('SC03', 1, 'DB3'),
('SC04', 1,'DB4'),
('SC04', 1, 'DB4');


select * from final_schema.Schedule_codes;


ALTER TABLE final_schema.watermark_control
ALTER COLUMN last_run_status NVARCHAR(1000);




alter table final_schema.metadata_config 
add ScheduleCode NVARCHAR(50);

UPDATE final_schema.metadata_config
SET ScheduleCode = CASE 
    WHEN SourceDB = 'DB1' THEN 'SC01'
    WHEN SourceDB = 'DB2' THEN 'SC02'
    WHEN SourceDB = 'DB3' THEN 'SC03'
    WHEN SourceDB = 'DB4' THEN 'SC04'
    ELSE ScheduleCode -- retain current value if no match
END;   


TRUNCATE TABLE final_schema.Schedule_codes;

INSERT INTO final_schema.Schedule_codes VALUES
('SC01', 1,'DB1'),
('SC02', 1,'DB2'),
('SC03', 1,'DB3'),
('SC04', 1,'DB4');


select * from final_schema.metadata_config;
select * from final_schema.master_run_log;
select * from final_schema.watermark_control;
select * from final_schema.Schedule_codes;




select * from final_schema.customers;

select * from final_schema.Schedule_codes;
select * from final_schema.metadata_config;
