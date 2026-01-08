/*
================================================================
Stored Procedure: Load Bronze Layer
================================================================
Script Purpose:
      This Stored Procedure loads data into 'bronze' schema from external csv files.
      It performs:
        - Truncates the bronze table before loading the data.
        - Uses the 'Bulk Insert' command to load data into from csv files into tables.

Parameters:
    None.
  This Stored Procedure does not accept any parameters or returns any values.

Usage Example:
    EXEC bronze.load_data;
*/


CREATE OR ALTER PROCEDURE bronze.load_data AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
		SET @batch_start_time = GETDATE();
		PRINT '=============================================';
		PRINT 'LOADING BRONZE LAYER DATA';
		PRINT '=============================================';


		PRINT '---------------------------------------------';
		PRINT 'LOADING CRM TABLES';
		PRINT '---------------------------------------------';

		--INSERTING VALUES INTO CUSTOMER INFO TABLE------

		SET @start_time = GETDATE();
		PRINT '>> TRUNCATING TABLE: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info

		PRINT '>> INSERTING DATA INTO: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\91768\Documents\Data Analytics\Projects\SQL\SQL Projects(Data with Baraa)\Data Warehousing project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK 
			);
		SET @end_time = GETDATE();
		PRINT 'Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'Seconds';
		PRINT '----------------------------------';

		--INSERTING VALUES INTO PRODUCTS INFO TABLE-----------

		SET @start_time = GETDATE();
		PRINT '>> TRUNCATING TABLE: bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info

		PRINT '>> INSERTING DATA INTO: bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\91768\Documents\Data Analytics\Projects\SQL\SQL Projects(Data with Baraa)\Data Warehousing project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK 
			);
		SET @end_time = GETDATE();
		PRINT 'Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'Seconds';
		PRINT '----------------------------------';

		--INSERTING VALUES INTO SALES DETAINLS TABLE-----

		SET @start_time = GETDATE();
		PRINT '>> TRUNCATING TABLE: bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details

		PRINT '>> INSERTING DATA INTO: bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\91768\Documents\Data Analytics\Projects\SQL\SQL Projects(Data with Baraa)\Data Warehousing project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK 
			);
		SET @end_time = GETDATE();
		PRINT 'Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'Seconds';
		PRINT '----------------------------------';


		PRINT '---------------------------------------------';
		PRINT 'LOADING ERP TABLES';
		PRINT '---------------------------------------------';

		--INSERTING VALUES INTO CUSTOMER INFO TABLE2-----
	
		SET @start_time = GETDATE();
		PRINT '>> TRUNCATING TABLE: bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12

		PRINT '>> INSERTING DATA INTO:bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\91768\Documents\Data Analytics\Projects\SQL\SQL Projects(Data with Baraa)\Data Warehousing project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK 
			);
		SET @end_time = GETDATE();
		PRINT 'Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'Seconds';
		PRINT '----------------------------------';

		--INSERTING VALUES INTO LOCATION TABLE-----------
		
		SET @start_time = GETDATE();
		PRINT '>> TRUNCATING TABLE: bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101

		PRINT '>> INSERTING DATA INTO: bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\91768\Documents\Data Analytics\Projects\SQL\SQL Projects(Data with Baraa)\Data Warehousing project\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK 
			);
		SET @end_time = GETDATE();
		PRINT 'Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'Seconds';
		PRINT '----------------------------------';

		--INSERTING VALUES INTO CATEGORY TABLE-----------
		
		SET @start_time = GETDATE();
		PRINT '>> TRUNCATING TABLE: bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2

		PRINT '>> INSERTING DATA INTO: bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\91768\Documents\Data Analytics\Projects\SQL\SQL Projects(Data with Baraa)\Data Warehousing project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK 
			);
		SET @end_time = GETDATE();
		PRINT 'Load Duration:' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + 'Seconds';
		PRINT '----------------------------------';

		SET @batch_end_time = GETDATE();
		PRINT '============================================';
		PRINT 'LOADING BRONZE LAYER COMPLETE';
		PRINT 'Load duration:' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + 'Seconds';
		PRINT '============================================';
	END TRY
	BEGIN CATCH
		PRINT '============================================';
		PRINT 'ERROR OCCURED WHILE LOADING THE BRONZE LAYER';
		PRINT 'ERROR:' + ERROR_MESSAGE();
		PRINT 'ERROR:' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'ERROR:' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT '============================================';
	END CATCH;
END;
