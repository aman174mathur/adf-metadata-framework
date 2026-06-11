# 🚀 Enterprise Metadata-Driven ETL & Data Warehouse Framework

## 📌 Overview

This project implements a scalable and reusable **Metadata-Driven ETL Framework** in Azure Data Factory (ADF).

A scalable, metadata-driven ETL framework built using Azure Data Factory and SQL Server that automates data ingestion, supports full and incremental loading, and enables onboarding of new tables without pipeline code changes.

The framework supports:

- Full Loads
- Incremental Loads
- Watermark Tracking
- Dynamic Source Selection
- Multi-Database Ingestion
- Generic Merge Processing
- Dependency-Based Execution

---

# 🏗️ Architecture

## High-Level Flow
```text
                    ┌───────────────────┐
                    │ Metadata_Config   │
                    └─────────┬─────────┘
                              │
                              ▼
                    ┌───────────────────┐
                    │ Master Pipeline   │
                    └─────────┬─────────┘
                              │
                              ▼
                    ┌───────────────────┐
                    │ Metadata Lookup   │
                    └─────────┬─────────┘
                              │
                              ▼
                    ┌───────────────────┐
                    │ ForEach Activity  │
                    └─────────┬─────────┘
                              │
                              ▼
                    ┌───────────────────┐
                    │ Switch Activity   │
                    └─────────┬─────────┘
                              │
        ┌─────────────────────┼─────────────────────┐
        ▼                     ▼                     ▼
   DB_1_PIPE            DB_2_PIPE             DB_3_PIPE
        │                     │                     │
        ▼                     ▼                     ▼
                      Source Databases
                  (DB1, DB2, DB3, DB4 ...)
                              │
                              ▼
                    ┌───────────────────┐
                    │ Staging Layer     │
                    │ (stg_schema)      │
                    └─────────┬─────────┘
                              │
                              ▼
                    ┌───────────────────┐
                    │ Generic MERGE SP  │
                    └─────────┬─────────┘
                              │
                              ▼
                    ┌───────────────────┐
                    │ Data Warehouse    │
                    │ (final_schema)    │
                    └───────────────────┘
```
---

# 📷 Architecture Diagram

> <img width="1913" height="912" alt="Screenshot 2026-06-11 111121-copy" src="https://github.com/user-attachments/assets/2164d6d6-7151-4dcc-b530-da3f6a44fbb4" />

---

# ✨ Key Features

## 1. Metadata-Driven Processing

🔹 Metadata-Driven Processing

All ETL logic is controlled through metadata tables.

The framework dynamically determines:

Source database
Source table
Target table
Load type
Watermark column
Execution order
Pipeline routing

This eliminates hardcoded table-specific logic.

---
## 2. Multi-Source Data Ingestion

Supports ingestion from multiple source systems:

DB1, DB2, DB3, DB4

Each source database can contain multiple tables and schemas.


## 3. Dynamic Pipeline Routing

The Master Pipeline routes execution based on configurable Schedule Codes.

| Schedule Code | Pipeline  |
| ------------- | --------- |
| SC01          | DB_1_PIPE |
| SC02          | DB_2_PIPE |
| SC03          | DB_3_PIPE |
| SC04          | DB_4_PIPE |


---

## 4. Full Load Processing

For FULL loads:

1. Read source table
2. Truncate staging table
3. Load latest data
4. Merge into target

---

## 5. Incremental Load Processing

For Incremental loads:

Read last watermark value
Extract changed records only
Load staging table
Merge into target table
Update watermark value

Benefits:
```
Faster execution
Reduced source impact
Lower resource consumption
```
---

## 6. Watermark-Based CDC Framework

Supports Change Data Capture using configurable watermark columns.

Example:

```
CreatedDate
UpdatedDate
LastModifiedDate
ModifiedTimestamp
```
Watermark values are stored centrally and updated after successful execution.

---

## 7. Generic Dynamic MERGE Procedure
A reusable SQL stored procedure performs:

Dynamic column detection
Insert operations
Update operations
Watermark updates

Benefits:
```
No table-specific merge logic
Reusable across all entities
Reduced maintenance effort
```

---

## 8. Dependency-Based Execution
Tables are processed according to metadata-defined dependency order.

Example:
```
Customers
    ↓
Orders
    ↓
Order_Details
```

This ensures referential integrity and proper load sequencing.

---

## 9. Dynamic Table Selection

The framework supports:

Run Entire Schedule
```
SC01
```

Run Specific Tables
```
Customer
Orders
Products
```

Run Multiple Tables
```
Customer,Orders,Products
```
without modifying pipeline code.



## 10. Parameterized Design

Reusable components:

Pipelines
Datasets
Linked Services
SQL Queries
Stored Procedures

No hardcoded database or table names.


## 11. Metadata Tables
Metadata_Config

Stores ETL configuration for all source tables.

| Column          | Description        |
| --------------- | ------------------ |
| TableName       | Source table       |
| SourceDB        | Source database    |
| SourceSchema    | Source schema      |
| SourceTable     | Source table       |
| TargetSchema    | Target schema      |
| StagingTable    | Staging table      |
| LoadType        | FULL / INCREMENTAL |
| WatermarkColumn | Incremental column |
| DependencyOrder | Execution sequence |
| ScheduleCode    | Pipeline routing   |

Schedule_Codes

Controls execution groups.
| Column       | Description             |
| ------------ | ----------------------- |
| ScheduleCode | Execution identifier    |
| Is_Active    | Active status           |
| Belong_DB    | Source database mapping |


Watermark_Control

Tracks incremental loading progress.
| Column             | Description          |
| ------------------ | -------------------- |
| TargetTable        | Target entity        |
| LastWatermarkValue | Last processed value |
| LastRunTime        | Execution timestamp  |
| Is_Active          | Active status        |



Master_Run_Log

Stores execution history.
| Column    | Description          |
| --------- | -------------------- |
| RunId     | Execution identifier |
| StartTime | Pipeline start       |
| EndTime   | Pipeline end         |
| Status    | Success / Failed     |
| Remarks   | Execution notes      |


## 12. Execution Flow
## Step 1 – Metadata Lookup

Master Pipeline retrieves active configurations from metadata tables.

<img width="1645" height="912" alt="Screenshot 2026-06-11 122615" src="https://github.com/user-attachments/assets/21a2d5a3-4eaf-43f7-8b24-e6eb36e6fad6" />

## Step 2 – ForEach Iteration

Pipeline iterates through all eligible metadata records.

<img width="1920" height="969" alt="Screenshot 2026-06-11 122919" src="https://github.com/user-attachments/assets/b0339bc0-2dea-495c-a84a-e8a61698712c" />


## Step 3 – Schedule Routing

Switch Activity determines which child pipeline to execute.

<img width="1920" height="1080" alt="Screenshot 2026-06-11 122950" src="https://github.com/user-attachments/assets/be3356d8-0728-458e-a0b5-a285868508c7" />


## Step 4 – Data Extraction

Source data is extracted from source systems.

<img width="1920" height="1024" alt="Screenshot 2026-06-11 123437" src="https://github.com/user-attachments/assets/856ce436-2399-4db7-bf4c-2dc8bbb40937" />


## Step 5 – Staging Load

Data is loaded into staging tables.

<img width="1920" height="1035" alt="Screenshot 2026-06-11 123517" src="https://github.com/user-attachments/assets/aaf28b42-a7b9-4454-8de0-c46d31e27e22" />


## Step 6 – Merge Processing & Watermark Update

Generic MERGE procedure updates target warehouse tables and Watermark values are updated after successful execution.

```
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
```

---

# 📂 Project Structure

```text
Metadata-Driven-ETL-Framework
│
├── adf
│   ├── updated_master.json
│   ├── DB_1_PIPE.json
│   ├── DB_2_PIPE.json
│   ├── DB_3_PIPE.json
│   └── DB_4_PIPE.json
│
├── sql
│   ├── metadata_tables.sql
│   ├── watermark_control.sql
│   ├── logging_tables.sql
│   ├── source_tables.sql
│   ├── target_tables.sql
│   └── SP_GENERIC_MERGE.sql
│
├── images
│   ├── architecture.png
│   ├── master_pipeline.png
│   ├── metadata_lookup.png
│   ├── foreach_pipeline.png
│   ├── switch_activity.png
│   ├── staging_load.png
│   └── generic_merge.png
│   
│
└── README.md
```
---

# Parameters

## Master Pipeline Parameters

| Parameter | Description |
|------------|-------------|
| TableList | Comma-separated tables |
| ScCode | Schedule code |

Example:

```json
{
  "TableList": "Customer,Orders",
  "ScCode": "SC01"
}
```

##  Technology Stack
| Category          | Technology         |
| ----------------- | ------------------ |
| Data Integration  | Azure Data Factory |
| Database          | SQL Server         |
| ETL Framework     | Metadata Driven    |
| Incremental Loads | Watermark Based    |
| Orchestration     | ADF Pipelines      |
| Data Warehouse    | SQL Server         |
| Programming       | T-SQL              |
| Version Control   | Git & GitHub       |

---
## Business Benefits

✅ Scalable Architecture

✅ Faster Onboarding of New Tables

✅ Reduced Development Effort

✅ Reusable ETL Components

✅ Supports Multiple Source Systems

✅ Centralized Configuration Management

✅ Incremental Loading Support

✅ Enterprise-Ready Design

✅ Reduced Maintenance Costs


## 📸 Screenshots
Master Pipeline
<img width="1920" height="1080" alt="Screenshot 2026-06-11 110744" src="https://github.com/user-attachments/assets/07523b5e-b878-49ba-94eb-999ff8bf0467" />

Child Pipeline

<img width="1920" height="1080" alt="Screenshot 2026-06-11 111004" src="https://github.com/user-attachments/assets/bbbc4e2c-00a2-4af3-8bad-45998d236813" />
