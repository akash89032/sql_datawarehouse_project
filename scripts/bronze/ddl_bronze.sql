/*
===============================================================================
DDL Script: Create Bronze Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'bronze' schema, dropping existing tables 
    if they already exist.
	  Run this script to re-define the DDL structure of 'bronze' Tables
===============================================================================
*/
CREATE or ALTER PROCEDURE bronze.load_bronze as
BEGIN
    DECLARE @start_time DATETIME,
            @end_time DATETIME,
            @total_start_time DATETIME,
            @total_end_time DATETIME;
    BEGIN TRY
        SET @total_start_time = GETDATE();
        Print '===============================';
        PRINT 'Loading data into Bronze tables';
        PRINT '===============================';

        PRINT '--------------------------------';
        PRINT 'Loading CRM Tables';
        print '--------------------------------';

        SET @start_time = GETDATE();
        print '>>Truncating Table: bronze.crm_cust_info';
        TRUNCATE TABLE bronze.crm_cust_info;
        PRINT '>>Inserting data into Table: bronze.crm_cust_info';
        BULK INSERT bronze.crm_cust_info
        from 'C:\Users\Public\Downloads\datasets\source_crm\cust_info.csv'
        with (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            tablock
        );
        set @end_time = GETDATE();
        PRINT 'Time taken to load bronze.crm_cust_info: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(10)) + ' seconds';
        PRINT '--------------------------------';

        SET @start_time = GETDATE();
        PRINT '>>Truncating Table: bronze.crm_prd_info';
        truncate table bronze.crm_prd_info;
        PRINT '>>Inserting data into Table: bronze.crm_prd_info';
        BULK INSERT bronze.crm_prd_info
        from 'C:\Users\Public\Downloads\datasets\source_crm\prd_info.csv'
        with (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            tablock
        );
        set @end_time = GETDATE();
        PRINT 'Time taken to load bronze.crm_prd_info: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(10)) + ' seconds';
        PRINT '--------------------------------';

        SET @start_time = GETDATE();
        PRINT '>>Truncating Table: bronze.crm_sales_details';
        truncate table bronze.crm_sales_details;
        PRINT '>>Inserting data into Table: bronze.crm_sales_details';
        BULK INSERT bronze.crm_sales_details
        from 'C:\Users\Public\Downloads\datasets\source_crm\sales_details.csv'
        with (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            tablock
        );
        set @end_time = GETDATE();
        PRINT 'Time taken to load bronze.crm_sales_details: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(10)) + ' seconds';


        PRINT '--------------------------------';
        PRINT 'Loading ERP Tables';
        print '--------------------------------';


        SET @start_time = GETDATE();
        PRINT '>>Truncating Table: bronze.erp_loc_a101';
        TRUNCATE TABLE bronze.erp_loc_a101;
        PRINT '>>Inserting data into Table: bronze.erp_loc_a101';
        BULK INSERT bronze.erp_loc_a101
        from 'C:\Users\Public\Downloads\datasets\source_erp\loc_a101.csv'
        with (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            tablock
        );
        set @end_time = GETDATE();
        PRINT 'Time taken to load bronze.erp_loc_a101: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(10)) + ' seconds';
        PRINT '--------------------------------';

        SET @start_time = GETDATE();
        PRINT '>>Truncating Table: bronze.erp_cust_az12';
        TRUNCATE TABLE bronze.erp_cust_az12;
        PRINT '>>Inserting data into Table: bronze.erp_cust_az12';
        BULK INSERT bronze.erp_cust_az12
        from 'C:\Users\Public\Downloads\datasets\source_erp\cust_az12.csv'
        with (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            tablock
        );
        set @end_time = GETDATE();
        PRINT 'Time taken to load bronze.erp_cust_az12: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(10)) + ' seconds';
        PRINT '--------------------------------';

        SET @start_time = GETDATE();
        PRINT '>>Truncating Table: bronze.erp_px_cat_g1v2';
        TRUNCATE TABLE bronze.erp_px_cat_g1v2;
        PRINT '>>Inserting data into Table: bronze.erp_px_cat_g1v2';
        BULK INSERT bronze.erp_px_cat_g1v2
        from 'C:\Users\Public\Downloads\datasets\source_erp\px_cat_g1v2.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            tablock
        );
        set @end_time = GETDATE();
        PRINT 'Time taken to load bronze.erp_px_cat_g1v2: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(10)) + ' seconds';
        PRINT '--------------------------------';
        set @total_end_time = GETDATE();
        PRINT 'Total Time taken to load Bronze layer tables: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(10)) + ' seconds';
    END TRY
    BEGIN CATCH
        PRINT 'Error occurred while loading data into Bronze layer tables';
        PRINT ERROR_MESSAGE();
        PRINT Error_Number();
        PRINT Error_State();
        PRINT Error_Severity();
    END CATCH
END
